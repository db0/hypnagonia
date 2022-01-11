class_name UTCommon
extends "res://addons/gut/test.gd"

const MAIN_SCENE = preload("res://src/dreamscape/Main.tscn")
var BOARD_SCENE = load("res://src/dreamscape/Board.tscn")
const MOUSE_SPEED := {
	"fast": [10,0.3],
	"slow": [3,0.6],
	"debug": [1,2],
}


var main
var board: Board
var hand: Hand
var deck: DreamPile
var discard: DreamPile
var forgotten: DreamPile

func fake_click(pressed, position, flags=0) -> InputEvent:
	var ev := InputEventMouseButton.new()
	ev.button_index=BUTTON_LEFT
	ev.pressed = pressed
	ev.position = position
	ev.meta = flags
	return ev

func setup_cfc() -> void:
	pass

func setup_main() -> void:
	cfc._setup()
	setup_hypnagonia_testing()
	main = autoqfree(MAIN_SCENE.instance())
	get_tree().get_root().add_child(main)
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
	board = cfc.NMAP.board
#	board.load_test_cards()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # Always reveal the mouseon unclick
	hand = cfc.NMAP.hand
	deck = cfc.NMAP.deck
	discard = cfc.NMAP.discard
	forgotten = cfc.NMAP.forgotten


func setup_board() -> void:
	cfc._setup()
	setup_hypnagonia_testing()
	board = add_child_autofree(BOARD_SCENE.instance())
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # Always reveal the mouseon unclick
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")
#	board.load_test_cards()
	hand = cfc.NMAP.hand
	deck = cfc.NMAP.deck
	discard = cfc.NMAP.discard
	forgotten = cfc.NMAP.forgotten

func teardown_board() -> void:
	cfc.quit_game()


func setup_hypnagonia_testing() -> void:
	# warning-ignore:return_value_discarded
	NewGameMenu.randomize_aspect_choices()
	cfc.game_rng_seed = CFUtils.generate_random_seed()
	globals.player.setup()
	globals.encounters.prepare_next_act()


func teardown_hypnagonia_testing() -> void:
	cfc.quit_game()
	globals.reset()



func setup_test_cards(cards: Array) -> Array:
	var spawned_cards := []
	for c in cards:
		var ce = CardEntry.new(c)
		var card = ce.instance_self()
		cfc.NMAP.hand.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()
		spawned_cards.append(card)
	for c in spawned_cards:
		c.reorganize_self()
	return(spawned_cards)

func click_card(card: Card, _use_fake_mouse := true, offset:=Vector2(0,0)) -> void:
	var fc:= fake_click(true, offset)
	card._on_Card_gui_input(fc)

func unclick_card(card: Card) -> void:
	var fc:= fake_click(false, card.global_position)
	card._on_Card_gui_input(fc)

# We need this for targetting arrows which don't release back on the card gui
func unclick_card_anywhere(card: Card) -> void:
	var fc:= fake_click(false, card.global_position)
	card._input(fc)


func drag_card(card: Card, target_position: Vector2, interpolation_speed := "fast") -> void:
	var mouse_speed = MOUSE_SPEED[interpolation_speed][0]
	var mouse_yield_wait = MOUSE_SPEED[interpolation_speed][1]
	var extra_offset = Vector2(20,20)
	if card.card_rotation in [90,270]:
		extra_offset = Vector2(10,60)
	board._UT_interpolate_mouse_move(card.global_position + extra_offset,
			board._UT_mouse_position,mouse_speed)
	yield(yield_for(mouse_yield_wait), YIELD)
	click_card(card)
	if interpolation_speed == "debug":
		yield(yield_for(4), YIELD) # Allow for review
	else:
		yield(yield_for(0.3), YIELD) # Wait to allow dragging to start
	board._UT_interpolate_mouse_move(target_position,board._UT_mouse_position,mouse_speed)
	yield(yield_for(mouse_yield_wait), YIELD)


func drop_card(card: Card, drop_location: Vector2) -> void:
	var fc:= fake_click(false, drop_location)
	card._on_Card_gui_input(fc)
	yield(yield_to(card._tween, "tween_all_completed", 1), YIELD)


# Takes care of simple drag&drop requests
func drag_drop(card: Card, target_position: Vector2, interpolation_speed := "fast") -> void:
	yield(drag_card(card,target_position,interpolation_speed), 'completed')
	yield(drop_card(card,board._UT_mouse_position), 'completed')
	yield(yield_for(0.1), YIELD) # Wait to allow dragging to start
	card._on_Card_mouse_exited()

# Interpolates the virtual mouse so that it correctly targets a card
func target_card(source: Card,
		target: Card, interpolation_speed := "fast") -> void:
	var mouse_speed = MOUSE_SPEED[interpolation_speed][0]
	var mouse_yield_wait = MOUSE_SPEED[interpolation_speed][1]
	if source == target:
		# If the target is the same as the source, we need to wait a bit
		# because otherwise the _is_targeted might not be set yet.
		yield(yield_for(0.6), YIELD)
	# We need to offset a bit towards the card rect, to ensure the arrow
	# Area2D collides
	var extra_offset = Vector2(10,10)
	if target.card_rotation in [90,270]:
		extra_offset = Vector2(10,100)
	board._UT_interpolate_mouse_move(target.global_position + extra_offset,
			source.global_position,mouse_speed)
	yield(yield_for(mouse_yield_wait), YIELD)
	var repeat := 0
	while not target.highlight.visible and repeat <= 3:
		board._UT_interpolate_mouse_move(target.global_position + extra_offset,
				board._UT_mouse_position,mouse_speed)
		yield(yield_for(mouse_yield_wait), YIELD)
		repeat += 1
	unclick_card_anywhere(source)


func table_move(card: Card, pos: Vector2) -> void:
	card.move_to(board, -1, pos)
	yield(yield_to(card._tween, "tween_all_completed", 0.5), YIELD)
#	if cfc.game_settings.fancy_movement:
#		yield(yield_to(card._tween, "tween_all_completed", 0.5), YIELD)

func move_mouse(target_position: Vector2, interpolation_speed := "fast") -> void:
	var mouse_speed = MOUSE_SPEED[interpolation_speed][0]
	var mouse_yield_wait = MOUSE_SPEED[interpolation_speed][1]
	board._UT_interpolate_mouse_move(target_position,board._UT_mouse_position,mouse_speed)
	yield(yield_for(mouse_yield_wait), YIELD)

func execute_with_yield(card: Card) -> void:
	var sceng = card.execute_scripts()
	if sceng is GDScriptFunctionState and sceng.is_valid():
		sceng = yield(yield_to(sceng, "completed", 1), YIELD)
	return sceng


func execute_with_target(card: Card, target) -> void:
	var sceng = card.execute_scripts()
	if target as Card:
		target_card(card,target,"fast")
	else:
		target_entity(card,target,"fast")
	sceng = yield(sceng, "completed")


# Interpolates the virtual mouse so that it correctly targets a card
func target_entity(source: Card,
		target: CombatEntity, interpolation_speed := "fast") -> void:
	var mouse_speed = MOUSE_SPEED[interpolation_speed][0]
	var mouse_yield_wait = MOUSE_SPEED[interpolation_speed][1]
	if source == target:
		# If the target is the same as the source, we need to wait a bit
		# because otherwise the _is_targeted might not be set yet.
		yield(yield_for(0.6), YIELD)
	# We need to offset a bit towards the card rect, to ensure the arrow
	# Area2D collides
	var extra_offset = Vector2(10,10)
	if target.card_rotation in [90,270]:
		extra_offset = Vector2(10,100)	
	board._UT_interpolate_mouse_move(target.area2d.global_position + extra_offset,
			source.global_position,mouse_speed)
	yield(yield_for(mouse_yield_wait), YIELD)
	unclick_card_anywhere(source)
	
# Interpolates the virtual mouse so that it correctly targets a card
func hover_on_card(target: DreamCard, interpolation_speed := "fast") -> void:
	var mouse_speed = MOUSE_SPEED[interpolation_speed][0]
	var mouse_yield_wait = MOUSE_SPEED[interpolation_speed][1]
	# We need to offset a bit towards the card rect, to ensure the arrow
	# Area2D collides
	var extra_offset = Vector2(20,20)
	board._UT_interpolate_mouse_move(target.global_position + extra_offset,
			board._UT_mouse_position,mouse_speed)
	yield(yield_for(mouse_yield_wait), YIELD)
	var repeat := 0
	while not target.highlight.visible and repeat <= 3:
		board._UT_interpolate_mouse_move(target.global_position + extra_offset,
				board._UT_mouse_position,mouse_speed)
		yield(yield_for(mouse_yield_wait), YIELD)
		repeat += 1

# Execute against a target without targeting arrow wait.
func snipexecute(card: Card, target: CombatEntity):
	var sceng = card.execute_scripts()
	if not card.targeting_arrow.is_targeting:
		yield(yield_to(card.targeting_arrow, "initiated_targeting", 1), YIELD)
	card.targeting_arrow.preselect_target(target)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	elif sceng and not sceng.all_tasks_completed:
		yield(yield_to(sceng, "tasks_completed", 0.2), YIELD)
	return(sceng)



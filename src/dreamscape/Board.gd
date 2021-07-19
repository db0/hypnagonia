extends Board

const ENEMY_ENTITY_SCENE = preload("res://src/dreamscape/CombatElements/Enemies/EnemyEntity.tscn")

var end_turn : Button
var turn := Turn.new()
var dreamer: PlayerEntity
var activated_enemies: Array
var boss_battle := false

onready var bottom_gui := $VBC/HBC
onready var _player_area := $VBC/CombatArena/PlayerArea
onready var _enemy_area := $VBC/CombatArena/EnemyArea/Enemies
onready var _combat_arena := $VBC/CombatArena
onready var _background := $Background
onready var _bg_tint := $BackgroundTint
onready var _board_cover := $FadeToBlack
onready var _tween := $Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_board_cover.visible = true
	counters = $VBC/HBC/Counters
	end_turn = $VBC/HBC/EndTurn
	cfc.map_node(self)
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed",self,"_on_viewport_resized")
	# We use the below while to wait until all the nodes we need have been mapped
	# "hand" should be one of them.
	# We're assigning our positions programmatically,
	# instead of defining them on the scene.
	# This way any they will work with any size of viewport in a game.
	# Discard pile goes bottom right
	if not get_tree().get_root().has_node('Gut'):
		load_deck()
	turn.setup()
	dreamer = preload("res://src/dreamscape/CombatElements/PlayerEntity.tscn").instance()
	var dreamer_properties := {
		"Health": globals.player.health,
		"Damage": globals.player.damage,
		"Type": "Dreamer",
		"_texture_size_x": globals.PLAYER_COMBAT_ENTITY_SIZE.x,
		"_texture_size_y": globals.PLAYER_COMBAT_ENTITY_SIZE.y,
	}
	dreamer.setup("Dreamer", dreamer_properties)
	# warning-ignore:return_value_discarded
	dreamer.connect("entity_killed", self, "_dreamer_died")
	_player_area.add_child(dreamer)
	dreamer.rect_position = Vector2(100,100)
# warning-ignore:unused_variable
#	var torment = spawn_enemy("Clown")
#	var torment2 = spawn_enemy("The Critic")
#	var torment3 = spawn_enemy("Gaslighter")
#	var torment2 = spawn_enemy("Gaslighter")
#	torment2.rect_position = Vector2(800,100)
#	torment3.rect_position = Vector2(200,300)
#	dreamer.active_effects.mod_effect(ActiveEffects.NAMES.disempower, 5)
#	dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison.name, 5)
#	dreamer.active_effects.mod_effect(ActiveEffects.NAMES.empower, 2)
#	torment.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison.name, 60)
	_on_viewport_resized()
#	begin_encounter()
#
func _process(_delta: float) -> void:
	if cfc.game_paused and cfc.NMAP.main._current_focus_source:
		cfc.NMAP.main.unfocus_all()

func begin_encounter() -> void:
	cfc.game_paused = false
	randomize_background()
	_fade_from_black()
	yield(_tween, "tween_all_completed")
	cfc.NMAP.hand.refill_hand()
	_on_player_turn_started(turn)

func randomize_background() -> void:
	var dark_backgrounds := CFUtils.list_imported_in_directory("res://assets/backgrounds/dark/")
	var bright_backgrounds := CFUtils.list_imported_in_directory("res://assets/backgrounds/bright/")
	var all_backgrounds := dark_backgrounds + bright_backgrounds
	CFUtils.shuffle_array(all_backgrounds)
	var selected_background :String = all_backgrounds[0]
	var bpath: String
	if selected_background in bright_backgrounds:
		bpath = "res://assets/backgrounds/bright/"
		_bg_tint.visible = true
		print_debug(_bg_tint.visible)
	else:
		bpath = "res://assets/backgrounds/dark/"
	var background_resource: String = bpath + selected_background
	var tex = load(background_resource)
	var new_texture = ImageTexture.new();
	var image = tex.get_data()
	new_texture.create_from_image(image)
	_background.texture = new_texture

func spawn_enemy_encounter(encounter: EnemyEncounter) -> void:
	for enemy_properties in encounter.enemies:
# warning-ignore:return_value_discarded
		spawn_enemy(enemy_properties)

func spawn_enemy(enemy_properties) -> EnemyEntity:
	if get_tree().get_nodes_in_group("EnemyEntities").size() >= 5:
		return(null)
	var enemy : EnemyEntity = ENEMY_ENTITY_SCENE.instance()
	enemy.setup(enemy_properties.Name, enemy_properties)
	enemy.entity_type = Terms.ENEMY
	_enemy_area.add_child(enemy)
	# warning-ignore:return_value_discarded
	enemy.connect("finished_activation", self, "_on_finished_enemy_activation")
	# warning-ignore:return_value_discarded
	enemy.connect("entity_killed", self, "_enemy_died")
	return(enemy)

func spawn_boss_encounter(encounter: BossEncounter) -> EnemyEntity:
	var boss_entity: EnemyEntity = encounter.boss_scene.instance()
	boss_entity.setup_boss()
	_enemy_area.add_child(boss_entity)
	# warning-ignore:return_value_discarded
	boss_entity.connect("finished_activation", self, "_on_finished_enemy_activation")
	# warning-ignore:return_value_discarded
	boss_entity.connect("entity_killed", self, "_enemy_died")
	boss_battle = true
	return(boss_entity)

# This function is to avoid relating the logic in the card objects
# to a node which might not be there in another game
# You can remove this function and the FancyMovementToggle button
# without issues
func _on_FancyMovementToggle_toggled(_button_pressed) -> void:
#	cfc.game_settings.fancy_movement = $FancyMovementToggle.pressed
	cfc.set_setting('fancy_movement', $FancyMovementToggle.pressed)


func _on_OvalHandToggle_toggled(_button_pressed: bool) -> void:
	cfc.set_setting("hand_use_oval_shape", $OvalHandToggle.pressed)
	for c in cfc.NMAP.hand.get_all_cards():
		c.reorganize_self()


# Reshuffles all Card objects created back into the deck
func _on_ReshuffleAllDeck_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.deck)


func _on_ReshuffleAllDiscard_pressed() -> void:
	reshuffle_all_in_pile(cfc.NMAP.discard)


func reshuffle_all_in_pile(pile = cfc.NMAP.deck):
	for c in get_tree().get_nodes_in_group("cards"):
		if c.get_parent() != pile:
			c.move_to(pile)
			yield(get_tree().create_timer(0.1), "timeout")
	# Last card in, is the top card of the pile
	var last_card : Card = pile.get_top_card()
	if last_card._tween.is_active():
		yield(last_card._tween, "tween_all_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	pile.shuffle_cards()


# Button to change focus mode
func _on_ScalingFocusOptions_item_selected(index) -> void:
	cfc.set_setting('focus_style', index)


# Button to make all cards act as attachments
func _on_EnableAttach_toggled(button_pressed: bool) -> void:
	for c in get_tree().get_nodes_in_group("cards"):
		c.is_attachment = button_pressed


func _on_Debug_toggled(button_pressed: bool) -> void:
	cfc._debug = button_pressed

func get_all_scriptables() -> Array:
	return(get_tree().get_nodes_in_group("CombatEntities") + get_all_cards())


# Loads the player's deck
func load_deck() -> void:
	if not globals.player.deck:
		NewGameMenu.randomize_archetype_choices()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		globals.player.setup()
		globals.encounters.setup()
	for card in globals.player.deck.instance_cards():
		cfc.NMAP.deck.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()
		cfc.NMAP.deck.shuffle_cards(false)


func _on_player_turn_started(_turn: Turn) -> void:
	while not  cfc.NMAP.hand.is_hand_refilled:
		yield(cfc.NMAP.hand, "hand_refilled")
	while cfc.NMAP.hand.are_cards_still_animating():
		yield(get_tree().create_timer(0.3), "timeout")
	if is_instance_valid(dreamer) and not dreamer.is_dead:
		end_turn.disabled = false


func _on_player_turn_ended(_turn: Turn) -> void:
	end_turn.disabled = true
	turn.start_enemy_turn()

func _on_enemy_turn_started(_turn: Turn) -> void:
	# We delay, to allow effects like poison to activate first
	yield(get_tree().create_timer(1), "timeout")
	# I want the enemies to activate serially
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		# It might have died of poison in the meantime
		if is_instance_valid(enemy):
#		print_debug("Activating Intents: " + enemy.canonical_name)
			enemy.activate()
			yield(enemy, "finished_activation")

func _on_enemy_turn_ended(_turn: Turn) -> void:
	activated_enemies.clear()

func _on_finished_enemy_activation(enemy: EnemyEntity) -> void:
	if not enemy in activated_enemies:
		activated_enemies.append(enemy)
	if activated_enemies.size() == get_tree().get_nodes_in_group("EnemyEntities").size():
		turn.end_enemy_turn()
		turn.start_player_turn()

func _enemy_died() -> void:
	yield(get_tree().create_timer(2), "timeout")
	if get_tree().get_nodes_in_group("EnemyEntities").size() == 0:
		complete_battle()

func _dreamer_died() -> void:
	yield(get_tree().create_timer(1), "timeout")
	game_over()

func complete_battle() -> void:
	globals.player.damage = dreamer.damage
	_fade_to_transparent()
	yield(_tween, "tween_all_completed")
	globals.current_encounter.end()
#	cfc.game_paused = true
#	mouse_pointer.forget_focus()
#	end_turn.disabled = true
#	post_battle_menu.display()
#	for card in get_tree().get_nodes_in_group("cards"):
#		card.set_to_idle()

func game_over() -> void:
	_fade_to_transparent()
	yield(_tween, "tween_all_completed")
	globals.current_encounter.game_over()
#	cfc.game_paused = true
#	mouse_pointer.forget_focus()
#	end_turn.disabled = true
#	game_over_notice.rect_global_position = get_viewport().size/2 - game_over_notice.rect_size/2
#	game_over_notice.visible = true
#	for card in get_tree().get_nodes_in_group("cards"):
#		card.set_to_idle()


func _input(event):
	if event.is_action_pressed("init_debug_game"):
		begin_encounter()
	if event.is_action_pressed("debug"):
		_on_Debug_pressed()
	if event.is_action_pressed("complete_battle"):
		complete_battle()
	if event.is_action_pressed("lose_battle"):
		game_over()

func _on_Debug_pressed() -> void:
	# warning-ignore:return_value_discarded
	counters.mod_counter("immersion",10)
	for _iter in range(5):
		cfc.NMAP.hand.draw_card(cfc.NMAP.deck)

func _on_viewport_resized() -> void:
	_background.rect_min_size = get_viewport().size
	_background.rect_size = get_viewport().size
#	bottom_gui.rect_position = cfc.NMAP.deck.position - Vector2(0,50)


func _on_BackToMain_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(CFConst.PATH_CUSTOM + "MainMenu/MainMenu.tscn")
	globals.reset()
	cfc.NMAP.clear()

func _fade_to_black() -> void:
	_board_cover.visible = true
	_tween.interpolate_property(_board_cover,
			'modulate:a', 0, 1, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()


func _fade_from_black() -> void:
	_tween.interpolate_property(_board_cover,
			'modulate:a', 1, 0, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()
	yield(_tween, "tween_all_completed")
	_board_cover.visible = false

func _fade_to_transparent() -> void:
	_tween.interpolate_property(cfc.NMAP.main,
			'modulate:a', 1, 0, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()

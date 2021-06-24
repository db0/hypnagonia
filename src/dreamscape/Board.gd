extends Board

const CARD_GROUPS = preload("res://src/dreamscape/cards/sets/CardGroups.gd")
const ENEMY_ENTITY_SCENE = preload("res://src/dreamscape/CombatElements/Enemies/EnemyEntity.tscn")

var end_turn : Button
var turn := Turn.new()
var dreamer: PlayerEntity
var enemies: Array
var activated_enemies: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	counters = $HBC/Counters
	end_turn = $HBC/EndTurn
	cfc.map_node(self)
	# We use the below while to wait until all the nodes we need have been mapped
	# "hand" should be one of them.
	# We're assigning our positions programmatically,
	# instead of defining them on the scene.
	# This way any they will work with any size of viewport in a game.
	# Discard pile goes bottom right
	if not get_tree().get_root().has_node('Gut'):
		load_test_cards()
	turn.setup()
	dreamer = preload("res://src/dreamscape/CombatElements/PlayerEntity.tscn").instance()
	var dreamer_properties := {
		"Health": 100,
		"Max Health": 100,
		"Type": "Dreamer",
		"_texture_size_x": 70,
		"_texture_size_y": 100,
	}
	dreamer.setup("Dreamer", dreamer_properties)
	add_child(dreamer)
	dreamer.rect_position = Vector2(100,100)
	var torment = spawn_enemy("Gaslighter")
	var torment2 = spawn_enemy("Gaslighter")
	torment2.rect_position = Vector2(800,100)
#	dreamer.active_effects.mod_effect(ActiveEffects.NAMES.disempower, 5)
#	dreamer.active_effects.mod_effect(ActiveEffects.NAMES.poison, 5)
#	dreamer.active_effects.mod_effect(ActiveEffects.NAMES.empower, 2)
#	torment.active_effects.mod_effect(ActiveEffects.NAMES.empower, 5)

func spawn_enemy(enemy_name) -> EnemyEntity:
	var enemy_properties = EnemyDefinitions.ENEMIES.get(enemy_name)
	var enemy : EnemyEntity = ENEMY_ENTITY_SCENE.instance()
	enemy.setup(enemy_name, enemy_properties)
	add_child(enemy)
	enemies.append(enemy)
	enemy.connect("finished_activation", self, "_on_finished_enemy_activation")
	enemy.rect_position = Vector2(500,100)
	return(enemy)

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

# Loads a sample set of cards to use for testing
func load_test_cards() -> void:
	var test_deck = {
		"class": "Flyer",
		"race": "Fearless",
		"item": "Rubber Chicken",
		"life_goal": "Abusive Relationship",
	}
	var test_card_array := []
	for card_name in assemble_starting_deck(test_deck):
		test_card_array.append(cfc.instance_card(card_name))
	for card in test_card_array:
		$Deck.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()


func assemble_starting_deck(starting_deck_groups: Dictionary) -> Array:
	var all_cards : Array
	for key in starting_deck_groups:
		all_cards += CARD_GROUPS[key.to_upper()][starting_deck_groups[key]]["Starting Cards"]
	return(all_cards)

	

func _on_DeckBuilder_pressed() -> void:
	cfc.game_paused = true
	$DeckBuilderPopup.popup_centered_minsize()

func _on_DeckBuilder_hide() -> void:
	cfc.game_paused = false

func _on_turn_started(turn: Turn) -> void:
	pass

func _on_turn_ended(turn: Turn) -> void:
	activated_enemies.clear()
	for enemy in enemies:
#		print_debug("Activating Intents: " + enemy.canonical_name)
		enemy.activate()
	

func _on_finished_enemy_activation(enemy: EnemyEntity) -> void:
	if not enemy in activated_enemies:
		activated_enemies.append(enemy)
	if activated_enemies.size() == enemies.size():
		turn.start_turn()

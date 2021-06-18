extends Board

var end_turn : Button
var turn := Turn.new()
var dreamer: PlayerEntity
var enemies: Array

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
	end_turn.connect("pressed", self, "_on_end_turn_pressed")
	dreamer = preload("res://src/dreamscape/PlayerEntity.tscn").instance()
	var dreamer_properties := {
		"health": 100,
		"max_health": 100,
		"name": "Dreamer",
		"texture_size_x": 70,
		"texture_size_y": 100,
		"type": "Dreamer",
	}
	dreamer.setup(dreamer_properties)
	add_child(dreamer)


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
	var card_names = []
	var test_cards := []
	for ckey in cfc.card_definitions.keys():
		if ckey != "Spawn Card":
			card_names.append(ckey)
	var test_card_array := []
	for _i in range(12):
		if not card_names.empty():
			var random_card_name = \
					card_names[CFUtils.randi() % len(card_names)]
			test_card_array.append(cfc.instance_card(random_card_name))
	# 11 is the cards GUT expects. It's the testing standard
	# I ensure there's of each test card, for use in GUT
	for card_name in test_cards:
		test_card_array.append(cfc.instance_card(card_name))
	for card in test_card_array:
		$Deck.add_child(card)
		#card.set_is_faceup(false,true)
		card._determine_idle_state()

func _on_DeckBuilder_pressed() -> void:
	cfc.game_paused = true
	$DeckBuilderPopup.popup_centered_minsize()

func _on_DeckBuilder_hide() -> void:
	cfc.game_paused = false

func _on_end_turn_pressed() -> void:
	cfc.NMAP.hand.refill_hand()
	counters.mod_counter("immersion", 3, true, false, turn, ["New Turn"])

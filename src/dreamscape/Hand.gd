extends Hand

signal hand_refilled
signal hand_emptied
signal cards_fused(card,trigger,details)

var is_hand_refilled := false
var refill_amount := 5
var discard_at_turn_end := true
var cards_in_fusion := []

func _ready() -> void:
	connect("cards_fused", cfc.signal_propagator, "_on_signal_received")

func empty_hand() -> void:
	is_hand_refilled = false
	for card in get_all_cards():
		if Terms.GENERIC_TAGS.frozen.name in card.get_property("Tags"):
			continue
		if card.state == DreamCard.ExtendedCardState.REMOVE_FROM_GAME:
			continue
		yield(get_tree().create_timer(0.05), "timeout")
		card.move_to(cfc.NMAP.discard)
	emit_signal("hand_emptied")

func refill_hand(amount = refill_amount) -> void:
	for _iter in range(amount):
		var retcode = draw_card(cfc.NMAP.deck)
		if retcode == null:
			break
		elif retcode is GDScriptFunctionState:
			retcode = yield(retcode, "completed")
		else:
			yield(get_tree().create_timer(0.05), "timeout")
	is_hand_refilled = true
	emit_signal("hand_refilled")


func are_cards_still_animating() -> bool:
	for c in get_all_cards():
		if c.state in [Card.CardState.MOVING_TO_CONTAINER]:
			return(true)
	return(false)


# Takes the top card from the specified [CardContainer]
# and adds it to this node
# Returns a card object drawn
func draw_card(pile : Pile = cfc.NMAP.deck) -> Card:
	var card: Card = pile.get_top_card()
	# A basic function to pull a card from out deck into our hand.
	if not card:
		cfc.NMAP.discard.reshuffle_in_deck()
		yield(pile, "shuffle_completed")
		card = pile.get_top_card()
	if card:
		card.move_to(self)
		_check_for_fusion(card)
	return card

# Override to ignore executing cards
func get_all_cards() -> Array:
	var cardsArray := []
	for obj in get_children():
		# We want dragged cards to not be taken into account
		# when reorganizing the hand (so that their gap closes immediately)
		if not obj is Card:
			continue
		if not is_instance_valid(obj):
			continue
		if obj == cfc.card_drag_ongoing:
			continue
		if obj.is_executing_scripts:
			continue
		cardsArray.append(obj)
	return cardsArray

func _on_player_turn_started(_turn: Turn) -> void:
	pass

func _on_player_turn_ended(_turn: Turn) -> void:
	if discard_at_turn_end:
		var retcode  = empty_hand()
		if retcode is GDScriptFunctionState:
			retcode = yield(retcode, "completed")
	refill_hand()

func _check_for_fusion(card) -> void:
	if not card.get_property("Tags").has(Terms.GENERIC_TAGS.fusion.name):
		return
	for c in get_all_cards():
		if c == card:
			continue
		if c in cards_in_fusion:
			continue
		if card in cards_in_fusion:
			continue
		var drawn_card_name : String = card.canonical_name
		var checked_card_name : String = c.canonical_name
		if card.get_property("_is_upgrade"):
			drawn_card_name = card.find_upgrade_parent()
		if c.get_property("_is_upgrade"):
			checked_card_name = c.find_upgrade_parent()
		# This card matches all fusion cards
		var uc = "Universal Component"
		if checked_card_name != drawn_card_name\
				and checked_card_name != uc and drawn_card_name != uc:
			continue
		if not card.get_property("_fuses_into"):
			continue
		if not c.get_property("_fuses_into"):
			continue
		var upgraded_fusion := false
		if card.get_property("_is_upgrade") and c.get_property("_is_upgrade"):
			upgraded_fusion = true
		cards_in_fusion.append(c)
		cards_in_fusion.append(card)
		var fused_card_name : String
		# We need to make sure we do not select the Universal Component fusion
		# unless it's explicitly two Universal Components fusing
		if drawn_card_name == uc and checked_card_name != uc:
			fused_card_name = c.get_property("_fuses_into")
		else:
			fused_card_name = card.get_property("_fuses_into")
		var uc_drawn_cards := 0
		var uc_immersion := 0
		if drawn_card_name == uc:
			uc_drawn_cards += card.get_property("_amounts")["draw_amount"]
			uc_immersion += card.get_property("_amounts")["immersion_amount"]
		if checked_card_name == uc:
			uc_drawn_cards += c.get_property("_amounts")["draw_amount"]
			uc_immersion += c.get_property("_amounts")["immersion_amount"]
		var fused_card_properties = cfc.card_definitions[fused_card_name]
		if upgraded_fusion:
			fused_card_name = fused_card_properties.get("_upgrades")[0]
		c.remove_from_deck(false, ['fusion'])
		card.remove_from_deck(false, ['fusion'])
		var fused_card = cfc.instance_card(fused_card_name)
		cfc.NMAP.board.add_child(fused_card)
		for iter in uc_drawn_cards:
			draw_card()
		# If the turn is current, we simply increase energy immediately
		if cfc.NMAP.board.turn.current_turn == cfc.NMAP.board.turn.Turns.PLAYER_TURN:
			cfc.NMAP.board.counters.mod_counter("immersion", uc_immersion, false, false, null, ["Fusion"])
		else:
			cfc.NMAP.board.dreamer.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.buffer.name, uc_immersion, false, false, ["Fusion"])
		fused_card.scale = Vector2(0.1,0.1)
		fused_card.global_position = c.global_position
		fused_card.spawn_destination = self
		fused_card.state = Card.CardState.MOVING_TO_SPAWN_DESTINATION
		emit_signal("cards_fused",
				fused_card,
				"cards_fused",
				{}
		)
		TurnEventMessage.new("card_fused", +1)

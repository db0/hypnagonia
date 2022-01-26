extends "res://tests/HUTCommon_Ordeal.gd"

class TestGeneric:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func _init() -> void:
		globals.test_flags["no_refill"] = false
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["disable_board_background"] = false

	func test_init():
		assert_is(board._background.texture, ImageTexture, "Random Background loaded")
		assert_false(board._board_cover.visible, "Board Cover Invisible")
		assert_eq(counters.get_counter("immersion"), 3, "Dreamer starts with 3 immersion")
		assert_eq(discard.get_card_count(), 0, "Empty discard")
		assert_eq(hand.get_card_count(), 5, "Hand is filled at start")
		assert_eq(deck.get_card_count(), 7, "Deck at expected amount")
		assert_eq(forgotten.get_card_count(), 0, "Nothing automatically forgotten")
		assert_eq(dreamer.damage, 0, "Dreamer doesn't start with damage automatically somehow")
		assert_eq(test_torment.damage, tdamage(0),"Torment doesn't start with damage automatically somehow")
		assert_eq(turn.current_turn, turn.Turns.PLAYER_TURN, "Turn starts on player's")
		assert_connected(dreamer, board, "entity_killed", "_dreamer_died")
		assert_connected(cfc, board, "cache_cleared", "_recalculate_predictions")
		assert_connected(dreamer, player_info, "entity_damaged", "_on_player_health_changed")
		assert_connected(dreamer, player_info, "entity_healed", "_on_player_health_changed")
		assert_connected(dreamer, player_info, "entity_health_modified", "_on_player_health_changed")
		for turn_signal in turn.ALL_SIGNALS:
			assert_connected(turn, board, turn_signal, "_on_" + turn_signal)
			assert_connected(turn, cfc.signal_propagator, turn_signal, "_on_signal_received")
		for obj in [counters, hand]:
			for turn_signal in turn.PLAYER_SIGNALS:
				# warning-ignore:return_value_discarded
				assert_connected(turn, obj,  turn_signal, "_on_" + turn_signal)

class TestRounds:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"
	
	func _init() -> void:
		globals.test_flags["no_refill"] = false
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_end_turn_delay"] = false

	func test_new_turn():
		watch_signals(turn)
		counters.mod_counter("immersion",5)
		turn.end_player_turn()
		yield(yield_to(turn, "player_turn_started", 3), YIELD)
		assert_eq(counters.get_counter("immersion"), 3, "Dreamer starts each turn with 3 immersion")
		assert_eq(discard.get_card_count(), 5, "All unused cards are discarded")
		assert_eq(hand.get_card_count(), 5, "Hand is refilled")
		assert_eq(deck.get_card_count(), 2, "Cards taken from deck")
		assert_eq(forgotten.get_card_count(), 0, "Nothing automatically forgotten")
		for turn_signal in turn.ALL_SIGNALS:
			assert_signal_emitted(turn, turn_signal, "All turn signals emited")
		assert_eq(turn.current_turn, turn.Turns.PLAYER_TURN, "Turn returns on player's")

		

class TestTags:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	var alpha1: CardEntry
	var alpha2: CardEntry
	var omega1: CardEntry
	
	func _init() -> void:
		globals.test_flags["no_refill"] = false
		globals.test_flags["test_initial_hand"] = true

	func extra_hypnagonia_setup() -> void:
		alpha1 = globals.player.deck.add_new_card("^ Sneaky-Beaky ^")
		alpha2 = globals.player.deck.add_new_card("^ Absurdity Unleashed ^")
		omega1 = globals.player.deck.add_new_card("Ω Excogitate Ω")

	func test_alpha_and_omega():
		assert_true(hand.has_card(alpha1.card_object), "Alpha cards should start in hand")
		assert_true(hand.has_card(alpha2.card_object), "Alpha cards should start in hand")
		assert_eq(deck.get_bottom_card(), omega1.card_object, "Omega cards should start at the deck bottom")

class TestTurnEventRecording:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	var alpha1: CardEntry
	var alpha2: CardEntry
	var omega1: CardEntry
	
	func _init() -> void:
		test_card_names = [
			"Confidence",
			"Confidence",
			"Terror",
			"Butterfly",
			"Nothing to Fear",
		]

	func test_event_recording():
		for c in cards:
			c.properties.Cost = 0
		cards[1].properties.Tags.append(Terms.ACTIVE_EFFECTS.disempower.name)
		cards[1].properties.Tags.append(Terms.ACTIVE_EFFECTS.empower.name)
		cards[0].properties.Tags.append(Terms.GENERIC_TAGS.insomnia.name)
		cards[0].properties.Tags.append(Terms.GENERIC_TAGS.chain.name)
		var sceng
		for exec_card in cards:
			sceng = execute_with_yield(exec_card)
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		var first_turn_event_count = {
			"Chain":1, 
			"Clarity":1, 
			"Concentration_played":1, 
			"Confusion":1, 
			"Control_played":2, 
			"Focus":1, 
			"Immersion":1, 
			"Insomnia":1, 
			"Perturbation_played":1, 
			"Risky":1, 
			"Slumber":1, 
			"Understanding_played":1, 
			"cards_played":5
		}
		assert_eq_deep(turn.turn_event_count, first_turn_event_count)
		assert_eq_deep(turn.encounter_event_count, first_turn_event_count)
		
		turn.end_player_turn()
		yield(yield_to(hand, "hand_refilled", 3), YIELD)
		for index in [0,1]:
			sceng = execute_with_yield(cards[index])
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		var second_turn_event_count =  {
			"Chain":1, 
			"Clarity":1, 
			"Confusion":1, 
			"Control_played":2, 
			"Insomnia":1, 
			"cards_played":2, 
			"deck_shuffled":3
		}
		var second_turn_encounter_events = first_turn_event_count.duplicate()
		for key in second_turn_event_count:
			second_turn_encounter_events[key] = second_turn_encounter_events.get(key,0) + second_turn_event_count[key]
		assert_eq_deep(turn.turn_event_count, second_turn_event_count)
		assert_eq_deep(turn.encounter_event_count, second_turn_encounter_events)

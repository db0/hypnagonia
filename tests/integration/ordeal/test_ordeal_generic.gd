extends "res://tests/HUTCommon_Ordeal.gd"

class TestGeneric:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func _init() -> void:
		globals.test_flags["no_refill"] = false
		globals.test_flags["test_initial_hand"] = true

	func test_init():
		assert_eq(counters.get_counter("immersion"), 3, "Dreamer starts with 3 immersion")
		assert_eq(discard.get_card_count(), 0, "Empty discard")
		assert_eq(hand.get_card_count(), 5, "Hand is filled at start")
		assert_eq(deck.get_card_count(), 7, "Deck at expected amount")
		assert_eq(forgotten.get_card_count(), 0, "Nothing automatically forgotten")
		assert_eq(dreamer.damage, 0, "Dreamer doesn't start with damage automatically somehow")
		assert_eq(test_torment.damage, tdamage(0),"Torment doesn't start with damage automatically somehow")
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
		watch_signals(board)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(discard.get_card_count(), 5, "All unused cards are discarded")
		assert_eq(hand.get_card_count(), 5, "Hand is refilled")
		assert_eq(deck.get_card_count(), 2, "Cards taken from deck")
		assert_eq(forgotten.get_card_count(), 0, "Nothing automatically forgotten")
		for turn_signal in turn.ALL_SIGNALS:
			assert_signal_emitted(turn, turn_signal)
		

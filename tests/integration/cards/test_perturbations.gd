extends "res://tests/HUT_Ordeal_CardTestClass.gd"

class TestScatteredDreams:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.drain.name
	func _init() -> void:
		testing_card_name = "Scattered Dreams"
		expected_amount_keys = [
			"effect_stacks"
		]


	func test_card_results():
		assert_has_amounts()
		yield(yield_for(0.1), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"%s stacks on dreamer not increased when card played" % [effect])
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 3,
				"Immersion not affected by %s" % [testing_card_name])

	func test_card_results_remaining_on_hand():
		assert_has_amounts()
		yield(yield_for(0.1), YIELD)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "enemy_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1,
				"%s stacks on dreamer not increased when card played" % [effect])
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 2,
				"Immersion affected by %s" % [testing_card_name])

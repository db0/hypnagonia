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
		turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 3,
				"Immersion not affected by %s" % [testing_card_name])

	func test_card_results_remaining_on_hand():
		assert_has_amounts()
		yield(yield_for(0.1), YIELD)
		turn.end_player_turn()
		yield(yield_to(board.turn, "enemy_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1,
				"%s stacks on dreamer not increased when card played" % [effect])
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 2,
				"Immersion affected by %s" % [testing_card_name])


class TestCringeworthyMemory:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Cringeworthy Memory"
		expected_amount_keys = [
			"exert_amount"
		]

	func test_card_results():
		assert_has_amounts()
		yield(yield_for(0.1), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 1, "Perturbation did damage")
		assert_eq(card.get_parent(), forgotten, "Pertubration forgotten")


class TestDreamFragment:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags.test_initial_hand = true
		testing_card_name = "Dream Fragment"
		expected_amount_keys = [
			"exert_amount",
			"draw_amount",
		]

	func test_card_results():
		assert_has_amounts()
		watch_signals(card)
		watch_signals(cfc)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_signal_emitted(card, "card_removed")
		assert_signal_emitted(cfc, "new_card_instanced")
		assert_eq(dreamer.damage, 1, "Perturbation did damage")\
		# We check for 2, as the first one will not be freed yet
		assert_eq(count_card_names("Dream Fragment"), 2,
				"Card removed but new one took its place")


class TestDistracted:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags.test_initial_hand = true
		testing_card_name = "Distracted"
		test_card_names = [
			"Inner Justice",
			"Interpretation",
		]
		expected_amount_keys = [
			"immersion_cost",
		]

	func test_card_results():
		assert_has_amounts()
		assert_eq(cards[0].check_play_costs(), CFConst.CostsState.IMPOSSIBLE)
		assert_eq(cards[1].check_play_costs(), CFConst.CostsState.OK)
		assert_eq(cards[2].check_play_costs(), CFConst.CostsState.IMPOSSIBLE)


class TestSuffocation:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Suffocation"
		test_card_names = [
			"Suffocation",
			"Suffocation",
		]
		expected_amount_keys = [
			"exert_amount"
		]

	func test_card_results():
		assert_has_amounts()
		yield(yield_for(0.1), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		turn.end_player_turn()
		yield(yield_to(board.turn, "enemy_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 3, "Only 1 Perturbation did damage")
		assert_eq(card.get_parent(), forgotten, "Pertubration forgotten")


class TestInescepableConclusion:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		test_card_names = [
			"Inescepable Conclusion",
			"Inescepable Conclusion",
		]

	func test_card_results():
		watch_signals(cfc)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		turn.end_player_turn()
		yield(yield_to(board.turn, "enemy_turn_started",3 ), YIELD)
		assert_signal_emit_count(cfc, "new_card_instanced", 1)
		assert_eq(count_card_names("Inescepable Conclusion"), 3,
				"1 New Inescepable Conclusion Added")

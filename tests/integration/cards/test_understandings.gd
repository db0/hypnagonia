extends "res://tests/HUT_Ordeal_CardTestClass.gd"

class TestGaslighter:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.poison.name
	func _init() -> void:
		testing_card_name = "Gaslighter"
		expected_amount_keys = [
			"effect_stacks"
		]


	func test_card_results():
		assert_has_amounts()
		spawn_effect(dreamer, effect, 4)
		yield(yield_for(0.1), YIELD)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"%s stacks on dreamer decreased to 0" % [effect])
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Torment increased by correct amount" % [effect])

class TestChasm:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		testing_card_name = "Chasm"
		expected_amount_keys = [
			"reduction_amount"
		]


	func test_card_results():
		assert_has_amounts()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		yield(yield_for(0.1), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var reduced_cost_cards := 0
		for c in hand.get_all_cards():
			if c.properties.Cost == c.printed_properties.Cost - 1:
				reduced_cost_cards += 1
		assert_eq(reduced_cost_cards, 1, "One card's cost reduced by expected amount")
		assert_eq(card.get_parent(), forgotten)

	func test_card_results_on_x_and_0_cost_cards():
		assert_has_amounts()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		var vc = 'X'
		var card_to_modify: Card
		for c in hand.get_all_cards():
			if c.properties.Cost > 0 and not card_to_modify:
				card_to_modify = c
				continue
			else:
				c.modify_property("Cost", vc)
				if str(vc) == 'X':
					vc = 0
				else:
					vc = 'X'
		yield(yield_for(0.1), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(card_to_modify.properties.Cost, card_to_modify.printed_properties.Cost - 1, "One card's cost reduced by 1")
		for c in hand.get_all_cards():
			if c != card_to_modify:
				assert_has([0, 'X'], c.properties.Cost, "All other cards left unmodified")
		assert_eq(card.get_parent(), forgotten)

class TestYawningChasm:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		testing_card_name = "Yawning Chasm"
		expected_amount_keys = [
			"reduction_amount"
		]


	func test_card_results():
		assert_has_amounts()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		yield(yield_for(0.1), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var reduced_cost_cards := 0
		for c in hand.get_all_cards():
			if c.properties.Cost == c.printed_properties.Cost - 1:
				reduced_cost_cards += 1
		assert_eq(reduced_cost_cards, 1, "One card's cost reduced by expected amount")
		assert_eq(card.get_parent(), discard)

class TestSteepChasm:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		testing_card_name = "Steep Chasm"
		expected_amount_keys = [
			"reduction_amount"
		]

	func test_card_results():
		assert_has_amounts()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		for c in hand.get_all_cards():
			if c != card:
				c.modify_property("Cost", 4)
		yield(yield_for(0.1), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var reduced_cost_cards := 0
		for c in hand.get_all_cards():
			if c.properties.Cost == 0:
				reduced_cost_cards += 1
		assert_eq(reduced_cost_cards, 1, "One card's cost reduced by expected amount")
		assert_eq(card.get_parent(), forgotten)
		yield(yield_for(2), YIELD)

class TestCringelord:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Cringelord"
		expected_amount_keys = [
			"perturb_amount",
			"defence_amount",
		]


	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"))
		assert_eq(count_card_names("Cringeworthy Memory"), get_amount("perturb_amount"),
				"Cringeworthy Memory spawned when card played")
		assert_eq(card.get_parent(), forgotten, "Card forgotten")

class TestNightmare:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.doom.name
	func _init() -> void:
		testing_card_name = "Nightmare"
		expected_amount_keys = [
			"effect_stacks",
			"effect_stacks2",
		]

	func test_basic_torment():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Torment increased by correct amount" % [effect])

	func test_minion_torment():
		test_torment.remove_from_group("BasicEnemyEntities")
		test_torment.add_to_group("MinionEnemyEntities")
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), get_amount("effect_stacks2"),
				"%s stacks on Torment increased by correct amount" % [effect])


	func test_advanced_torment():
		test_torment.remove_from_group("BasicEnemyEntities")
		test_torment.add_to_group("AdvancedEnemyEntities")
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), 0,
				"%s stacks on Torment not increased" % [effect])

class TestSubmerged:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.strengthen.name
	func _init() -> void:
		testing_card_name = "Submerged"
		expected_amount_keys = [
			"detriment_stacks"
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), -get_amount("detriment_stacks"),
				"%s stacks on Torment decreased by correct amount" % [effect])

class TestCockroaches:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags.test_initial_hand = true
		testing_card_name = "Cockroaches"

	func test_card_results():
		watch_signals(globals.player.deck)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_signal_emit_count(globals.player.deck, "card_entry_modified", 1)

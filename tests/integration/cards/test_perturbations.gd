extends "res://tests/HUT_Ordeal_CardTestClass.gd"


class TestScatteredDreams:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.marked.name
	var effect2: String = Terms.ACTIVE_EFFECTS.delighted.name
	func _init() -> void:
		testing_card_name = "Scattered Dreams"
		expected_amount_keys = [
			"effect_stacks",
			"effect_stacks2"
		]

	func test_card_results():
		assert_has_amounts()
		yield(yield_for(0.1), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"%s stacks on dreamer not increased when card played" % [effect])
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 3,
				"Immersion not affected by %s" % [testing_card_name])

	func test_card_results_remaining_on_hand():
		assert_has_amounts()
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:10"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		yield(yield_for(0.1), YIELD)
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on dreamer increased when left in hand" % [effect])
		assert_eq(dreamer.active_effects.get_effect_stacks(effect2), get_amount("effect_stacks2"),
				"%s stacks on dreamer increased when left in hand" % [effect2])
		assert_eq(dreamer.damage, 10, "Damage not increased by delayed marked")
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), get_amount("effect_stacks") - 1,
				"%s stacks on dreamer increased when left in hand" % [effect])
		assert_eq(dreamer.active_effects.get_effect_stacks(effect2), 0,
				"%s stacks 0 out on subsequent application" % [effect2])
		assert_eq(dreamer.damage, 28, "Damage increased by marked")


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
#		yield(yield_to(cfc, "new_card_instanced", 0.2), YIELD)
		assert_signal_emitted(card, "card_removed")
		assert_signal_emitted(cfc, "new_card_instanced")
		assert_eq(dreamer.damage, 1, "Perturbation did damage")
		# We're saving as vars here because the original card will be queue cleared
		var draw_amount = get_amount("draw_amount")
		yield(yield_for(0.5), YIELD)
		assert_eq(count_card_names("Dream Fragment"), 1,
				"Card removed but new one took its place")
		assert_eq(hand.get_card_count(), 1 + draw_amount,
				"%s drew correct amount of cards" % [testing_card_name])
		gut.p(hand.get_card_count())


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
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "enemy_turn_started",3 ), YIELD)
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "enemy_turn_started",3 ), YIELD)
		assert_signal_emit_count(cfc, "new_card_instanced", 1)
		assert_eq(count_card_names("Inescepable Conclusion"), 3,
				"1 New Inescepable Conclusion Added")

class TestCockroachInfestation:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags.test_initial_hand = true
		test_card_names = [
			"Cockroach Infestation",
			"Cockroach Infestation",
		]

	func test_card_results():
		watch_signals(globals.player.deck)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "enemy_turn_started",3 ), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_entry_modified", 1)

class TestSelfCentered:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags.no_refill = false
		testing_card_name = "Self-Centered"
		test_card_names = [
			"Self-Centered",
			"Interpretation",
		]
		expected_amount_keys = [
			"detrimental_integer"
		]

	func test_card_results():
		assert_has_amounts()
#		add_single_card(testing_card_name, deck)
		spawn_effect(test_torment, Terms.ACTIVE_EFFECTS.poison.name, 14, '')
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.thorns.name, 9, '')
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:10"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		cards[1].scripts = BIG_ATTACK_SCRIPT
		var torment_added_damage = DMG*5 - get_amount("detrimental_integer")
		yield(yield_for(0.2), YIELD)
		var sceng = cards[1].execute_scripts()
		if not cards[1].targeting_arrow.is_targeting:
			yield(yield_to(cards[1].targeting_arrow, "initiated_targeting", 1), YIELD)
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible, "Damage amount should  be visible")
			assert_eq(prediction.signifier_amount.text, str(torment_added_damage), "Card damage should be reduced as expected")
		yield(target_entity(cards[1], test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(torment_added_damage), "Torment should take expected damage")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 10, "Dreamer should take damage from intents")
		assert_eq(test_torment.damage, tdamage(torment_added_damage + 4), "Torment should take reducted damage from poison")


class TestDubiousPainkillers:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		test_card_names = [
			"Dubious Painkillers",
		]
		expected_amount_keys = [
			"exert_amount",
			"health_amount",
		]

	func test_card_results():
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.health, 100 + get_amount("health_amount"))
		assert_eq(dreamer.damage, get_amount("exert_amount"))

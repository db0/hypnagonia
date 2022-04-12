extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"

class TestStrengthen:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.strengthen.name
	var amount := 4
	var modified_dmg = DMG + amount
	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]


	func test_strengthen_general():
		var sceng = card.execute_scripts()
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible, "Damage amount should be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_dmg), "Card damage should be increased")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(modified_dmg), "Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 4,
				"%s stacks not modified" % [effect])
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), amount,
				"Stacks %s not reduced" % [effect])


	func test_positive_strengthen_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:6","Stress:6","Stress:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		spawn_effect(test_torment, effect, 4, '')
		cfc.call_deferred("flush_cache")
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		var intents = test_torment.intents.get_children()
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text, "10", "Stress intent should be 10")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 10 * 3,
				"%s increased stress" % [effect])


	func test_negative_strengthen_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:6","Stress:6","Stress:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		spawn_effect(test_torment, effect, -4, '')		
		cfc.call_deferred("flush_cache")
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		var intents = test_torment.intents.get_children()
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text, "2", "Stress intent should be 2")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 2 * 3,
				"%s increased stress" % [effect])
				
	func test_super_negative_strengthen_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:6","Stress:6","Stress:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		spawn_effect(test_torment, effect, -10, '')		
		cfc.call_deferred("flush_cache")
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		var intents = test_torment.intents.get_children()
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text, "0", "Stress intent should be 0")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 0,
				"%s at 0 did not increase stress" % [effect])

	func test_versatile_reverse():
		spawn_effect(dreamer, effect, -7, '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), -3,
				"%s stacks reversed" % [effect])
		spawn_effect(dreamer, effect, +10, '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 7,
				"%s stacks reversed" % [effect])

class TestQuicken:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.quicken.name
	var amount := 4
	func _init() -> void:
		test_card_names = [
			"Confidence",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]


	func test_quicken_general():
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 4,
				"%s stacks not modified" % [effect])
		assert_eq(dreamer.defence, 5 + amount)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), amount,
				"Stacks %s not reduced" % [effect])


	func test_positive_quicken_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Perplex:6","Perplex:6","Perplex:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		spawn_effect(test_torment, effect, 4, '')
		cfc.call_deferred("flush_cache")
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		var intents = test_torment.intents.get_children()
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text, "10", "Perplex intent should be 10")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.defence, 10 * 3,
				"%s increased perplex" % [effect])


	func test_negative_quicken_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Perplex:6","Perplex:6","Perplex:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		spawn_effect(test_torment, effect, -4, '')		
		cfc.call_deferred("flush_cache")
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		var intents = test_torment.intents.get_children()
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text, "2", "Perplex intent should be 2")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.defence, 2 * 3,
				"%s increased perplex" % [effect])
				
	func test_super_negative_quicken_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Perplex:6","Perplex:6","Perplex:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		spawn_effect(test_torment, effect, -10, '')		
		cfc.call_deferred("flush_cache")
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		var intents = test_torment.intents.get_children()
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text, "0", "Perplex intent should be 0")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.defence, 0,
				"%s at 0 did not increase perplex" % [effect])

	func test_versatile_reverse():
		spawn_effect(dreamer, effect, -7, '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), -3,
				"%s stacks reversed" % [effect])
		spawn_effect(dreamer, effect, +10, '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 7,
				"%s stacks reversed" % [effect])

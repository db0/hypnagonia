extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"



class TestExcuses:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.excuses.name
	var amount := 1
	var modified_dmg = 11
	func _init() -> void:
		torments_amount = 1
		test_card_names = [
			"A Squirrel",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]


	func test_impervious_enemies():
		var sceng = card.execute_scripts()
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible, "Damage amount should be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_dmg), "Card damage should not be affected")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg, "Torment should take damage")
		assert_eq(dreamer.damage, 1, "Dreamer damage reduced to 1")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1,
				"%s stacks do not decrease" % [effect])

	func test_excuses_and_dots():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.poison.name, 5, '')
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.burn.name, 16, '')
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		turn.call_deferred("end_player_turn")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg, "Torment should take damage")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 7,
				"%s stops DoTs" % [effect])


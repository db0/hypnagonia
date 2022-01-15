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

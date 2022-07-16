extends "res://tests/HUT_Ordeal_CardTestClass.gd"

class TestConfidence:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Confidence"
		expected_amount_keys = [
			"defence_amount"
		]


	func test_card_results():
		assert_has_amounts()
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"),
				"%s gave correct amount of confidence" % [card.canonical_name])

class TestFowlLanguage:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Fowl Language"
		expected_amount_keys = [
			"multiplier_amount"
		]


	func test_card_results():
		assert_has_amounts()
		spawn_effect(test_torment, Terms.ACTIVE_EFFECTS.disempower.name, 7)
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name), 7 * get_amount("multiplier_amount"),
				"%s stacks on torment increased as expecte" % [Terms.ACTIVE_EFFECTS.poison.name])



class TestIllShowThemAll:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		testing_card_name = "I'll Show Them All"
		expected_amount_keys = [
			"draw_amount"
		]


	func test_card_results():
		assert_has_amounts()
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.buffer.name, 2, '')
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(counters.get_counter("immersion"), 5,
				"%s gave correct amount of immersion" % [card.canonical_name])
		assert_eq(hand.get_card_count(), 2 + get_amount("draw_amount"),
				"%s drew correct amount of cards" % [card.canonical_name])

extends "res://tests/HUT_CardTestClass.gd"

class TestInterpretation:
	extends "res://tests/HUT_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Interpretation"
		expected_amount_keys = [
			"damage_amount"
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])

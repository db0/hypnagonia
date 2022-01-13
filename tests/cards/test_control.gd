extends "res://tests/HUT_CardTestClass.gd"

class TestConfidence:
	extends "res://tests/HUT_CardTestClass.gd"
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

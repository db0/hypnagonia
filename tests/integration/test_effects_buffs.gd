extends "res://tests/HUT_TormentEffectsTestClass.gd"

class TestAdvantage:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"

	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": Terms.ACTIVE_EFFECTS.advantage.name,
				"amount": 1,
			}
		]

	func test_single_advantage_from_card():
		var card: Card = cards[0]
		var sceng = card.execute_scripts()
		gut.p(test_torment.damage)
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible, "Damage amount should  be visible")
			assert_eq(prediction.signifier_amount.text, '12', "Card damage should be doubled")
		yield(target_entity(cards[0], test_torment), "completed")
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		assert_eq(test_torment.damage, 42, "Torment should take damage")


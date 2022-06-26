extends "res://tests/HUT_Ordeal_CardTestClass.gd"

class TestKeepEmComing:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.keep_em_coming.name
	var amount = 2
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]
		test_card_names = [
			"Confidence",
			"Confidence",
		]


	func test_effect():
		set_all_cards_to_script(FORGET_CARD_SCRIPT)
		var effect_node : CombatEffect = dreamer.active_effects.get_effect(effect)
		watch_signals(effect_node)
		execute_with_yield(cards[0])
		yield(yield_to(effect_node, "scripting_finished", 0.2), YIELD)
		assert_eq(hand.get_card_count(), 1 + amount,
				"%s drew correct amount of cards" % [effect])
		execute_with_yield(cards[1])
		yield(yield_to(effect_node, "scripting_finished", 0.2), YIELD)
		assert_eq(hand.get_card_count(), amount * 2,
				"%s drew correct amount of cards" % [effect])

class TestKnowYourLimits:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.know_your_limits.name
	var amount = 3
	func _init() -> void:
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]
		test_card_names = [
			"Confidence",
			"Confidence",
		]


	func test_effect():
		set_all_cards_to_script(FORGET_CARD_SCRIPT)
		var effect_node : CombatEffect = dreamer.active_effects.get_effect(effect)
		watch_signals(effect_node)
		execute_with_yield(cards[0])
		yield(yield_to(effect_node, "scripting_finished", 0.2), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name), amount)
		execute_with_yield(cards[1])
		yield(yield_to(effect_node, "scripting_finished", 0.2), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name), amount * 2)

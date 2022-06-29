extends "res://tests/HUT_Ordeal_CardTestClass.gd"

class TestExhaustion:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.exhaustion.name
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
			"Confidence",
		]


	func test_effect():
		var effect_node : CombatEffect = dreamer.active_effects.get_effect(effect)
		watch_signals(effect_node)
		execute_with_yield(cards[0])
		yield(yield_to(effect_node, "scripting_finished", 0.2), YIELD)
		yield(yield_to(cards[0], "scripts_executed", 2.2), YIELD)
		assert_eq(dreamer.defence, 10,
				"%s caused card effect to be doubled" % [effect])
		assert_eq(forgotten.get_card_count(), 1,
				"%s caused card to be forgotten" % [effect])
		execute_with_yield(cards[1])
		yield(yield_to(effect_node, "scripting_finished", 0.2), YIELD)
		yield(yield_to(cards[1], "scripts_executed", 2.2), YIELD)
		assert_eq(dreamer.defence, 20,
				"%s caused card effect to be doubled" % [effect])
		assert_eq(forgotten.get_card_count(), 2,
				"%s caused card to be forgotten" % [effect])
		var sceng = execute_with_yield(cards[2])
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
#		yield(yield_for(1), YIELD)
		assert_freed(effect_node)
		assert_eq(dreamer.defence, 25,
				"%s third card effects not doubled" % [effect])
		assert_eq(forgotten.get_card_count(), 2,
				"%s third card not forgotten" % [effect])


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

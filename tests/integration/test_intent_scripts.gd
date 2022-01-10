extends "res://tests/HUT_IntentScriptsTestClass.gd"

class TestStress:
	extends "res://tests/HUT_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Stress:10"],
				"reshuffle": true,
			},
		]

	func test_stress():
		assert_eq(dreamer.damage, 10, "Dreamer should take damage")
		assert_eq(test_torment.damage, 0, "Torment should not take damage")


class TestPerplex:
	extends "res://tests/HUT_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Perplex:10"],
				"reshuffle": true,
			},
		]

	func test_perplex():
		assert_eq(test_torment.defence, 10, "Torment should gain defence")
		assert_eq(dreamer.defence, 0, "Dreamer should not gain defence")


class TestPerplexGroup:
	extends "res://tests/HUT_IntentScriptsTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		intents_to_test = [
			{
				"intent_scripts": ["PerplexGroup:10"],
				"reshuffle": true,
			},
		]

	func test_perplexgroup():
		for torment in test_torments:
			assert_eq(torment.defence, 10, "All Torments should gain defence")
		assert_eq(dreamer.defence, 0, "Dreamer should not gain defence")


class TestDebuff:
	extends "res://tests/HUT_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Debuff:1:disempower","Debuff:10:vulnerable"],
				"reshuffle": true,
			},
		]

	func test_debuff():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower.name), 1,
				"Dreamer should gain debuff stacks")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.vulnerable.name), 10,
				"Dreamer should gain many debuff stacks")

class TestBuff:
	extends "res://tests/HUT_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Buff:1:strengthen","Buff:10:advantage"],
				"reshuffle": true,
			},
		]

	func test_buff():
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 1,
				"Torments should gain buff stacks")
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.advantage.name), 10,
				"Torments should gain many buff stacks")


class TestBuffGroup:
	extends "res://tests/HUT_IntentScriptsTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		intents_to_test = [
			{
				"intent_scripts": ["BuffGroup:1:strengthen","BuffGroup:10:advantage"],
				"reshuffle": true,
			},
		]

	func test_buffgroup():
		for torment in test_torments:
			assert_eq(torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 1,
				"All Torments should gain buff stacks")
			assert_eq(torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.advantage.name), 10,
				"Torments should gain many buff stacks")


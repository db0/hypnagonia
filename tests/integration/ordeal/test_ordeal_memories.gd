extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"

class TestDamageAll:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		testing_memory_name = MemoryDefinitions.DamageAll.canonical_name
		expected_amount_keys = [
			"damage_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memory._use()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for torment in test_torments:
			assert_eq(torment.damage, tdamage(get_amount("damage_amount")), "All Torments should take damage")


class TestHealSelfAll:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.HealSelf.canonical_name
		expected_amount_keys = [
			"heal_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		dreamer.damage = 50
		if not assert_has_amounts():
			return
		var sceng = memory._use()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 50 - get_amount("heal_amount"), "Dreamer should heal damage")

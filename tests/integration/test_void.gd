extends "res://tests/HUT_TormentTestClass.gd"

class TestVoid:
	extends "res://tests/HUT_TormentTestClass.gd"

	func _init() -> void:
		torments_to_spawn.append(EnemyDefinitions.VOID)
		test_card_names = [
			"Void",
		]


	func test_void():
		yield(execute_with_target(cards[0], torments[0]), "completed")
#		execute_with_target(cards[0], torments[0])
	#	_torment1.active_effects.mod_effect(Terms.ACTIVE_EFFECTS["void"].name, 1)
#		pause_before_teardown()

class TestVoidEffect:
	extends "res://tests/HUT_TormentEffectsTestClass.gd"

	func _init() -> void:
		test_card_names = [
			"Void",
		]
		var test_effect := {
				"name": Terms.ACTIVE_EFFECTS["void"].name,
				"amount": 2,
			}
		effects_to_play.append(test_effect)


	func test_void():
		yield(execute_with_target(cards[0], test_torment), "completed")
		yield(yield_for(0.5), YIELD)
		assert_eq(count_card_names("Lacuna"), 2,
				"2 Lacuna as spawned per played Understanding")
#		execute_with_target(cards[0], torments[0])
	#	_torment1.active_effects.mod_effect(Terms.ACTIVE_EFFECTS["void"].name, 1)
#		pause_before_teardown()


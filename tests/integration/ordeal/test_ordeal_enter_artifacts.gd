extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"

class TestStartingHeal:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StartingHeal.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StartingHeal.canonical_name)
		expected_amount_keys = [
			"heal_amount",
		]
		dreamer_starting_damage = 30

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(dreamer.damage, dreamer_starting_damage - get_amount("heal_amount"))

class TestFirstPowerAttack:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.FirstPowerAttack.canonical_name
		expected_amount_keys = [
			"effect_amount",
		]
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var sceng = snipexecute(cards[0], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(DMG + get_amount("effect_amount")))
		sceng = snipexecute(cards[1], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(DMG + DMG + get_amount("effect_amount")))


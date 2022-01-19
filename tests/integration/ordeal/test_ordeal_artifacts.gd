extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"


class TestEndingHeal:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.EndingHeal.canonical_name
		expected_amount_keys = [
			"heal_amount",
		]
		dreamer_starting_damage = 30

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		board.complete_battle()
		yield(yield_to(board, "battle_ended", 0.2), YIELD)
		assert_eq(globals.player.damage, dreamer_starting_damage - get_amount("heal_amount"))

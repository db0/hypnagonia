extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"

class TestMaxHealth:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "MaxHealth"
		expected_amount_keys = [
			"health_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.health, PLAYER_HEALTH + get_amount("health_amount"),
				"%s increased health" % [artifact.canonical_name])


class TestAccumulateEnemy:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateEnemy"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.enemy], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])


class TestAccumulateRest:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateRest"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.rest], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])


class TestAccumulateNCE:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateNCE"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.nce], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])


class TestAccumulateShop:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateShop"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.shop], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])

class TestAccumulateElite:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateElite"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.elite], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])

class TestAccumulateArtifact:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateArtifact"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.artifact], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])

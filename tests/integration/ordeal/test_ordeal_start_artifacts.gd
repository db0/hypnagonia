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


class TestStartingCards:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StartingCards.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StartingCards.canonical_name)
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		expected_amount_keys = [
			"draw_amount",
		]
		
	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(hand.get_card_count(), 5 + get_amount("draw_amount"))

class TestStartingImmersion:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StartingImmersion.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StartingImmersion.canonical_name)
		expected_amount_keys = [
			"immersion_amount",
		]
		
	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(counters.get_counter("immersion"), 3 + get_amount("immersion_amount"))

class TestStartingStrength:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StartingStrength.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StartingStrength.canonical_name)
		expected_amount_keys = [
			"effect_stacks",
		]
		
	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), get_amount("effect_stacks"))

class TestStartingThorns:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StartingThorns.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StartingThorns.canonical_name)
		expected_amount_keys = [
			"effect_stacks",
		]
		
	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.thorns.name), get_amount("effect_stacks"))

class TestStartingConfidence:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StartingConfidence.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StartingConfidence.canonical_name)
		expected_amount_keys = [
			"defence_amount",
		]
		
	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(dreamer.defence, get_amount("defence_amount"))

class TestPerturbationHeal:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.PerturbationHeal.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.PerturbationHeal.canonical_name)
		dreamer_starting_damage = 30
		expected_amount_keys = [
			"heal_amount",
		]
		
	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var cf = CardFilter.new("Type", "Perturbation")
		var pamount = globals.player.deck.filter_cards(cf).size()
		assert_eq(dreamer.damage, dreamer_starting_damage - (pamount * get_amount("heal_amount")))

	func extra_hypnagonia_setup():
		var deck_cards_names := [
			"Lacuna",
			"Lacuna",
			"Lacuna",
			"Lacuna",
			"Lacuna",
		]
		for c in deck_cards_names:
			globals.player.deck.add_new_card(c)


class TestRepressedEnemyBuff:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.RepressedEnemyBuff.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.RepressedEnemyBuff.canonical_name)
		expected_amount_keys = [
			"effect_stacks",
			"pathos_amount",
		]
		set_released_pathos[Terms.RUN_ACCUMULATION_NAMES.enemy] = 100
		
	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var stacks = set_released_pathos[Terms.RUN_ACCUMULATION_NAMES.enemy]\
				/ get_amount("pathos_amount") * get_amount("effect_stacks")
		yield(yield_for(0.2), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.buffer.name), stacks)

class TestStartingDisempower:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["start_ordeal_before_each"] = false
		torments_amount = 3
		testing_artifact_name = ArtifactDefinitions.StartingDisempower.canonical_name
		expected_amount_keys = [
			"effect_stacks",
		]
		
	func test_artifact_effect():
		if not assert_has_amounts():
			return
		board.call_deferred("begin_encounter")
		yield(yield_to(artifact, "artifact_triggered", 1), YIELD)
		for torment in test_torments:
			assert_eq(torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower.name), 
					get_amount("effect_stacks"),
					"All Torments should have received disempower")

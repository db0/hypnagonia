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

	func test_artifact_effect_repeat_predictions():
		card.scripts = REPEAT_ATTACK_SCRIPT
		var normal_dmg = DMG
		var modified_dmg = normal_dmg + ArtifactDefinitions.FirstPowerAttack.amounts.effect_amount
		if not assert_has_amounts():
			return
		var sceng = card.execute_scripts()
		if not card.targeting_arrow.is_targeting:
			yield(yield_to(card.targeting_arrow, "initiated_targeting", 1), YIELD)
		assert_eq(test_torment.incoming.get_child_count(), 3,
				"Torment should have 3 intents displayed")
		var predictions = test_torment.incoming.get_children()
		for index in predictions.size():
			if index == 0:
				assert_eq(predictions[index].signifier_amount.text, str(modified_dmg), "Card damage should be increased")
			else:
				assert_eq(predictions[index].signifier_amount.text, str(normal_dmg), "Card damage should be normal")

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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.defence, 0, "no extra defence on next turn")

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
			"mastery_amount",
		]
		set_pathos_level[Terms.RUN_ACCUMULATION_NAMES.enemy] = 7

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var stacks = set_pathos_level[Terms.RUN_ACCUMULATION_NAMES.enemy]\
				/ get_amount("mastery_amount") * get_amount("effect_stacks")
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

class TestStartingVulnerable:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["start_ordeal_before_each"] = false
		torments_amount = 3
		testing_artifact_name = ArtifactDefinitions.StartingVulnerable.canonical_name
		expected_amount_keys = [
			"effect_stacks",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		board.call_deferred("begin_encounter")
		yield(yield_to(artifact, "artifact_triggered", 1), YIELD)
		for torment in test_torments:
			assert_eq(torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.vulnerable.name),
					get_amount("effect_stacks"),
					"All Torments should have received vulnerable")

class TestDoubleFirstStartup:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["start_ordeal_before_each"] = false
		testing_artifact_name = ArtifactDefinitions.DoubleFirstStartup.canonical_name
		test_card_names = [
			"Precision",
			"Precision",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		board.call_deferred("begin_encounter")
		yield(yield_to(artifact, "artifact_triggered", 1), YIELD)
		for torment in test_torments:
			assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name),
					6, "One startup effect triggered twice")


class TestStrengthenUp0Counters:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StrengthenUp.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StrengthenUp.canonical_name)

	func test_artifact_effect_zero_counters():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 0)


class TestStrengthenUp2Counters:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StrengthenUp.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StrengthenUp.canonical_name)

	func test_artifact_effect_two_counters():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 2)

	func extra_hypnagonia_setup() -> void:
		var curio = globals.player.find_artifact(ArtifactDefinitions.StrengthenUp.canonical_name)
		curio.counter = 2

class TestQuickenUp0Counters:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.QuickenUp.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.QuickenUp.canonical_name)

	func test_artifact_effect_zero_counters():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), 0)


class TestQuickenUp2Counters:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.QuickenUp.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.QuickenUp.canonical_name)

	func test_artifact_effect_two_counters():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), 2)

	func extra_hypnagonia_setup() -> void:
		var curio = globals.player.find_artifact(ArtifactDefinitions.QuickenUp.canonical_name)
		curio.counter = 2


class TestStartingFortify:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StartingFortify.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.StartingFortify.canonical_name)
		expected_amount_keys = [
			"effect_stacks",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.fortify.name), get_amount("effect_stacks"))
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.fortify.name), 0)


class TestThickBoss:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ThickBoss.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ThickBoss.canonical_name)
		expected_amount_keys = [
			"min_deck_size",
			"immersion_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		yield(yield_for(2), YIELD)
		assert_eq(counters.get_counter("immersion"), 4)
		assert_eq(discard.get_card_count(), get_amount("min_deck_size") - globals.player.deck.count_cards())

class TestThickBossFullDeck:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ThickBoss.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ThickBoss.canonical_name)
		expected_amount_keys = [
			"min_deck_size",
			"immersion_amount",
		]
		
	func test_full_deck():
		if not assert_has_amounts():
			return
		yield(yield_for(2), YIELD)
		assert_eq(counters.get_counter("immersion"), 4)
		assert_eq(discard.get_card_count(), 0)

	# To override for extra stuff
	func extra_hypnagonia_setup():
		for iter in ArtifactDefinitions.ThickBoss.amounts.min_deck_size - globals.player.deck.count_cards():
			var ce = globals.player.deck.add_new_card("Interpretation")

extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"


class TestThickImmersion:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ThickImmersion.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ThickImmersion.canonical_name)
		expected_amount_keys = [
			"effect_stacks",
			"immersion_amount",
		]
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(board.counters.get_counter("immersion"), 3 + get_amount("immersion_amount"))
		deck.shuffle_cards()
		yield(yield_to(deck, "shuffle_completed", 0.5), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.vulnerable.name),
				get_amount("effect_stacks"),
				"%s gives %s when deck shuffled" % [artifact.name, Terms.ACTIVE_EFFECTS.vulnerable.name])
		assert_true(artifact.is_active, "Artifact should be disabled after shuffling")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(board.counters.get_counter("immersion"), 3)
		assert_eq(turn.encounter_event_count.get("immersion_increased",0 ), 0,
				"Turn Start immersion should not counted as being gained during the turn")

class TestThickStrength:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ThickStrength.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ThickStrength.canonical_name)
		expected_amount_keys = [
			"effect_stacks",
		]
		globals.test_flags["test_initial_hand"] = true

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var effect_name = "Thick Focus"
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				get_amount("effect_stacks"),
				"%s gives %s first turn" % [artifact.name, effect_name])
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				get_amount("effect_stacks") * 2,
				"%s gives %s every turn" % [artifact.name, effect_name])
		deck.shuffle_cards()
		yield(yield_to(deck, "shuffle_completed", 0.5), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				0,
				"%s removed all %s after reshuffle" % [artifact.name, effect_name])
		assert_true(artifact.is_active, "Artifact should be disabled after shuffling")

class TestThinCardDraw:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ThinCardDraw.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ThinCardDraw.canonical_name)
		expected_amount_keys = [
			"draw_amount",
		]
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(hand.get_card_count(), 5, "Initial shuffle doesn't get an extra card")
		deck.shuffle_cards()
		yield(yield_to(deck, "shuffle_completed", 0.5), YIELD)
		assert_eq(hand.get_card_count(), 5 + get_amount("draw_amount"), "Shuffle draws a new card")
		deck.shuffle_cards()
		yield(yield_to(deck, "shuffle_completed", 0.5), YIELD)
		assert_eq(hand.get_card_count(), 5+ get_amount("draw_amount") * 2, "Shuffle draws a new card")

	func test_artifact_disable():
		if not assert_has_amounts():
			return
		yield(yield_for(0.2), YIELD)
		for c in deck.get_all_cards():
			c.queue_free()
		assert_eq(hand.get_card_count(), 5)
		if hand.get_card_count() != 5:
			return
		card = hand.get_all_cards()[0]
		card.move_to(deck)
		yield(yield_for(0.2), YIELD)
		deck.shuffle_cards()
		card.move_to(deck)
		yield(yield_for(0.2), YIELD)
		deck.shuffle_cards()
		card.move_to(deck)
		yield(yield_for(0.2), YIELD)
		deck.shuffle_cards()
		for c in hand.get_all_cards():
			c.move_to(deck)
		yield(yield_for(0.2), YIELD)
		deck.shuffle_cards()
		assert_true(artifact.is_active, "Artifact should be disabled after drawing same card 3 times")
		assert_eq(hand.get_card_count(), 0, "Reshuffling doesn't draw cards after artifact disabled.")

class TestResistDisempower:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.disempower.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ResistDisempower.canonical_name
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate(true)
		var modification = 5
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = modification
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var act = activate_quick_intent(["Debuff:10:disempower","Buff:5:disempower"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				0,
				"%s prevented all %s from all sources" % [artifact.name, effect_name])
		script.manual.hand[0].subject = "target"
		cards[1].scripts = script
		call_deferred("snipexecute", cards[1], test_torment)
		yield(self, "card_scripts_executed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect_name), modification * 2 - 1,
				"%s did not modify applying %s stacks to enemies" % [artifact.name, effect_name])

class TestResistPoison:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.poison.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ResistPoison.canonical_name
		expected_amount_keys = [
			"alteration_amount",
		]
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate(true)
		var modification = 5
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = modification
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification - get_amount("alteration_amount"),
				"%s prevented 1 stack of %s from any source" % [artifact.name, effect_name])
		var act = activate_quick_intent(["Debuff:5:poison","Buff:5:poison"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification * 2 - 1 - get_amount("alteration_amount") * 2,
				"%s prevented 1 stack of %s from any source" % [artifact.name, effect_name])
		script.manual.hand[0].subject = "target"
		cards[1].scripts = script
		call_deferred("snipexecute", cards[1], test_torment)
		yield(self, "card_scripts_executed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect_name),
				modification * 2,
				"%s did not modify applying %s stacks to enemies" % [artifact.name, effect_name])

class TestResistBurn:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.burn.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ResistBurn.canonical_name
		expected_amount_keys = [
			"alteration_amount",
		]
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate(true)
		var modification = 5
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = modification
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification - get_amount("alteration_amount"),
				"%s prevented 1 stack of %s from any source" % [artifact.name, effect_name])
		var act = activate_quick_intent(["Debuff:5:burn","Buff:5:burn"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification * 2 - 1 - get_amount("alteration_amount") * 2,
				"%s prevented 1 stack of %s from any source" % [artifact.name, effect_name])
		script.manual.hand[0].subject = "target"
		cards[1].scripts = script
		call_deferred("snipexecute", cards[1], test_torment)
		yield(self, "card_scripts_executed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect_name),
				modification * 2 - 1,
				"%s did not modify applying %s stacks to enemies" % [artifact.name, effect_name])


class TestResistVulnerable:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.vulnerable.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ResistVulnerable.canonical_name
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate(true)
		var modification = 5
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = modification
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var act = activate_quick_intent(["Debuff:10:vulnerable","Buff:5:vulnerable"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				0,
				"%s prevented all %s from all sources" % [artifact.name, effect_name])
		script.manual.hand[0].subject = "target"
		cards[1].scripts = script
		call_deferred("snipexecute", cards[1], test_torment)
		yield(self, "card_scripts_executed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect_name), modification * 2 - 1,
				"%s did not modify applying %s stacks to enemies" % [artifact.name, effect_name])

class TestImproveThorns:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.thorns.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ImproveThorns.canonical_name
		expected_amount_keys = [
			"alteration_amount",
		]
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate(true)
		var modification = 5
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = modification
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification + get_amount("alteration_amount"),
				"%s added 1 stack of %s from any source" % [artifact.name, effect_name])
		var act = activate_quick_intent(["Debuff:5:thorns","Buff:5:thorns"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification * 2 - 1 + get_amount("alteration_amount") * 2,
				"%s added 1 stack of %s from any source" % [artifact.name, effect_name])
		script.manual.hand[0].subject = "target"
		cards[1].scripts = script
		call_deferred("snipexecute", cards[1], test_torment)
		yield(self, "card_scripts_executed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect_name),
				modification * 2,
				"%s did not modify applying %s stacks to enemies" % [artifact.name, effect_name])

class TestImprovePoison:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.poison.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ImprovePoison.canonical_name
		expected_amount_keys = [
			"alteration_amount",
		]
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate(true)
		var modification = 5
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = modification
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification + get_amount("alteration_amount"),
				"%s modified %s stacks on dreamer from own cards" % [artifact.name, effect_name])
		var act = activate_quick_intent(["Debuff:5:poison","Buff:5:poison"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification * 2 - 1 + get_amount("alteration_amount"),
				"%s did not modify %s stacks on dreamer from the torment" % [artifact.name, effect_name])
		script.manual.hand[0].subject = "target"
		cards[1].scripts = script
		call_deferred("snipexecute", cards[1], test_torment)
		yield(self, "card_scripts_executed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect_name),
				modification * 2 + get_amount("alteration_amount"),
				"%s did not modify applying %s stacks to enemies" % [artifact.name, effect_name])

class TestImproveBurn:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.burn.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ImproveBurn.canonical_name
		expected_amount_keys = [
			"alteration_amount",
		]
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate(true)
		var modification = 5
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = modification
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification,
				"%s did not modify %s stacks on dreamer from own cards" % [artifact.name, effect_name])
		var act = activate_quick_intent(["Debuff:5:burn","Buff:5:burn"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification * 2 - 1,
				"%s did not modify %s stacks on dreamer from the torment" % [artifact.name, effect_name])
		script.manual.hand[0].subject = "target"
		cards[1].scripts = script
		call_deferred("snipexecute", cards[1], test_torment)
		yield(self, "card_scripts_executed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect_name),
				modification * 2 - 1 + get_amount("alteration_amount"),
				"%s modified applying %s stacks to enemies" % [artifact.name, effect_name])


class TestThickExplosion:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		testing_artifact_name = ArtifactDefinitions.ThickExplosion.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ThickExplosion.canonical_name)
		globals.test_flags["test_initial_hand"] = true

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var i := 0
		for c in deck.get_all_cards():
			c.move_to(discard)
			i += 1
			if i >= 5:
				break
		deck.shuffle_cards()
		yield(yield_to(deck, "shuffle_completed", 0.5), YIELD)
		for t in test_torments:
			assert_eq(t.damage, tdamage(0),
					"%s did no damage due to simple shuffles" % [artifact.name])
		var discard_size = discard.get_card_count()
		discard.reshuffle_in_deck()
		yield(yield_to(test_torments[2], "entity_damaged", 1.5), YIELD)
		for t in test_torments:
			assert_eq(t.damage, tdamage(discard_size),
					"%s did damage equal to discard pile" % [artifact.name])
		assert_true(artifact.is_active, "Artifact should be disabled after shuffling")
		i = 0
		for c in deck.get_all_cards():
			c.move_to(discard)
			i += 1
			if i >= 5:
				break
		discard_size = discard.get_card_count()
		discard.reshuffle_in_deck()
		yield(yield_to(discard, "discard_reshuffled_into_deck", 1.5), YIELD)
		for t in test_torments:
			assert_eq(t.damage, tdamage(discard_size),
					"%s did not activate second time" % [artifact.name])

class TestImproveImpervious:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.impervious.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ImproveImpervious.canonical_name

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var modification = 4
		var reduction = 1 - (3 * 0.28)
		spawn_effect(dreamer, effect, modification)
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:100","Stress:100","Stress:100","Stress:100"],
				"reshuffle": true,
			},
		]
		for torment in test_torments:
			torment.intents.replace_intents(intents_to_test)
			torment.intents.refresh_intents()
		cfc.call_deferred("flush_cache")
		yield(yield_to(cfc, "cache_cleared", 0.4), YIELD)
		var intents = test_torment.intents.get_children()
		for iindex in range(intents.size()):
			if iindex == 0:
				assert_eq(intents[iindex].signifier_amount.text, str(100 * reduction), "Stress intent hitting %s should be decreased" % [effect])
			if iindex == 1:
				assert_eq(intents[iindex].signifier_amount.text, str(100 * reduction ), "Stress intent hitting %s should be decreased" % [effect])
			if iindex == 2:
				assert_eq(intents[iindex].signifier_amount.text, str(100 * (reduction + 0.28) ), "Stress intent hitting %s should be decreased" % [effect])
			if iindex == 3:
				assert_eq(intents[iindex].signifier_amount.text, str(100 * (reduction + (0.28 * 2)) ), "Stress intent hitting %s should be decreased" % [effect])

class TestImproveFortify:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.fortify.name
	func _init() -> void:
		pre_init_artifacts.append(ArtifactDefinitions.ImproveFortify.canonical_name)
		testing_artifact_name = ArtifactDefinitions.ImproveFortify.canonical_name

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var modification = 5
		spawn_effect(dreamer, effect_name, modification)
		turn.call("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name),
				2 * (modification - modification/2),
				"%s also added double the amount of %s stacks" % [artifact.name, Terms.ACTIVE_EFFECTS.armor.name])

class TestRedWave:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["start_ordeal_before_each"] = false
		testing_artifact_name = ArtifactDefinitions.RedWave.canonical_name
		expected_amount_keys = [
			"threshold",
			"defence_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var cards := []
		for iter in get_amount("threshold"):
			cards.append("Interpretation")
		setup_test_cards(cards)
		board.call_deferred("begin_encounter")
		yield(yield_to(artifact, "artifact_triggered", 1), YIELD)
		assert_signal_emitted(artifact, "artifact_triggered")
		assert_eq(dreamer.defence, get_amount("defence_amount"),
				"%s added defence due to hitting threshold" % [artifact.name])

	func test_artifact_not_triggering():
		if not assert_has_amounts():
			return
		var cards := []
		for iter in get_amount("threshold") - 1:
			cards.append("Interpretation")
		setup_test_cards(cards)
		board.call_deferred("begin_encounter")
		yield(yield_to(scripting_bus, "player_turn_started", 1), YIELD)
		assert_signal_not_emitted(artifact, "artifact_triggered")
		assert_eq(dreamer.defence, 0,
				"%s did not add defence due to not hitting threshold" % [artifact.name])

class TestBlueWave:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		globals.test_flags["start_ordeal_before_each"] = false
		testing_artifact_name = ArtifactDefinitions.BlueWave.canonical_name
		expected_amount_keys = [
			"threshold",
			"damage_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var cards := []
		for iter in get_amount("threshold"):
			cards.append("Confidence")
		setup_test_cards(cards)
		board.call_deferred("begin_encounter")
		yield(yield_to(artifact, "artifact_triggered", 1), YIELD)
		assert_signal_emitted(artifact, "artifact_triggered")
		# To allow sceng to finish
		yield(yield_for(0.1), YIELD)
		for t in test_torments:
			assert_eq(t.damage, tdamage(get_amount("damage_amount")),
					"%s did damage due to hitting threshold" % [artifact.name])

	func test_artifact_not_triggering():
		if not assert_has_amounts():
			return
		var cards := []
		for iter in get_amount("threshold") - 1:
			cards.append("Confidence")
		setup_test_cards(cards)
		board.call_deferred("begin_encounter")
		yield(yield_to(scripting_bus, "player_turn_started", 1), YIELD)
		assert_signal_not_emitted(artifact, "artifact_triggered")
		for t in test_torments:
			assert_eq(t.damage, tdamage(0),
					"%s did 0 damage due to not hitting threshold" % [artifact.name])

class TestPurpleWave:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		dreamer_starting_damage = 30
		globals.test_flags["start_ordeal_before_each"] = false
		testing_artifact_name = ArtifactDefinitions.PurpleWave.canonical_name
		expected_amount_keys = [
			"threshold",
			"heal_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var cards := []
		for iter in get_amount("threshold"):
			cards.append("Gaslighter")
		setup_test_cards(cards)
		board.call_deferred("begin_encounter")
		yield(yield_to(artifact, "artifact_triggered", 1), YIELD)
		assert_signal_emitted(artifact, "artifact_triggered")
		assert_eq(dreamer.damage, dreamer_starting_damage - get_amount("heal_amount"),
				"%s healed dreamer due to hitting threshold" % [artifact.name])

	func test_artifact_not_triggering():
		if not assert_has_amounts():
			return
		var cards := []
		for iter in get_amount("threshold") - 1:
			cards.append("Gaslighter")
		setup_test_cards(cards)
		board.call_deferred("begin_encounter")
		yield(yield_to(scripting_bus, "player_turn_started", 1), YIELD)
		assert_signal_not_emitted(artifact, "artifact_triggered")
		assert_eq(dreamer.damage, dreamer_starting_damage,
				"%s did not heale dreamer due to not hitting threshold" % [artifact.name])

class TestProgressiveImmersion:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ProgressiveImmersion.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ProgressiveImmersion.canonical_name)
		expected_amount_keys = [
			"immersion_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion on first turn")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.creative_block.name),
				1, "%s prevents all card upgrades" % [artifact.name])
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion per turn")

class TestBossCardDraw:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		testing_artifact_name = ArtifactDefinitions.BossCardDraw.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.BossCardDraw.canonical_name)
		expected_amount_keys = [
			"draw_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(hand.get_card_count(), 6, "Dreamer gets +1 card on first turn")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(hand.get_card_count(), 6, "Dreamer gets +1 card per turn")

class TestRandomUpgrades:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.RandomUpgrades.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.RandomUpgrades.canonical_name)
		expected_amount_keys = [
			"immersion_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion on first turn")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion per turn")


class TestRandomUpgradesDetriment:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.RandomUpgrades.canonical_name
		expected_amount_keys = [
			"immersion_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		for c in globals.player.deck.cards:
			c.upgrade_progress = c.upgrade_threshold
		var current_upgrades : CardUpgrade = get_tree().get_nodes_in_group("card_upgrade")[0]
		var pre_use_draft = current_upgrades.get_children()
		current_upgrades.display()
		yield(yield_to(current_upgrades, "draft_prepared", 0.2), YIELD)
		journal.display_enemy_rewards('')
		var card_to_upgrade = current_upgrades.get_child(1)
		watch_signals(current_upgrades)
		watch_signals(globals.player.deck)
		if card_to_upgrade as CVGridCardObject and globals.player.deck:
			watch_signals(card_to_upgrade)
			card_to_upgrade.select_card()
			assert_signal_emitted(card_to_upgrade, "card_selected")
		yield(yield_to(globals.player.deck, "card_entry_upgraded", 1), YIELD)
		assert_signal_emitted(current_upgrades, "card_upgraded")
		assert_signal_emitted(globals.player.deck, "card_entry_upgraded")

class TestNoRest:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.NoRest.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.NoRest.canonical_name)
		expected_amount_keys = [
			"immersion_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion on first turn")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion per turn")


class TestSmallerDrafts:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.SmallerDrafts.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.SmallerDrafts.canonical_name)
		expected_amount_keys = [
			"immersion_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion on first turn")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion per turn")

class TestConstantImpervious:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ConstantImpervious.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ConstantImpervious.canonical_name)
		expected_amount_keys = [
			"effect_stacks",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name),
				get_amount("effect_stacks"),
				"%s gives Dreamer +1 %s on first turn" % [artifact.name, Terms.ACTIVE_EFFECTS.impervious.name])
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name),
				get_amount("effect_stacks"),
				"%s gives Dreamer +1 %s on every turn" % [artifact.name, Terms.ACTIVE_EFFECTS.impervious.name])


class TestThickHeal:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ThickHeal.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ThickHeal.canonical_name)
		globals.test_flags["test_initial_hand"] = true
		dreamer_starting_damage = 10
		expected_amount_keys = [
			"heal_amount",
			"exert_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(dreamer.damage, 9)
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 8)
		deck.shuffle_cards()
		yield(yield_to(deck, "shuffle_completed", 0.5), YIELD)
		assert_eq(dreamer.damage, 11)
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 10)


class TestDoubleProgressFail:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.DoubleProgress.canonical_name
		dreamer_starting_damage = 10
		expected_amount_keys = [
			"card_amount",
		]
		test_card_names = [
			"Confidence",
			"Confidence",
		]

	func test_artifact_effect_succeed():
		if not assert_has_amounts():
			return
		for iter in 13:
			globals.player.deck.add_new_card("Interpretation")
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(card.deck_card_entry.upgrade_progress, 2, "Thick Deck Card Progress Doubled")

	func test_artifact_effect_fail():
		if not assert_has_amounts():
			return
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(card.deck_card_entry.upgrade_progress, 1, "Thin Deck Card Progress Not Doubled")


class TestLightningMarble:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var dmg = ArtifactDefinitions.LightningMarble.amounts.damage_amount
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.LightningMarble.canonical_name
		expected_amount_keys = [
			"damage_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.damage, tdamage(dmg), "Torment Damaged at end of turn")

class TestLimitMaxExert:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.LimitMaxExert.canonical_name
		expected_amount_keys = [
			"exert_amount",
		]
		test_card_names = [
			"Confidence",
			"Confidence",
			"Confidence",
			"Confidence",
			"Confidence",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		for c in cards:
			c.scripts = EXERT_SCRIPT.duplicate(true)
		var sceng = cards[0].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 5)
		sceng = cards[1].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 10)
		sceng = cards[2].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 10)
		sceng = cards[3].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 10)

class TestThickThorns:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ThickThorns.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.ThickThorns.canonical_name)
		expected_amount_keys = [
			"effect_stacks",
			"detrimental_integer",
		]
		globals.test_flags["test_initial_hand"] = true

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		for iter in range(10):
			add_single_card('Confidence', deck)
		var effect_name = Terms.ACTIVE_EFFECTS.thorns.name
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				get_amount("effect_stacks"),
				"%s gives %s first turn" % [artifact.name, effect_name])
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				get_amount("effect_stacks") * 2 - 1,
				"%s gives %s every turn" % [artifact.name, effect_name])
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				get_amount("effect_stacks") * 3 - 2,
				"%s gives %s every turn" % [artifact.name, effect_name])
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				get_amount("effect_stacks") * 4 - 3,
				"%s gives %s every turn" % [artifact.name, effect_name])
		deck.shuffle_cards()
		turn.call_deferred("end_player_turn")
		yield(yield_to(deck, "shuffle_completed", 0.5), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				1,
				"%s removed %s stacks after reshuffle" % [artifact.name, get_amount("detrimental_integer"), ])
		assert_true(artifact.is_active, "Artifact should be disabled after shuffling")



class TestSavedForgets:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.SavedForgets.canonical_name
		expected_amount_keys = [
		]
		test_card_names = [
			"Unshakeable",
			"Unshakeable",
		]

	func test_artifact_effect():
		for c in cards:
			c.modify_property("Cost", 0)
		if not assert_has_amounts():
			return
		cards[0].execute_scripts()
		yield(yield_to(artifact, "artifact_triggered", 0.2), YIELD)
		assert_eq(cards[0].get_parent(), discard)
		cards[1].execute_scripts()
		yield(yield_to(artifact, "artifact_triggered", 0.2), YIELD)
		assert_eq(cards[1].get_parent(), forgotten)
		assert_signal_emit_count(artifact, "artifact_triggered", 1)


class TestStartupDraw:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.StartupDraw.canonical_name
		expected_amount_keys = [
			"draw_amount",
		]
		test_card_names = [
			"GUT",
			"GUT",
		]
		globals.test_flags["test_initial_hand"] = true

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		for c in cards:
			var tcard: DreamCard = c
			tcard.modify_property('Tags', Terms.GENERIC_TAGS.startup.name)
			tcard.execute_scripts()
		yield(yield_to(artifact, "artifact_triggered", 0.2), YIELD)
		yield(yield_to(artifact, "artifact_triggered", 0.2), YIELD)
		assert_eq(hand.get_card_count(), get_amount("draw_amount") * cards.size(), "Each played startup draws a card")
		assert_signal_emit_count(artifact, "artifact_triggered", 2)

class TestRandomForgottenCards:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.RandomForgottenCards.canonical_name
		expected_amount_keys = [
			"card_amount",
		]
		test_card_names = [
			"GUT",
			"Exhaustion",
			"GUT",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		card.scripts = FORGET_CARD_SCRIPT
		card.execute_scripts()
		yield(yield_to(hand, "card_added", 1), YIELD)
		assert_eq(hand.get_card_count(), get_amount("card_amount") + 2, "Each forgotten card generates a card")
		cards[1].execute_scripts()
		yield(yield_to(scripting_bus, "player_turn_started",3), YIELD)
		cards[2].execute_scripts()
		yield(yield_to(hand, "card_added", 3), YIELD)
		assert_signal_emit_count(artifact, "artifact_triggered", 2)
		assert_eq(hand.get_card_count(), get_amount("card_amount") * 2, "Each forgotten card generates a card")


class TestConstantMark:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ConstantMark.canonical_name
		expected_amount_keys = [
			"effect_stacks",
		]
		torments_amount = 3

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		var marked_count := 0
		for t in test_torments:
			marked_count += t.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.marked.name)
		assert_eq(marked_count, 1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		marked_count = 0
		for t in test_torments:
			marked_count += t.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.marked.name)
		assert_eq(marked_count, 1)


class TestImproveArmor:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ImproveArmor.canonical_name
		expected_amount_keys = [
			"threshold_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.armor.name, 2)
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name), 2)
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.armor.name, 4)
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name), 5)


class TestSwiftPerturbations:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		testing_artifact_name = ArtifactDefinitions.SwiftPerturbations.canonical_name
		expected_amount_keys = [
			"draw_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		add_single_card("Lacuna", deck)
		add_single_card("Lacuna", deck)
		hand.draw_card()
		yield(yield_to(hand, "card_drawn", 1), YIELD)
		assert_eq(hand.get_card_count(), 3)


class TestBufferedSpawns:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.BufferedSpawns.canonical_name
		expected_amount_keys = [
			"effect_stacks",
		]
		test_card_names = [
			'GUT',
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		card.scripts = SPAWN_CARD_SCRIPT
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_to(artifact, "artifact_triggered", 2), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.buffer.name),
				get_amount("effect_stacks"),
				"%s does not gives %s when non-perturbation card spawned" % [artifact.name, Terms.ACTIVE_EFFECTS.buffer.name])


class TestBossExert:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.BossExert.canonical_name
		pre_init_artifacts.append(testing_artifact_name)
		expected_amount_keys = [
			"immersion_amount",
			"exert_amount",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion on first turn")
		assert_eq(dreamer.damage, get_amount("exert_amount"), "Dreamer gets 1 anxiety on first turn")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion per turn")
		assert_eq(dreamer.damage, get_amount("exert_amount") * 2, "Dreamer gets 1 anxiety per turn")


class TestBossRandomDiscount:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.BossRandomDiscount.canonical_name
		pre_init_artifacts.append(testing_artifact_name)
		expected_amount_keys = [
			"immersion_amount",
		]
		test_card_names = [
			'Confidence',
			'GUT',
			'Confrontation',
			'Lacuna',
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_signal_emit_count(scripting_bus, "card_properties_modified", 1)
		var comp_dict =  {
			  "immersion_amount": 3,
			  "new_property_value": "-1",
			  "previous_property_value":  1,
			  "property_name": "Cost",
			  "tags": ["Scripted", "Curio"],
		  }
		assert_signal_emitted_with_parameters(scripting_bus, "card_properties_modified", [card,comp_dict])
		assert_eq(card.get_property('Cost'), 0, "Card's Cost reduced to 0")
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_to(scripting_bus,"card_properties_modified", 1), YIELD)
		assert_eq(card.get_property('Cost'), 1, "Card's Cost reset")
		assert_signal_emit_count(scripting_bus, "card_properties_modified", 2)
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)
		assert_signal_emit_count(scripting_bus, "card_properties_modified", 3)

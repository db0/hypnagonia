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
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
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
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
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
				modification * 2 - 1+ get_amount("alteration_amount"),
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
		yield(yield_to(discard, "discard_reshuffled_into_deck", 1.5), YIELD)
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
		gut.p(discard_size)
		discard.reshuffle_in_deck()
		yield(yield_to(discard, "discard_reshuffled_into_deck", 1.5), YIELD)
		for t in test_torments:
			assert_eq(t.damage, tdamage(discard_size),
					"%s did not activate second time" % [artifact.name])



class TestImproveImpervious:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.impervious.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ImproveImpervious.canonical_name

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var modification = 5
		spawn_effect(dreamer, effect_name, modification)
		turn.call("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				modification / 2,
				"%s only halved at start of turn due to %s" % [effect_name,artifact.name])

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
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name),
				modification - modification/2,
				"%s also added same amount of %s stacks" % [artifact.name, Terms.ACTIVE_EFFECTS.armor.name])

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
		yield(yield_to(turn, "player_turn_started", 1), YIELD)
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
		yield(yield_to(turn, "player_turn_started", 1), YIELD)
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
		yield(yield_to(turn, "player_turn_started", 1), YIELD)
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
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion per turn")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.creative_block.name),
				1, "%s prevents all card upgrades" % [artifact.name])

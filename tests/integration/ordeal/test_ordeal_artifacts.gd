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
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate()
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = 10
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var act = activate_quick_intent(["Debuff:10:disempower"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				0,
				"%s prevented all %s from all sources" % [artifact.name, effect_name])

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
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate()
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = 5
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				5 - get_amount("alteration_amount"),
				"%s prevented 1 stack of %s from any source" % [artifact.name, effect_name])
		var act = activate_quick_intent(["Debuff:5:poison"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				9 - get_amount("alteration_amount") * 2,
				"%s prevented 1 stack of %s from any source" % [artifact.name, effect_name])


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
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate()
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = 5
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				5 - get_amount("alteration_amount"),
				"%s prevented 1 stack of %s from any source" % [artifact.name, effect_name])
		var act = activate_quick_intent(["Debuff:5:burn"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				9 - get_amount("alteration_amount") * 2,
				"%s prevented 1 stack of %s from any source" % [artifact.name, effect_name])


class TestResistVulnerable:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	var effect_name = Terms.ACTIVE_EFFECTS.vulnerable.name
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ResistVulnerable.canonical_name
		test_card_names = [
			"Interpretation",
		]

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		var script = EFFECT_SCRIPT.duplicate()
		script.manual.hand[0].effect_name = effect_name
		script.manual.hand[0].modification = 10
		card.scripts = script
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var act = activate_quick_intent(["Debuff:10:disempower"])
		if act is GDScriptFunctionState:
			act = yield(act, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect_name),
				0,
				"%s prevented all %s from all sources" % [artifact.name, effect_name])

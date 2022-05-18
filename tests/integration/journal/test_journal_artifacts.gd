extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"

class TestTODO:
	extends "res://tests/HUTCommon.gd"

	func test_pending():
		pending("IncreaseUpgradedDraftChance")
		pending("ReduceCurioRerollPerturbChance")

class TestUpgradedAction:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.UpgradedAction.canonical_name
		expected_amount_keys = [
			"progress_amount"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		watch_signals(globals.player.deck)
		var new_card = globals.player.deck.add_new_card("Interpretation")
#		yield(yield_to(artifact, "artifact_triggered", 2.2), YIELD)
		assert_eq(new_card.upgrade_progress, get_amount("progress_amount"), "Correct type progressed")
		new_card = globals.player.deck.add_new_card("Confidence")
#		yield(yield_to(artifact, "artifact_triggered", 2.2), YIELD)
		assert_eq(new_card.upgrade_progress, 0, "Wrong type not progressed")
		assert_signal_emit_count(artifact, "artifact_triggered", 1, "Artifact triggered correct amount of times")



class TestUpgradedControl:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.UpgradedControl.canonical_name
		expected_amount_keys = [
			"progress_amount"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		watch_signals(globals.player.deck)
		var new_card = globals.player.deck.add_new_card("Confidence")
#		yield(yield_to(artifact, "artifact_triggered", 2.2), YIELD)
		assert_eq(new_card.upgrade_progress, get_amount("progress_amount"), "Correct type progressed")
		new_card = globals.player.deck.add_new_card("Interpretation")
#		yield(yield_to(artifact, "artifact_triggered", 2.2), YIELD)
		assert_eq(new_card.upgrade_progress, 0, "Wrong type not progressed")
		assert_signal_emit_count(artifact, "artifact_triggered", 1, "Artifact triggered correct amount of times")




class TestUpgradedUnderstanding:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.UpgradedUnderstanding.canonical_name
		expected_amount_keys = [
			"progress_amount"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		watch_signals(globals.player.deck)
		var new_card = globals.player.deck.add_new_card("Butterfly")
#		yield(yield_to(artifact, "artifact_triggered", 2.2), YIELD)
		assert_eq(new_card.upgrade_progress, get_amount("progress_amount"), "Correct type progressed")
		new_card = globals.player.deck.add_new_card("Interpretation")
#		yield(yield_to(artifact, "artifact_triggered", 2.2), YIELD)
		assert_eq(new_card.upgrade_progress, 0, "Wrong type not progressed")
		assert_signal_emit_count(artifact, "artifact_triggered", 1, "Artifact triggered correct amount of times")




class TestUpgradedConcentration:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.UpgradedConcentration.canonical_name
		expected_amount_keys = [
			"progress_amount"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		watch_signals(globals.player.deck)
		var new_card = globals.player.deck.add_new_card("Nothing to Fear")
#		yield(yield_to(artifact, "artifact_triggered", 2.2), YIELD)
		assert_eq(new_card.upgrade_progress, get_amount("progress_amount"), "Correct type progressed")
		new_card = globals.player.deck.add_new_card("Interpretation")
#		yield(yield_to(artifact, "artifact_triggered", 2.2), YIELD)
		assert_eq(new_card.upgrade_progress, 0, "Wrong type not progressed")
		assert_signal_emit_count(artifact, "artifact_triggered", 1, "Artifact triggered correct amount of times")


class TestPorcelainDoll:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"

	func test_artifact_results():
		watch_signals(globals.player.deck)
		watch_signals(player_info)
		var card_colours := {
			"Carmine": "Interpretation",
			"Indigo": "Confidence",
			"Periwinkle": "Butterfly",
			"Obsidian": "Lacuna",
			"Viridian": "Nothing to Fear",
		}
		var trigger_counts := {
			"Carmine": 10,
			"Indigo": 10,
			"Periwinkle": 10,
			"Obsidian": 3,
			"Viridian": 6,
		}
		var loop
		for colour in HConst.COLOUR_MAP2:
			var doll = globals.player.add_artifact(ArtifactDefinitions.PorcelainDoll.canonical_name)
			yield(yield_to(player_info, "artifact_instanced", 0.2), YIELD)
			artifact = player_info.find_artifact(ArtifactDefinitions.PorcelainDoll.canonical_name)
			assert_not_null(artifact)
			if not artifact:
				continue
			doll.modifiers.colour = colour
			watch_signals(artifact)
			globals.player.deck.add_new_card("Interpretation")
			globals.player.deck.add_new_card("Confidence")
			globals.player.deck.add_new_card("Butterfly")
			globals.player.deck.add_new_card("Lacuna")
			globals.player.deck.add_new_card("Nothing to Fear")
			globals.player.deck.add_new_card(card_colours[colour])
			assert_signal_emit_count(artifact, "artifact_triggered", 2, "Artifact triggered correct amount of times")
			for iter in range(10):
				globals.player.deck.add_new_card(card_colours[colour])
			assert_signal_emit_count(artifact, "artifact_triggered", trigger_counts[colour], "Artifact triggered correct amount of times")
			assert_eq(artifact.artifact_object.context, ArtifactDefinitions.EffectContext.BATTLE, "Porcelain Doll activated")
			globals.player.remove_artifact(doll)
			yield(artifact, "tree_exited")



class TestPPorcelainDollOrdeal:
	extends "res://tests/HUT_Ordeal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["no_refill"] = false
		testing_artifact_name = ArtifactDefinitions.PorcelainDoll.canonical_name
		pre_init_artifacts.append(ArtifactDefinitions.PorcelainDoll.canonical_name)

	func extra_hypnagonia_setup():
		var aobject = globals.player.find_artifact(ArtifactDefinitions.PorcelainDoll.canonical_name)
		aobject.modifiers.colour = "Carmine" # Actions
		aobject.context = ArtifactDefinitions.EffectContext.BATTLE

	func test_artifact_effect():
		if not assert_has_amounts():
			return
		for iter in range(8):
			test_card_names.append("Interpretation")
		cards = setup_test_cards(test_card_names)
		turn.call_deferred("end_player_turn")
		yield(yield_to(board.turn, "player_turn_started",5 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion when correct card types drawn")
		assert_eq(hand.get_card_count(), 7, "Dreamer gets +2 draw when correct card types drawn")
		test_card_names.clear()

	func test_artifact_failed():
		if not assert_has_amounts():
			return
		for iter in range(8):
			test_card_names.append("Confidence")
		cards = setup_test_cards(test_card_names)
		turn.call_deferred("end_player_turn")
		yield(yield_to(board.turn, "player_turn_started",5 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 3, "Dreamer gets +1 immersion when correct card types drawn")
		assert_eq(hand.get_card_count(), 5, "Dreamer gets +2 draw when correct card types drawn")
		test_card_names.clear()

	func test_artifact_success():
		if not assert_has_amounts():
			return
		for iter in range(3):
			test_card_names.append("Interpretation")
		for iter in range(3):
			test_card_names.append("Confidence")
		cards = setup_test_cards(test_card_names)
		turn.call_deferred("end_player_turn")
		yield(yield_to(board.turn, "player_turn_started",5 ), YIELD)
		assert_eq(counters.get_counter("immersion"), 4, "Dreamer gets +1 immersion when correct card types drawn")
		assert_eq(hand.get_card_count(), 6, "Dreamer gets +1 draw when correct card types drawn")
		test_card_names.clear()




class TestBetterRareChance:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	var uncommon_chance : float = 25.0/100
	var rare_chance : float = 5.0/100

	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.BetterRareChance.canonical_name
		expected_amount_keys = [
			"rare_multiplier"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		assert_eq(get_rare_chance(), rare_chance * get_amount("rare_multiplier"), "rare chance multiplied")
		assert_eq(get_uncommon_chance(), uncommon_chance, "uncommon chance stayed the same")

	func get_uncommon_chance() -> float:
		var value := uncommon_chance
		for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
			var multiplier = artifact.get_global_alterant(value, HConst.AlterantTypes.CARD_UNCOMMON_CHANCE)
			if multiplier:
				value *= multiplier
		return(value)

	func get_rare_chance() -> float:
		var value := rare_chance
		for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
			var multiplier = artifact.get_global_alterant(value, HConst.AlterantTypes.CARD_RARE_CHANCE)
			if multiplier:
				value *= multiplier
		return(value)


class TestProgressEverything:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ProgressEverything.canonical_name
		expected_amount_keys = [
			"progress_amount"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		watch_signals(globals.player.deck)
		var new_card = globals.player.deck.add_new_card("Interpretation")
		var progress_amount = get_amount("progress_amount")
		if progress_amount > new_card.upgrade_threshold:
			progress_amount =  new_card.upgrade_threshold
		assert_eq(new_card.upgrade_progress, progress_amount, "Actions progressed")
		new_card = globals.player.deck.add_new_card("Confidence")
		progress_amount = get_amount("progress_amount")
		if progress_amount > new_card.upgrade_threshold:
			progress_amount =  new_card.upgrade_threshold
		assert_eq(new_card.upgrade_progress, progress_amount, "Controls progressed")
		new_card = globals.player.deck.add_new_card("Nothing to Fear")
		progress_amount = get_amount("progress_amount")
		if progress_amount > new_card.upgrade_threshold:
			progress_amount =  new_card.upgrade_threshold
		assert_eq(new_card.upgrade_progress, progress_amount, "Concentrations progressed")
		new_card = globals.player.deck.add_new_card("Gaslighter")
		progress_amount = get_amount("progress_amount")
		if progress_amount > new_card.upgrade_threshold:
			progress_amount =  new_card.upgrade_threshold
		assert_eq(new_card.upgrade_progress, progress_amount, "Understandings progressed")
		new_card = globals.player.deck.add_new_card("Lacuna")
		assert_eq(new_card.upgrade_progress, 0, "Perturbations cannot be progressed")
		assert_signal_emit_count(artifact, "artifact_triggered", 5, "Artifact triggered correct amount of times")


class TestSmallerDraft:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.SmallerDrafts.canonical_name
		expected_amount_keys = [
			"immersion_amount",
			"card_draft_modifier"
		]

	func test_rewards():
		if not assert_has_amounts():
			return
		journal.call_deferred("display_enemy_rewards")
		yield(yield_to(journal._tween, "tween_all_completed", 1), YIELD)
		journal.card_draft.display()
		assert_eq(journal.card_draft.get_child_count(),2, "1 draft plus tween node exist")
		assert_eq(journal.card_draft.draft_card_choices.size(), 1)

class TestBirdHouse:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.BirdHouse.canonical_name
		expected_amount_keys = [
			"draft_amount",
			"draft_choices",
			"pathos_avg_multiplier",
			"memory_amount",
			"memory_upgrade_amount",
			"health_amount",
			"progress_amount",
		]

	func test_rewards():
		if not assert_has_amounts():
			return
		pending("test BirdHouse Stuff")


class TestThickDeckRareChance:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	var uncommon_chance : float = 25.0/100
	var rare_chance : float = 5.0/100

	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.ThickDeckRareChance.canonical_name
		expected_amount_keys = [
			"rare_multiplier",
			"card_amount",
		]

	func test_artifact_results_success():
		if not assert_has_amounts():
			return
		for iter in 13:
			globals.player.deck.add_new_card("Interpretation")
		assert_eq(get_rare_chance(), rare_chance * get_amount("rare_multiplier"), "rare chance multiplied")
		assert_eq(get_uncommon_chance(), uncommon_chance, "uncommon chance stayed the same")

	func test_artifact_results_fail():
		if not assert_has_amounts():
			return
		assert_eq(get_rare_chance(), rare_chance, "rare chance stayed the same")
		assert_eq(get_uncommon_chance(), uncommon_chance, "uncommon chance stayed the same")

	func get_uncommon_chance() -> float:
		var value := uncommon_chance
		for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
			var multiplier = artifact.get_global_alterant(value, HConst.AlterantTypes.CARD_UNCOMMON_CHANCE)
			if multiplier:
				value *= multiplier
		return(value)

	func get_rare_chance() -> float:
		var value := rare_chance
		for artifact in cfc.get_tree().get_nodes_in_group("artifacts"):
			var multiplier = artifact.get_global_alterant(value, HConst.AlterantTypes.CARD_RARE_CHANCE)
			if multiplier:
				value *= multiplier
		return(value)

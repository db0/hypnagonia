extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestTheCandyman:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/AllActs/TheCandyman.gd")

	func test_selecting_with_starting_deck():
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_index(0)
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		watch_signals(globals.player.deck)
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_added")
		var signal_details = get_signal_parameters(nested_choices_scene, "secondary_choice_selected")
		assert_gt(signal_details.size(), 0, "secondary option selected")
		if signal_details.size() >= 1:
			var choice_key = signal_details[0]
			var removed_card = get_signal_parameters(globals.player.deck, "card_removed")
			var added_card = get_signal_parameters(globals.player.deck, "card_added")
			if removed_card.size() > 0 and added_card.size() > 0:
				var cards = [removed_card[0], added_card[0]]
				var used_indexes := []
				for index in range(2):
					for c in cards:
						if c.properties.Type == HConst.COLOUR_MAP[choice_key[index]] and not index in used_indexes:
							used_indexes.append(index)
				assert_eq(used_indexes.size(), 2, "Added and Removed cards match the candy colours")

class TestPopPsychologist2:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd")

	func test_choice_passion_fruit():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player)
		activate_secondary_choice_by_key("passion fruit")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_nce_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd"))
		assert_signal_emitted(globals.player, "artifact_added")
		var added_artifact_signal = get_signal_parameters(globals.player, "artifact_added")
		if not added_artifact_signal or added_artifact_signal.size() == 0:
			return
		var added_artifact: ArtifactObject = added_artifact_signal[0]
		assert_eq(added_artifact.canonical_name, nce.CURIOS['passion fruit'].canonical_name)

	func test_choice_orange():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player)
		activate_secondary_choice_by_key("orange")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_nce_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd"))
		assert_signal_emitted(globals.player, "artifact_added")
		var added_artifact_signal = get_signal_parameters(globals.player, "artifact_added")
		if not added_artifact_signal or added_artifact_signal.size() == 0:
			return
		var added_artifact: ArtifactObject = added_artifact_signal[0]
		assert_eq(added_artifact.canonical_name, nce.CURIOS['orange'].canonical_name)

	func test_choice_bananal():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player)
		activate_secondary_choice_by_key("banana")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_nce_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd"))
		assert_signal_emitted(globals.player, "artifact_added")
		var added_artifact_signal = get_signal_parameters(globals.player, "artifact_added")
		if not added_artifact_signal or added_artifact_signal.size() == 0:
			return
		var added_artifact: ArtifactObject = added_artifact_signal[0]
		assert_eq(added_artifact.canonical_name, nce.CURIOS["banana"].canonical_name)

class TestPopPsychologist3:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd")
		dreamer_starting_damage = 70

	func test_choice_death():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("death")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.damage, 0)
	func test_choice_release():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("release")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.damage, 0)
	func test_choice_oblivion():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("oblivion")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.damage, 0)

class TestDollPickup:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/AllActs/DollPickup.gd")
		dreamer_starting_damage = 70

	func test_random_choice():
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player)
		var sc : JournalNestedChoice = activate_secondary_choice_by_index(2)
		if not sc:
			return
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var doll : ArtifactObject = assert_player_signaled("artifact_added", "canonical_name", "PorcelainDoll")
		assert_eq(sc.choice_key, doll.modifiers.get("colour"), "Colour of doll added matches choice")


class TestEpicUpgrade:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/AllActs/EpicUpgrade.gd")

	func test_choice_epic():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("epic")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		yield(yield_for(0.2), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_entry_modified", nce.EPIC_AMOUNT)
		assert_eq(globals.player.health, 100 - nce.MAX_ANXIETY_LOSS)

	func test_choice_gamble():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("gamble")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		yield(yield_for(0.2), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_entry_modified", nce.GAMBLE_AMOUNT * 2)

	func test_choice_skip():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("skip")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_removed")

class TestOstrichEggs:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	var action_filters = [
		CardFilter.new('_rarity', 'Basic'),
		CardFilter.new('Type', 'Action'),
	]
	var control_filters = [
		CardFilter.new('_rarity', 'Basic'),
		CardFilter.new('Type', 'Control'),
	]
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/AllActs/OstrichEggs.gd")

	func test_choice_scramble():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("scramble")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_entry_modified", 11)
		for card_entry in globals.player.deck.filter_cards(action_filters):
			assert_true(card_entry.is_enhanced())
			assert_false(card_entry.is_scarred())
		for card_entry in globals.player.deck.filter_cards(control_filters):
			assert_false(card_entry.is_enhanced())
			assert_true(card_entry.is_scarred())

	func test_choice_omelette():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("omelette")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_entry_modified", 11)
		for card_entry in globals.player.deck.filter_cards(action_filters):
			assert_false(card_entry.is_enhanced())
			assert_true(card_entry.is_scarred())
		for card_entry in globals.player.deck.filter_cards(control_filters):
			assert_true(card_entry.is_enhanced())
			assert_false(card_entry.is_scarred())

	func test_choice_hungrey():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("hungry")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_entry_modified", nce.HUNGRY_AMOUNT)

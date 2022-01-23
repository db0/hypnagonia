extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestTheCandyman:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/AllActs/TheCandyman.gd")

	func test_selecting_with_starting_deck():
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_index(0)
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		assert_signal_emitted(journal, "selection_deck_spawned")
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1, "Selected Deck spawned")
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
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

class TestDollmaker:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/Dollmaker.gd")

	func test_choice_leave():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/DollPickup.gd"))
		assert_signal_emitted(globals.player.pathos, "pathos_repressed")

	func test_choice_destroy():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("destroy")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.pathos, "released_pathos_gained")
		assert_signal_not_emitted(globals.encounters.run_changes, "nce_unlocked")

class TestGreed:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/Greed.gd")

	func test_choice_accept():
		watch_signals(globals.player.deck)
		var lpathos = globals.player.pathos.grab_random_pathos()
		set_lowest_pathos(lpathos, "released")
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("accept")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_gt(globals.player.pathos.released[lpathos], 50)
		assert_pathos_signaled("released_pathos_gained", lpathos)
		assert_deck_signaled("card_added", "card_name", "Discombobulation")


	func test_choice_leave():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		var lpathos = globals.player.pathos.grab_random_pathos()
		set_lowest_pathos(lpathos, "released")
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("decline")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.pathos.released[lpathos], 50)

class TestMonsterTrain:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/MonsterTrain.gd")

	func test_choice_lead_success():
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("lead")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.damage, 15, "Player took damage")

	func test_choice_lead_failure():
		cfc.game_rng_seed = "<f<s_=ZJp@"
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("lead")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.damage, 15, "Player took damage")

	func test_choice_follow():
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("follow")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_gained", Terms.RUN_ACCUMULATION_NAMES.shop)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.damage, 7, "Player took damage")


	func test_choice_abort():
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("abort")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.elite)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.damage, 0, "Player took no damage")

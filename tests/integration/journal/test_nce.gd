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
		assert_nce_not_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/DollPickup.gd"))

class TestGreed:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/Greed.gd")

	func test_choice_accept():
		watch_signals(globals.player.deck)
		var lpathos = set_lowest_pathos("released")
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
		var lpathos = set_lowest_pathos("released")
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
		yield(yield_to(globals.player, "artifact_added", 0.2), YIELD)
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

class TestMultipleOptions:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/MultipleOptions.gd")

	func test_choice_progress():
		var porg := set_random_pathos_org("released")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("progress")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_entry_progressed")
		assert_pathos_signaled("pathos_spent", porg.low)

	func test_choice_upgrade():
		var porg := set_random_pathos_org("released")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("upgrade")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_entry_progressed")
		assert_pathos_signaled("pathos_spent", porg.mid)

	func test_choice_remove():
		var porg := set_random_pathos_org("released")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("remove")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(journal, "selection_deck_spawned")
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1, "Selected Deck spawned")
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
		watch_signals(globals.player.deck)
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_pathos_signaled("pathos_spent", porg.high)

	func test_choice_leave():
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_not_signaled("pathos_spent")

class TestPathosForAnxiety:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/PathosForAnxiety.gd")

	func test_choice_calm():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("calm")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.pathos, "released_pathos_gained")

	func test_choice_stress():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("stress")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.pathos, "released_pathos_gained")
		assert_between(globals.player.damage, 9, 11, "Player took damage")
		
	func test_choice_fear():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("fear")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.pathos, "released_pathos_gained")
		assert_between(globals.player.damage, 18, 22, "Player took damage")

class TestPopPsychologist1:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/PopPsychologist1.gd")

	func test_choice_tiger():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("tiger")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_gained", Terms.RUN_ACCUMULATION_NAMES.nce)
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd"))
	func test_choice_snake():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("snake")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_gained", Terms.RUN_ACCUMULATION_NAMES.enemy)
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd"))
	func test_choice_owl():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("owl")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_gained", Terms.RUN_ACCUMULATION_NAMES.shop)
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd"))

class TestPopPsychologist2:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd")

	func test_choice_passion_fruit():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("passion fruit")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_gained", Terms.RUN_ACCUMULATION_NAMES.artifact)
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd"))
	func test_choice_orange():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("orange")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_gained", Terms.RUN_ACCUMULATION_NAMES.elite)
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd"))
	func test_choice_bananal():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("banana")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_gained", Terms.RUN_ACCUMULATION_NAMES.rest)
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd"))

class TestPopPsychologist3:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist3.gd")
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


class TestRiskyEvent1:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/RiskyEvent1.gd")

	func test_choice_accept_failure():
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("accept")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_deck_signaled("card_added", "card_name", "Terror")
		
	func test_choice_accept_success():
		cfc.game_rng_seed = "tACXVN?OlF"
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("accept")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")
		assert_deck_signaled("card_added", "card_name", "Terror")

	func test_choice_decline():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("decline")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.pathos, "repressed_pathos_lost")
		assert_eq(globals.player.damage, 10)


class TestSlayTheSpire:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act1/SlayTheSpire.gd")

	func test_choice_slay():
		cfc.game_rng_seed = "tACXVN?OlF"
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("slay")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_gained", Terms.RUN_ACCUMULATION_NAMES.nce)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.enemy)
		assert_eq(globals.player.damage, 10, "Player took damage")
		
	func test_choice_decline():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_lost", Terms.RUN_ACCUMULATION_NAMES.enemy)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.nce)
		assert_eq(globals.player.damage, 0, "Player took no damage")

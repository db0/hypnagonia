extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestDollmaker:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/Dollmaker.gd")

	func test_choice_leave():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_nce_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/DollPickup.gd"))
		assert_signal_emitted(globals.player.pathos, "pathos_repressed")

	func test_choice_destroy():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("destroy")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.pathos, "released_pathos_gained")
		assert_nce_not_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/DollPickup.gd"))

class TestGreed:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/Greed.gd")

	func test_choice_accept():
		watch_signals(globals.player.deck)
		var lpathos = set_lowest_pathos("level")
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("accept")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_gt(lpathos.level, 0)
		assert_pathos_signaled("pathos_leveled", lpathos.name)
# warning-ignore:return_value_discarded
		assert_deck_signaled("card_added", "card_name", "Discombobulation")


	func test_choice_leave():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		var lpathos = set_lowest_pathos("level")
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("decline")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)

class TestMonsterTrain:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/MonsterTrain.gd")

	func test_choice_lead_success():
		nce.testing_rng = 60
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("lead")
		yield(yield_to(globals.player, "artifact_added", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")

	func test_choice_lead_failure():
		nce.testing_rng = 61
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("lead")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.damage, 15, "Player took damage")

	func test_choice_follow():
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("follow")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.pathos.available_masteries, Pathos.STARTING_MASTERIES + nce.MASTERIES_AMOUNT)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.damage, 7, "Player took damage")

	func test_choice_abort():
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("abort")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.elite)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.damage, 0, "Player took no damage")

class TestCrystalShattering:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/CrystalShattering.gd")

	func test_choice_progress():
		var porg := set_random_pathos_org("released")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("progress")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_entry_progressed")
		assert_pathos_signaled("pathos_spent", porg.low.name)

	func test_choice_upgrade():
		var porg := set_random_pathos_org("released")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("upgrade")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_entry_progressed")
		assert_pathos_signaled("pathos_spent", porg.mid.name)

	func test_choice_remove():
		var porg := set_random_pathos_org("released")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("remove")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		watch_signals(globals.player.deck)
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_pathos_signaled("pathos_spent", porg.high.name)

	func test_choice_leave():
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_not_signaled("pathos_spent")

class TestPathosForAnxiety:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/PathosForAnxiety.gd")

	func test_choice_calm():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("calm")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.pathos.available_masteries, Pathos.STARTING_MASTERIES + nce.MASTERY_AMOUNTS['calm'])

	func test_choice_stress():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("stress")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.pathos.available_masteries, Pathos.STARTING_MASTERIES + nce.MASTERY_AMOUNTS['stress'])
		assert_between(globals.player.damage, 9, 11, "Player took damage")
		
	func test_choice_fear():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("fear")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_between(globals.player.damage, 18, 22, "Player took damage")
		assert_eq(globals.player.pathos.available_masteries, Pathos.STARTING_MASTERIES + nce.MASTERY_AMOUNTS['fear'])

class TestPopPsychologist1:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/PopPsychologist1.gd")

	func test_choice_tiger():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		watch_signals(globals.player)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("tiger")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")
		var added_artifact_signal = get_signal_parameters(globals.player, "artifact_added")
		if not added_artifact_signal or added_artifact_signal.size() == 0:
			return
		var added_artifact: ArtifactObject = added_artifact_signal[0]
		assert_eq(added_artifact.canonical_name, nce.CURIOS['tiger'].canonical_name)
		assert_nce_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd"))
		
		assert_nce_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd"))
	func test_choice_snake():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("snake")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_nce_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd"))
		assert_signal_emitted(globals.player, "artifact_added")
		var added_artifact_signal = get_signal_parameters(globals.player, "artifact_added")
		if not added_artifact_signal or added_artifact_signal.size() == 0:
			return
		var added_artifact: ArtifactObject = added_artifact_signal[0]
		assert_eq(added_artifact.canonical_name, nce.CURIOS['snake'].canonical_name)

	func test_choice_owl():
		watch_signals(globals.encounters.run_changes)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("owl")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_nce_unlocked(load("res://src/dreamscape/Run/NCE/AllActs/PopPsychologist2.gd"))
		assert_signal_emitted(globals.player, "artifact_added")
		var added_artifact_signal = get_signal_parameters(globals.player, "artifact_added")
		if not added_artifact_signal or added_artifact_signal.size() == 0:
			return
		var added_artifact: ArtifactObject = added_artifact_signal[0]
		assert_eq(added_artifact.canonical_name, nce.CURIOS['owl'].canonical_name)


class TestHighwire:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/Highwire.gd")

	func test_choice_accept_failure():
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		nce._testing_rng = 41
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("accept")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player, "artifact_added")
# warning-ignore:return_value_discarded
		assert_deck_signaled("card_added", "card_name", "Terror")
		
	func test_choice_accept_success():
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		nce._testing_rng = 40
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("accept")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")
# warning-ignore:return_value_discarded
		assert_deck_signaled("card_added", "card_name", "Terror")

	func test_choice_decline():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("decline")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.pathos, "repressed_pathos_lost")
		assert_eq(globals.player.damage, 10)


class TestSlayTheSpire:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/SlayTheSpire.gd")

	func test_choice_slay():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("slay")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.pathos.available_masteries, Pathos.STARTING_MASTERIES + nce.SLAY_MASTERIES)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.enemy)
		assert_eq(globals.player.damage, 10, "Player took damage")
		
	func test_choice_decline():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.pathos.available_masteries, Pathos.STARTING_MASTERIES - nce.LEAVE_MASTERIES)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.nce)
		assert_eq(globals.player.damage, 0, "Player took no damage")

class TestSleepOfOblivion:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/SleepOfOblivion.gd")

	func test_choice_slay():
# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Terror")
# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Terror")
# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Lacuna")
# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Lacuna")
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("fall_in")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_removed", 4)
		assert_eq(globals.player.damage, 3, "Player took damage")
		
	func test_choice_decline():
# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Terror")
# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Terror")
# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Lacuna")
# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Lacuna")
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_not_signaled("released_pathos_lost")
		assert_pathos_not_signaled("pathos_repressed")
		assert_signal_emit_count(globals.player.deck, "card_removed", 0)
		assert_eq(globals.player.damage, 0, "Player took no damage")

class TestSpider:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act1/Spider.gd")
		dreamer_starting_damage = 30

	func test_choice_eat():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("eat")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.boss)
		assert_eq(globals.player.damage, dreamer_starting_damage - 10, "Player healed damage")
		
	func test_choice_wave():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("wave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.boss,0)
		assert_pathos_signaled("pathos_repressed", Terms.RUN_ACCUMULATION_NAMES.elite)
		assert_eq(globals.player.damage, dreamer_starting_damage, "Player healed damage")
		assert_eq(globals.player.health, 110, "Player max health increased")
				
	func test_choice_offer():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("offer")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_not_signaled("pathos_repressed")
		assert_eq(globals.player.damage, dreamer_starting_damage + 10, "Player healed damage")

extends "res://tests/HUTCommon_Journal.gd"

var JOURNAL_ENCOUNTER_CHOICE_SCENE = load("res://src/dreamscape/Overworld/JournalEncounterChoiceScene.tscn")

var testing_nce_script: Script
var nce: NonCombatEncounter
var journal_choice_scene
var nested_choices_scene

func before_each():
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	if testing_nce_script:
		add_nce(testing_nce_script)
	watch_signals(journal)

func add_nce(nce_script: Script) -> void:
	nce = nce_script.new()
	journal_choice_scene = JOURNAL_ENCOUNTER_CHOICE_SCENE.instance()
	watch_signals(nce)
	journal.journal_choices.add_child(journal_choice_scene)
	journal_choice_scene.setup(journal, nce)
	journal_choice_scene.journal_choice.connect("pressed", journal, "_on_choice_pressed", [nce, journal_choice_scene])
	journal._reveal_entry(journal_choice_scene.journal_choice)

func begin_nce_with_choices(nce_script: NonCombatEncounter) -> SecondaryChoiceSlide:
	nce_script.begin()
	yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
	var signal_details = get_signal_parameters(journal, "secondary_entry_added")
	assert_not_null(signal_details, "Secondary choices Added")
	if not signal_details:
		return(null)
	nested_choices_scene = signal_details[0]
	watch_signals(nested_choices_scene)
	return(nested_choices_scene)

func activate_secondary_choice_by_index(index: int) -> JournalNestedChoice:
	var all_secondary_choices = get_tree().get_nodes_in_group("secondary_choices")
	assert_gt(all_secondary_choices.size(), index, "As many secondary choices created as expected")
	if not all_secondary_choices.size() > index:
		return(null)
	var sc: JournalNestedChoice = all_secondary_choices[index]
	watch_signals(sc)
	sc.emit_signal("pressed")
	sc.remove_from_group("secondary_choices")
	return(sc)

func activate_secondary_choice_by_key(key) -> JournalNestedChoice:
	var sc: JournalNestedChoice
	for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
		if selected_choice.choice_key == key:
			sc = selected_choice
	assert_not_null(sc, "Ensure choice with specified key is found")
	if not sc:
		return(null)
	watch_signals(sc)
	sc.emit_signal("pressed")
	sc.remove_from_group("secondary_choices")
	return(sc)

func set_lowest_pathos(type := "repressed") -> String:
	var pathos = globals.player.pathos.grab_random_pathos()
	var pdict: Dictionary
	for p in globals.player.pathos.pathi.values():
		if p != pathos:
			p.set(type,100)
		else:
			p.set(type,50)
	return(pathos)

func set_highest_pathos(type := "repressed") -> String:
	var pathos = globals.player.pathos.grab_random_pathos()
	var pdict: Dictionary
	for p in globals.player.pathos.pathi.values():
		if p != pathos:
			p.set(type,50)
		else:
			p.set(type,100)
	return(pathos)

func set_random_pathos_org(type := "repressed", include_zeroes := false) -> Dictionary:
	var hpathos = globals.player.pathos.grab_random_pathos()
	var lpathos = globals.player.pathos.grab_random_pathos()
	while lpathos == hpathos:
		lpathos = globals.player.pathos.grab_random_pathos()
	var mpathos = globals.player.pathos.grab_random_pathos()
	while mpathos in [lpathos, hpathos]:
		mpathos = globals.player.pathos.grab_random_pathos()
	for p in globals.player.pathos.pathi.values():
		match p:
			hpathos:
				p.set(type,300)
			mpathos:
				p.set(type,200)
			lpathos:
				# If the game is looking for 0-pathos as well
				# Then we need to set the lowest pathos to 0
				# and everything else to higher than that
				# to ensure we grab the lowest pathos
				if include_zeroes:
					p.set(type,0)
				else:
					p.set(type,100)
			_:
				# If we do not include zeroes, we set all other pathos
				# to 0, to exclude them. This way we ensure the tests
				# will know the high, med and low pathos to be grabbed.
				# If zeroed pathos are included, then
				# WE CANNOT ENSURE THE MID PATHOS IS KNOWN FOR THE TESTS.
				if include_zeroes:
					p.set(type,100)
				else:
					p.set(type,0)
	var ret_dict := {
		"high": hpathos,
		"mid": mpathos,
		"low": lpathos,
	}
	return(ret_dict)

func assert_nce_unlocked(nce_script: GDScript) -> void:
	assert_signal_emitted(globals.encounters.run_changes, "nce_unlocked")
	var signal_details = get_signal_parameters(globals.encounters.run_changes,  "nce_unlocked")
	assert_not_null(signal_details, "NCE Unlocked")
	if not signal_details:
		return
	assert_eq(signal_details[0].nce, nce_script.resource_path, "Expected NCE Unlocked")
	assert_true(globals.encounters.run_changes._is_nce_unlocked(nce_script))

func assert_nce_not_unlocked(nce_script: GDScript) -> void:
	assert_signal_not_emitted(globals.encounters.run_changes, "nce_unlocked")
	assert_false(globals.encounters.run_changes._is_nce_unlocked(nce_script))

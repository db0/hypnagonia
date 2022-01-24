extends "res://tests/HUTCommon_Journal.gd"

const JOURNAL_ENCOUNTER_CHOICE_SCENE = preload("res://src/dreamscape/Overworld/JournalEncounterChoiceScene.tscn")

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

func activate_secondary_choice_by_index(index: int) -> void:
	var all_secondary_choices = get_tree().get_nodes_in_group("secondary_choices")
	assert_gt(all_secondary_choices.size(), index, "As many secondary choices created as expected")
	if not all_secondary_choices.size() > index:
		return
	var sc: JournalNestedChoice = all_secondary_choices[index]
	watch_signals(sc)
	sc.emit_signal("pressed")

func activate_secondary_choice_by_key(key) -> void:
	var sc: JournalNestedChoice
	for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
		if selected_choice.choice_key == key:
			sc = selected_choice
	assert_not_null(sc, "Ensure choice with specified key is found")
	if not sc:
		return
	watch_signals(sc)
	sc.emit_signal("pressed")

func set_lowest_pathos(type := "repressed") -> String:
	var pathos = globals.player.pathos.grab_random_pathos()
	var pdict: Dictionary
	if type == "repressed":
		pdict = globals.player.pathos.repressed
	else:
		pdict = globals.player.pathos.released
	for p in pdict:
		if p != pathos:
			pdict[p] = 100
		else:
			pdict[p] = 50
	return(pathos)

func set_highest_pathos(type := "repressed") -> String:
	var pathos = globals.player.pathos.grab_random_pathos()
	var pdict: Dictionary
	if type == "repressed":
		pdict = globals.player.pathos.repressed
	else:
		pdict = globals.player.pathos.released
	for p in pdict:
		if p != pathos:
			pdict[p] = 50
		else:
			pdict[p] = 100
	return(pathos)

func set_random_pathos_org(type := "repressed") -> Dictionary:
	var pdict: Dictionary
	if type == "repressed":
		pdict = globals.player.pathos.repressed
	else:
		pdict = globals.player.pathos.released
	var hpathos = globals.player.pathos.grab_random_pathos()
	var lpathos = globals.player.pathos.grab_random_pathos()
	while lpathos == hpathos:
		lpathos = globals.player.pathos.grab_random_pathos()
	var mpathos = globals.player.pathos.grab_random_pathos()
	while mpathos in [lpathos, hpathos]:
		mpathos = globals.player.pathos.grab_random_pathos()
	for p in pdict:
		match p:
			hpathos:
				pdict[p] = 300
			mpathos:
				pdict[p] = 200
			lpathos:
				pdict[p] = 100
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
	assert_eq(signal_details[0].nce, nce_script, "Expected NCE Unlocked")
	assert_true(globals.encounters.run_changes._is_nce_unlocked(nce_script))

func assert_nce_not_unlocked(nce_script: GDScript) -> void:
	assert_signal_not_emitted(globals.encounters.run_changes, "nce_unlocked")
	assert_false(globals.encounters.run_changes._is_nce_unlocked(nce_script))

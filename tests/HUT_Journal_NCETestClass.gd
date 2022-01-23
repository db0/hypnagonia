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

func begin_nce_with_choices(nce: NonCombatEncounter) -> void:
	nce.begin()
	yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
	var signal_details = get_signal_parameters(journal, "secondary_entry_added")
	assert_gt(signal_details.size(), 0, "Secondary choices added")
	if signal_details.size() >= 1:
		nested_choices_scene = get_signal_parameters(journal, "secondary_entry_added")[0]
		watch_signals(nested_choices_scene)

func activate_secondary_choice(index: int) -> void:
	var all_secondary_choices = get_tree().get_nodes_in_group("secondary_choices")
	assert_gt(all_secondary_choices.size(), index, "As many secondary choices created as expected")
	if not all_secondary_choices.size() > index:
		return
	var sc: JournalNestedChoice = all_secondary_choices[index]
	watch_signals(sc)
	sc.emit_signal("pressed")
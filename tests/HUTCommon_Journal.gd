extends "res://tests/UTCommon.gd"

### Pathos
var set_repressed_pathos := {}
var set_released_pathos := {}
### Other
var testing_artifact_names := []
var testing_memories_names := []

func before_each():
	if not globals.test_flags.has("no_journal_fade"):
		globals.test_flags["no_journal_fade"] = true	
	# warning-ignore:void_assignment
	var confirm_return = setup_journal()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	for pathos_name in Terms.RUN_ACCUMULATION_NAMES.values():
		if set_repressed_pathos.has(pathos_name):
			globals.player.pathos.repressed[pathos_name] = set_repressed_pathos[pathos_name]
		else:
			globals.player.pathos.repressed[pathos_name] = 0
	for pathos_name in Terms.RUN_ACCUMULATION_NAMES.values():
		if set_released_pathos.has(pathos_name):
			globals.player.pathos.released[pathos_name] = set_released_pathos[pathos_name]
		else:
			globals.player.pathos.released[pathos_name] = 0
	artifacts = setup_test_artifacts(testing_artifact_names)
	memories = setup_test_memories(testing_memories_names)
	yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)


func after_each():
	teardown_hypnagonia_testing()
	yield(yield_for(0.1), YIELD)

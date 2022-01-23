extends "res://tests/UTCommon.gd"

### Pathos
var set_repressed_pathos := {}
var set_released_pathos := {}
### Other
var test_artifact_names := []
var test_memories_names := []
var test_card_names := []
var cards := []

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
	cards = setup_deck_cards(test_card_names)
	artifacts = setup_test_artifacts(test_artifact_names)
	memories = setup_test_memories(test_memories_names)
	yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)


func after_each():
	teardown_hypnagonia_testing()
	yield(yield_for(0.1), YIELD)


func assert_pathos_signaled(signal_name: String, pathos: String) -> void:
	var signal_details = get_signal_parameters(globals.player.pathos, signal_name)
	assert_not_null(signal_details, signal_name + " signal emited by pathos")
	if not signal_details:
		return
	assert_eq(signal_details[0], pathos, "Correct pathos modified")

func assert_deck_signaled(signal_name: String, card_property: String, property_value) -> void:
	var signal_details = get_signal_parameters(globals.player.deck, signal_name)
	assert_not_null(signal_details, signal_name + " signal emited by deck")
	if not signal_details:
		return
	if card_property == "card_name":
		assert_eq(signal_details[0].card_name, property_value, "Card %s property matches %s" % [card_property, property_value])

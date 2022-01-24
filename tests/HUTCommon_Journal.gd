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


func assert_pathos_signaled(signal_name: String, pathos: String, index := -1) -> void:
	assert_signal_emitted(globals.player.pathos, signal_name)
	# If more than 1 signal of the same name emited, then you need to specify the index
	# To find the previous ones
	var signal_details = get_signal_parameters(globals.player.pathos, signal_name, index)
	assert_not_null(signal_details, signal_name + " signal emited by pathos")
	if not signal_details:
		return
	
	assert_eq(signal_details[0], pathos, "Correct pathos modified")
	
func assert_pathos_not_signaled(signal_name: String, pathos := '') -> void:
	assert_signal_not_emitted(globals.player.pathos, signal_name)
	if pathos == '':
		return
	var signal_details = get_signal_parameters(globals.player.pathos, signal_name)
	if not signal_details:
		return
	assert_ne(signal_details[0], pathos, "Wrong pathos not modified")

func assert_deck_signaled(signal_name: String, property_key: String, property_value, index := -1) -> CardEntry:
	assert_signal_emitted(globals.player.deck, signal_name)
	var signal_details = get_signal_parameters(globals.player.deck, signal_name, index)
	assert_not_null(signal_details, signal_name + " signal emited by deck")
	if not signal_details:
		return(null)
	if property_key == "card_name":
		assert_eq(signal_details[0].card_name, property_value, "Card %s property matches %s" % [property_key, property_value])
	# For amounts, we just want to ensure that amount key exists in the emited card entry
	elif property_key == "_amounts":
		assert_has(signal_details[0].properties.get("_amounts", {}), property_value, "Card %s property matches %s" % [property_key, property_value])
	elif property_key == "Tags":
		assert_has(signal_details[0].properties.get("Tags", []), property_value, "Card %s property matches %s" % [property_key, property_value])
	else:
		assert_eq(signal_details[0].properties[property_key], property_value, "Card %s property matches %s" % [property_key, property_value])
	return(signal_details[0])

func assert_player_signaled(signal_name: String, property_key: String, property_value: String, index := -1) -> ArtifactObject:
	assert_signal_emitted(globals.player, signal_name)
	var signal_details = get_signal_parameters(globals.player, signal_name, index)
	assert_not_null(signal_details, signal_name + " signal emited by player")
	if not signal_details:
		return(null)
	assert_eq(signal_details[0].definition[property_key], property_value, "Artifact %s property matches %s" % [property_key, property_value])
	return(signal_details[0])

func assert_selection_deck_spawned() -> SelectionDeck:
	assert_signal_emitted(journal, "selection_deck_spawned")
	var selection_decks =  get_tree().get_nodes_in_group("selection_decks")
	assert_eq(selection_decks.size(), 1, "Selected Deck spawned")
	if selection_decks.size() == 0:
		return(null)
	var selection_deck : SelectionDeck = selection_decks[0]
	return(selection_deck)

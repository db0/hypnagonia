class_name SingleRun
extends Reference

const EARLY_ENCOUNTERS := [
	[
		"The Laughing One",
		"The Laughing One",
	],
	[
		"Fearmonger",
	],
	[
		"Gaslighter",
	],
]

const ENCOUNTERS := [
	[
		"The Laughing One",
		"The Laughing One",
		"The Laughing One",
	],
	[
		"Fearmonger",
		"The Laughing One",
	],
	[
		"Gaslighter",
		"Gaslighter",
	],
]

var remaining_early_encounters := EARLY_ENCOUNTERS
var remaining_encounters := ENCOUNTERS
var current_encounter: Array

func _init() -> void:
	CFUtils.shuffle_array(remaining_early_encounters)
	CFUtils.shuffle_array(remaining_encounters)
	
func get_next_encounter() -> Array:
	var next_encounter : Array
	if globals.encounter_number <= 3:
		next_encounter = remaining_early_encounters.pop_back()
	else:
		next_encounter = remaining_encounters.pop_back()
	current_encounter = next_encounter
	return(next_encounter)

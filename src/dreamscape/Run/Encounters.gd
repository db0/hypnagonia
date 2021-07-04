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

const BOSSES := {
	"Narcissus": preload("res://src/dreamscape/CombatElements/Enemies/Bosses/Narcissus.tscn")
}


var remaining_early_encounters := EARLY_ENCOUNTERS.duplicate(true)
var remaining_encounters := ENCOUNTERS.duplicate(true)
var boss_name : String
var current_encounter

func setup() -> void:
	CFUtils.shuffle_array(remaining_early_encounters)
	CFUtils.shuffle_array(remaining_encounters)
	print_debug(remaining_encounters)
	var boss_choices := BOSSES.keys()
	CFUtils.shuffle_array(boss_choices)
	boss_name = boss_choices[0]

	
func get_next_encounter():
	var next_encounter
	if globals.encounter_number <= 3:
		next_encounter = remaining_early_encounters.pop_back()
	elif globals.encounter_number >= 7:
		next_encounter = BOSSES[boss_name]
	else:
		next_encounter = remaining_encounters.pop_back()
	globals.encounter_number += 1
	current_encounter = next_encounter
	return(next_encounter)


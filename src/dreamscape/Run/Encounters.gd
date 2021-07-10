class_name SingleRun
extends Reference

const EARLY_ENEMIES := [
	{
		"journal_description":\
			'I found myself between [url={torment_tag}]a pair of featureless creeps laughing[/url] at me.',
		"enemies": [
			"The Laughing One",
			"The Laughing One",
		]
	},
	{
		"journal_description":\
			'I saw [url={torment_tag}]a curious owl with three eyes[/url] shadowing me.',
		"journal_art": preload("res://assets/journal/fearmonger.jpg"),
		"enemies": [
			"Fearmonger",
		]
	},
	{
		"journal_description":\
			'I saw [url={torment_tag}]a strange form with a head like a lamp[/url] moving towards me.',
		"enemies": [
			"Gaslighter",
		]
	},
]

const ENEMIES := [
	{
		"journal_description": '',
		"enemies": [
			"The Laughing One",
			"The Laughing One",
			"The Laughing One",
		]
	},
	{
		"journal_description": '',
		"enemies": [
			"The Laughing One",
			"Fearmonger",
		]
	},
	{
		"journal_description": '',
		"enemies": [
			"Gaslighter",
			"Gaslighter",
		]
	},
]

const BOSSES := {
	"Narcissus": {
		"scene": preload("res://src/dreamscape/CombatElements/Enemies/Bosses/Narcissus.tscn"),
		"journal_description": '',
	}
}


var remaining_early_enemies := EARLY_ENEMIES.duplicate(true)
var remaining_enemies := ENEMIES.duplicate(true)
var boss_name : String
var current_encounter

func setup() -> void:
	CFUtils.shuffle_array(remaining_early_enemies)
	CFUtils.shuffle_array(remaining_enemies)
	var boss_choices := BOSSES.keys()
	CFUtils.shuffle_array(boss_choices)
	boss_name = boss_choices[0]

	
func get_next_encounter():
	var next_encounter
	if globals.encounter_number <= 3:
		next_encounter = remaining_early_enemies.pop_back()['enemies']
	elif globals.encounter_number >= 7:
		next_encounter = BOSSES[boss_name]['scene']
	else:
		next_encounter = remaining_enemies.pop_back()['enemies']
	globals.encounter_number += 1
	current_encounter = next_encounter
	return(next_encounter)


func get_next_enemies():
	var next_encounter
	if globals.encounter_number <= 3:
		next_encounter = remaining_early_enemies.pop_back()
	elif globals.encounter_number >= 7:
		next_encounter = BOSSES[boss_name]
	else:
		next_encounter = remaining_enemies.pop_back()
	globals.encounter_number += 1
	current_encounter = next_encounter
	return(next_encounter)

func generate_journal_choices() -> void:
	var choices := {
		1: {
			"description": 'I saw [url={torment_tag}]a strange form with a head like a lamp[/url] moving towards me',
			"torment": "Gaslighter",
			"meta_tag": "boss",
		}
	}
	var current_choice_gen := 1
	var journal_options := {}
	var next_enemy
	if globals.encounter_number >= 7:
		next_enemy = BOSSES[boss_name]
		journal_options[current_choice_gen] = {}
		journal_options[current_choice_gen]["description"] = next_enemy["journal_description"]
		journal_options[current_choice_gen]["meta_tag"] = "boss"
	elif globals.encounter_number <= 3:
		next_enemy = remaining_early_enemies.pop_back()
	else:
		next_enemy = remaining_enemies.pop_back()

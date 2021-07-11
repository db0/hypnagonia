class_name SingleRun
extends Reference

const EARLY_ENEMIES := [
	{
		"journal_description":\
			'I found myself between [url={torment_tag1}]a pair of featureless creeps laughing[/url] at me.',
		"journal_reward":\
			'Through overcoming that weird experience, [url=reward]I felt wiser.[/url]',
		"enemies": [
			"The Laughing One",
			"The Laughing One",
		]
	},
	{
		"journal_description":\
			'Was that [url={torment_tag1}]a curious owl with three eyes[/url] staring at me?',
		"journal_reward":\
			'Through overcoming that weird experience, [url=reward]I felt wiser.[/url]',
		"journal_art": preload("res://assets/journal/fearmonger.jpg"),
		"enemies": [
			"Fearmonger",
		]
	},
	{
		"journal_description":\
			'I saw [url={torment_tag1}]a strange form with a head like a lamp[/url] moving towards me.',
		"journal_reward":\
			'Through overcoming that weird experience, [url=reward]I felt wiser.[/url]',
		"enemies": [
			"Gaslighter",
		]
	},
]

const ENEMIES := [
	{
		"journal_description": '',
		"journal_reward":\
			'Through overcoming that weird experience, I felt wiser.',
		"enemies": [
			"The Laughing One",
			"The Laughing One",
			"The Laughing One",
		]
	},
	{
		"journal_description": '',
		"journal_reward":\
			'Through overcoming that weird experience, I felt wiser.',
		"enemies": [
			"The Laughing One",
			"Fearmonger",
		]
	},
	{
		"journal_description": '',
		"journal_reward":\
			'Through overcoming that weird experience, I felt wiser.',
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


func generate_journal_choices() -> Array:
	var journal_options := []
	var next_enemy
	if globals.encounter_number >= 7:
		journal_options.append(BossEncounter.new(BOSSES[boss_name], boss_name))
	else:
		if globals.encounter_number <= 3:
			next_enemy = remaining_early_enemies.pop_back()
		else:
			next_enemy = remaining_enemies.pop_back()
		journal_options.append(EnemyEncounter.new(next_enemy))
	return(journal_options)

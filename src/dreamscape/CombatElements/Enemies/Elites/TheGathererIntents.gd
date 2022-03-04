extends BossIntents

var painkillers_given := false
var teeth_pulled := 0

const INTENTS := [
	{
		"intent_scripts": ["Gather Dreams"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Show Possibilities"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Lock Dreams"],
		"reshuffle": true,
		"max_uses": 4,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Array:
	var intent_scripts := []
	var script : Dictionary
	var difficulty
	match combat_entity.get_property("_difficulty"):
		"easy":
			difficulty = 3
		"medium":
			difficulty = 4
		"hard":
			difficulty = 5
	match intent_name:
		"Gather Dreams":
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 9 + difficulty,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]I feel my thoughts slipping away from me.[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "move_card_to_container",
				"subject": "index",
				"subject_index": "random",
				"src_container": "hand",
				"dest_container": "discard",
				"tags": ["Intent"],
				"icon": all_intent_scripts.ICON_SPECIAL,
				"description": "Gather Dreams\n[i]I wanted to do something. What was it..?[/i]"
			}
			intent_scripts.append(script)
			intent_scripts.append(script)
		"Show Possibilities":
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": difficulty,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]There's too many options![/i]"
			}
			for _iter in range(3):
				intent_scripts.append(script)
		"Lock Dreams":
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": (difficulty * 2) + 3,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]I cannot quite recall what I was about to do.[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.disruption.name,
				"subject": "dreamer",
				"modification": 1,
				"tags": ["Intent"],
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "Lock Dreams: [i]My possibilities are reduced.[/i]"
			}
			intent_scripts.append(script)

	return(intent_scripts)

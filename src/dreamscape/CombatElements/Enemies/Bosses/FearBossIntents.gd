extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Confront"],
		"reshuffle": true,
		"max_in_a_row": 1,
	},
	{
		"intent_scripts": ["Envelop"],
		"reshuffle": false,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)

func prepare_intents(starting_index = null, _is_second_try := false) -> Dictionary:
	var new_intents : Dictionary
	new_intents = .prepare_intents(starting_index)
	return(new_intents)

func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_boss_scripts(intent_name))


func _get_boss_scripts(intent_name: String) -> Array:
	var scripts := {
		"Confront": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 5,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]I can't face this![/i]"
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 5,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]I can't face this![/i]"
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 5,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]I can't face this![/i]"
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 5,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]I can't face this![/i]"
			},
		],
		"Envelop": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"tags": ["Intent"],
				"subject": "boardseek",
				"subject_count": "all",
				"modification": 2,
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "[i]I start seeing the thing I fear most, even more clearly...[/i]"
			},
		],
	}
	return(scripts.get(intent_name,{}))

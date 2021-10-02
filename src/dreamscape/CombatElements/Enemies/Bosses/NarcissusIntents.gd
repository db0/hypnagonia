extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Denial"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Minimisation"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Gaslighting"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Blameshifting"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Irresponsibility"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Projection"],
		"reshuffle": true,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)

func prepare_intents(_starting_index = null) -> void:
	if not unused_intents.size():
		reshuffle_intents()
	var new_intents : Dictionary = unused_intents.pop_front().duplicate(true)
	if new_intents.reshuffle:
		reshuffle_intents()
	_display_intents(new_intents)


func _get_intent_scripts(intent_name: String) -> Dictionary:
	return(_get_boss_scripts(intent_name))


func _get_boss_scripts(intent_name: String) -> Dictionary:
	var scripts := {
		"Denial": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 4,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "That didn't happen."
			}
		],
		"Minimisation": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 10 + get_outrage(),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "And if it did..."
			},
			{
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 15,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description": "...it wasn't that bad."
			}			
		],
		"Gaslighting": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 1 + get_outrage(),
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "And if it was..."
			},
			{
				"name": "spawn_enemy",
				"enemy": EnemyDefinitions.GASLIGHTER,
				"tags": ["Intent"],
				"modify_spawn_health": -25 + (get_outrage() * 2),
				"icon": preload("res://assets/icons/alien-egg.png"),
				"description": "...that's not a big deal."
			}
		],
		"Blameshifting": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 4,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "And if it is..."
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 5 + get_outrage(),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "... that's not my fault."
			},
		],
		"Irresponsibility": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 2,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "And if it was..."
			},
			{
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 10,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description":  "...I didn't mean it."
			}
		],
		"Projection": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.outrage.name,
				"tags": ["Intent"],
				"subject": "self",
				"modification": 1,
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "And if I did..."
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 23 + (get_outrage() * 2),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "...you deserved it."
			},
		],
	}
	return(scripts.get(intent_name,{}))

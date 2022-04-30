extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Lost"],
		"reshuffle": true,
		"max_uses": 1,
	},
	{
		"intent_scripts": ["Wandering"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Wandering"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Wandering"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Despair"],
		"reshuffle": true,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Array:
	var enraged_stacks: int
	match combat_entity.get_property("_difficulty"):
		"easy":
			enraged_stacks = 1
		"medium":
			enraged_stacks = 2
		"hard":
			enraged_stacks = 3
	var scripts := {
		"Lost": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.enraged.name,
				"tags": ["Intent"],
				"subject": "self",
				"modification": enraged_stacks,
				"icon": all_intent_scripts.ICON_SPECIAL,
				"description": "Lost: [i]How did I get here? How do I get out..?[/i]"
			}
		],
		"Wandering": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 14,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Wandering: [i]I'll never get out![/i]"
			},
		],
		"Despair": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.empower.name,
				"tags": ["Intent"],
				"subject": "self",
				"modification": 2,
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "Despair: [i]Did I pass here before?[/i]"
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 6,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Despair: [i]I'll never get out![/i]"
			},
		],
	}
	return(scripts.get(intent_name,{}))

extends BossIntents

const INTENTS := [
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

var _add_starting_intent:= true

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)

func prepare_intents(_starting_index = null) -> void:
	if not unused_intents.size():
		reshuffle_intents()
	if _add_starting_intent:
		var lost_intent = {
			"intent_scripts": ["Lost"],
			"reshuffle": true,
		}
		unused_intents.push_front(lost_intent)
		_add_starting_intent = false
	var new_intents : Dictionary = unused_intents.pop_front().duplicate(true)
	if new_intents.reshuffle:
		reshuffle_intents()
	_display_intents(new_intents)


func _get_intent_scripts(intent_name: String) -> Dictionary:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Dictionary:
	var enraged_stacks: int
	match get_parent().get_property("_difficulty"):
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
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "How did I get here? How do I get out..?"
			}
		],
		"Wandering": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 14,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "I'll never get out!"
			},
		],
		"Despair": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 2,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "Did I pass here before?"
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 6,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "I'll never get out!"
			},
		],
	}
	return(scripts.get(intent_name,{}))

extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Illusionary"],
		"reshuffle": true,
		"max_in_a_row": 1,
	},
	{
		"intent_scripts": ["Non-Euclidian"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Infinite"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Fractal"],
		"reshuffle": false,
	},
]

const SPECIAL_INTENTS := {
	"Impossibility": {
		"intent_scripts": ["Impossibility"],
		"reshuffle": false,
	},
}

var must_check_for_dreamer_anxiety_taken := false
var pre_stress_dreamer_anxiety : int

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)

func prepare_intents(_starting_index = null, _is_second_try := false) -> Dictionary:
	var new_intents : Dictionary
	if combat_entity.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name) >= 7:
		new_intents = SPECIAL_INTENTS["Impossibility"]
		times_last_intent_repeated = 0
		_display_intents(new_intents)
	else:
		new_intents = .prepare_intents()
	for intent_name in ["Illusionary", "Non-Euclidian"]:
		if intent_name in new_intents["intent_scripts"]:
			must_check_for_dreamer_anxiety_taken = true
	return(new_intents)

func _pre_execute_scripts() -> void:
	if must_check_for_dreamer_anxiety_taken:
		pre_stress_dreamer_anxiety = cfc.NMAP.board.dreamer.damage

func _post_execute_scripts() -> void:
	if must_check_for_dreamer_anxiety_taken\
			and pre_stress_dreamer_anxiety >= cfc.NMAP.board.dreamer.damage:
		combat_entity.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, 1, false, false, ["Scripted"]) 
	must_check_for_dreamer_anxiety_taken = false

func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_boss_scripts(intent_name))


func _get_boss_scripts(intent_name: String) -> Array:
	var scripts := {
		"Illusionary": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 10,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]I think my eyes are playing tricks on me.[/i]"
			},
			{
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 10,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description":  "[i]It seems to be moving whenever I don't look directly at it.[/i]"
			}
		],
		"Non-Euclidian": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 16,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]These two pieces can't possibly fit together. How is this possible..?[/i]"
			},
		],
		"Infinite": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
				"tags": ["Intent"],
				"subject": "self",
				"modification": 4,
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "[i]I can't find its end...[/i]"
			},
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
				"tags": ["Intent", "Delayed"],
				"subject": "dreamer",
				"modification": 1,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "[i]I can't find where it starts either![/i]"
			},
		],
		"Fractal": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"tags": ["Intent"],
				"subject": "self",
				"modification": 2,
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "[i]The deeper I look into it, the more details I see![/i]"
			},
		],
		"Impossibility": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 11,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]I feel a headache coming...[/i]"
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 11,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]...and it's a bad one![/i]"
			},
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"tags": ["Intent"],
				"subject": "self",
				"modification": 0,
				"set_to_mod": true,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "[i]I may be getting a bit more used to this...[/i]"
			},
		],
	}
	return(scripts.get(intent_name,{}))

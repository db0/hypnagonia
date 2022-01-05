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

func prepare_intents(_starting_index = null, _is_second_try := false) -> Dictionary:
	if not unused_intents.size():
		reshuffle_intents()
	var new_intents : Dictionary = unused_intents.pop_front().duplicate(true)
	if new_intents.reshuffle:
		reshuffle_intents()
	_display_intents(new_intents)
	return(new_intents)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_boss_scripts(intent_name))


func _get_boss_scripts(intent_name: String) -> Array:
	var intent_scripts := []
	var script : Dictionary
	match intent_name:
		"Denial":
			if cfc.NMAP.board.dreamer.health - cfc.NMAP.board.dreamer.damage > 10:
				var poison = 4
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"tags": ["Intent", "Delayed"],
					"subject": "dreamer",
					"modification": 4,
					"set_to_mod": true,
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "[i]That didn't happen.[/i]"
				}
			else:
				script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
				"tags": ["Intent", "Delayed"],
				"subject": "dreamer",
				"modification": 2,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "[i]That didn't happen.[/i]"
			}
			intent_scripts.append(script)
		"Minimisation":
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 10 + get_outrage(),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]And if it did...[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 15,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description": "[i]...it wasn't that bad.[/i]"
			}
			intent_scripts.append(script)
		"Gaslighting":
			var effect = Terms.ACTIVE_EFFECTS.poison.name
			if cfc.NMAP.board.dreamer.health - cfc.NMAP.board.dreamer.damage <= 10:
				effect = Terms.ACTIVE_EFFECTS.vulnerable.name
			script = {
				"name": "apply_effect",
				"effect_name": effect,
				"tags": ["Intent", "Delayed"],
				"subject": "dreamer",
				"modification": 1 + get_outrage(),
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "[i]And if it was...[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "spawn_enemy",
				"enemy": EnemyDefinitions.GASLIGHTER,
				"tags": ["Intent"],
				"modify_spawn_health": -25 + (get_outrage() * 2),
				"set_spawn_as_minion": true,
				"icon": preload("res://assets/icons/alien-egg.png"),
				"description": "[i]...that's not a big deal.[/i]"
			}
			intent_scripts.append(script)
		"Blameshifting":
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 4,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "[i]And if it is...[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 5 + get_outrage(),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]...that's not my fault.[/i]"
			}
			intent_scripts.append(script)
		"Irresponsibility":
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 2,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "[i]And if it was...[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 10,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description":  "[i]...I didn't mean it.[/i]"
			}
			intent_scripts.append(script)
		"Projection":
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.outrage.name,
				"tags": ["Intent"],
				"subject": "self",
				"modification": 1,
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "[i]And if I did...[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 23 + (get_outrage() * 2),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "[i]...you deserved it.[/i]"
			}
			intent_scripts.append(script)
	return(intent_scripts)

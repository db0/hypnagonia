extends BossIntents

var painkillers_given := false
var teeth_pulled := 0

const INTENTS := [
	{
		"intent_scripts": ["Pull Tooth"],
		"reshuffle": false,
		"max_uses": 5,
		"sets_up_intent": "Anesthesia",
	},
	{
		"id": "Anesthesia",
		"intent_scripts": ["Anesthesia"],
		"reshuffle": false,
		"not_in_rotation": true,
	},
	{
		"intent_scripts": ["Clean"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Drill"],
		"reshuffle": true,
		"max_in_a_row": 1,
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
		"Pull Tooth":
			teeth_pulled += 1
			script = {
				"name": "modify_health",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": -difficulty,
				"icon": preload("res://assets/icons/tooth.png"),
				"description": "Pull Tooth: [i]I'm afraid this one has to come out...[/i]"
			}
			intent_scripts.append(script)
			script = {
					"name": "assign_defence",
					"tags": ["Intent"],
					"subject": "self",
					"amount": 15,
					"icon": all_intent_scripts.ICON_DEFEND,
					"description": "Perplex: Will give this Torment the specified amount of {perplexity}."
				}
			intent_scripts.append(script)
		"Anesthesia":
			if not painkillers_given:
				painkillers_given = true
				script = {
					"name": "perturb",
					"card_name": "Dubious Painkillers",
					"dest_container": "deck",
					"object_count": 1,
					"is_permanent": true,
					"tags": ["Intent"],
					"icon": all_intent_scripts.ICON_SPECIAL,
					"description": "Painkillers: [i]And here's something to take at home[/i]"
				}
				intent_scripts.append(script)
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
				"subject": "dreamer",
				"modification": 2,
				"show_modification_in_intent": true,
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/shrug.png"),
				"description": "Anesthesia: Next turn you will have this amount less {immersion}\n"\
						+ "[i]You're starting to feel a bit wobbly[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 5,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description": "Perplex: Will give this Torment the specified amount of {perplexity}."
			}
		"Clean":
			if teeth_pulled < INTENTS[0].max_uses:
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"subject": "dreamer",
					"modification": 2,
					"tags": ["Intent"],
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "Clean: This Torment is planning to apply a debuff to the Dreamer.\n"\
							+ "[i]Now spit.[/i]"
				}
				intent_scripts.append(script)
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
					"subject": "self",
					"modification": difficulty,
					"tags": ["Intent"],
					"icon": all_intent_scripts.ICON_BUFF,
					"description": "Clean: This Torment is planning to buff itself.\n"\
							+ "[i]Would you like some water?[/i]"
				}
				intent_scripts.append(script)
			else:
				for _iter in range(difficulty):
					script = {
						"name": "modify_damage",
						"tags": ["Attack", "Intent"],
						"subject": "dreamer",
						"amount": 4,
						"icon": all_intent_scripts.ICON_ATTACK,
						"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n",
					}
					intent_scripts.append(script)
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
					"subject": "dreamer",
					"modification": 2,
					"tags": ["Intent"],
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "Deep Clean: This Torment is planning to apply a debuff to the Dreamer.\n"\
							+ "[i]I can see my work is cut out for me.[/i]"
				}
				intent_scripts.append(script)
		"Drill":
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": (difficulty + 1) * 5,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]You really should be flossing more...[/i]"
			}
			intent_scripts.append(script)
	return(intent_scripts)

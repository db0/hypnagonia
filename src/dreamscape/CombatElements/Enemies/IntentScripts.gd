class_name IntentScripts
extends Resource

export(StreamTexture) var ICON_ATTACK := preload("res://assets/icons/terror.png")
export(StreamTexture) var ICON_DEFEND := preload("res://assets/icons/shield.png")
export(StreamTexture) var ICON_BUFF := preload("res://assets/icons/cursed-star.png")
export(StreamTexture) var ICON_DEBUFF := preload("res://assets/icons/growth.png")

func get_scripts(intent_name: String) -> Dictionary:
	var scripts := {
		"Stress": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": null,
				"icon": ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}."
			}
		],
		"Perplex": [
			{
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": null,
				"icon": ICON_DEFEND,
				"description": "Perplex: Will give this Torment the specified amount of {perplexity}."
			}
		],
		"Debuff": [
			{
				"name": "apply_effect",
				"effect_name": null,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": null,
				"icon": ICON_BUFF,
				"description": "This Torment is planning to apply a debuff to the Dreamer."
			}
		],
		"Buff": [
			{
				"name": "apply_effect",
				"effect_name": null,
				"tags": ["Intent"],
				"subject": "self",
				"modification": null,
				"icon": ICON_DEBUFF,
				"description": "This Torment is planning to buff itself."
			}
		],
		"Stare": [
			{
				"name": "perturb",
				"card_name": "Dread",
				"dest_container": cfc.NMAP.discard,
				"object_count": 1,
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/alien-stare.png"),
				"description": "Stare: It's not blinking..."
			}
		],
	}
	return(scripts.get(intent_name,{}))

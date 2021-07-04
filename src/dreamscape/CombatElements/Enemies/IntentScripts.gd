class_name IntentScripts
extends Reference

func get_scripts(intent_name: String) -> Dictionary:
	var scripts := {
		"Stress": [
			{
				"name": "modify_damage",
				"tags": ["Damage", "Intent"],
				"subject": "dreamer",
				"amount": null,
				"icon": "res://assets/icons/terror.png",
				"description": "Stress: Will cause the dreamer to take the specified amount of anxiety."
			}
		],
		"Perplex": [
			{
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": null,
				"icon": "res://assets/icons/shield.png",
				"description": "Perplex: Will give this Torment the specified amount of Perplexity."
			}
		],
		"Debuff": [
			{
				"name": "apply_effect",
				"effect_name": null,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": null,
				"icon": "res://assets/icons/cursed-star.png",
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
				"icon": "res://assets/icons/growth.png",
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
				"icon": "res://assets/icons/alient-stare.png",
				"description": "Stare: It's not blinking..."
			}
		],
	}
	return(scripts.get(intent_name,{}))

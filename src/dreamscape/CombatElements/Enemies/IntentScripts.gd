class_name IntentScripts
extends Resource

export(StreamTexture) var ICON_ATTACK := preload("res://assets/icons/terror.png")
export(StreamTexture) var ICON_DEFEND := preload("res://assets/icons/shield.png")
export(StreamTexture) var ICON_DEBUFF := preload("res://assets/icons/cursed-star.png")
export(StreamTexture) var ICON_BUFF := preload("res://assets/icons/growth.png")

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
				"tags": ["Intent", "Delayed"],
				"subject": "dreamer",
				"modification": null,
				"icon": ICON_DEBUFF,
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
				"icon": ICON_BUFF,
				"description": "This Torment is planning to buff itself."
			}
		],
		"Stare": [
			{
				"name": "perturb",
				"card_name": "Dread",
				"dest_container": "discard",
				"object_count": 1,
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/alien-stare.png"),
				"description": "Stare: [i]It's not blinking...[/i]"
			}
		],
		"Delight": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.delighted.name,
				"subject": "dreamer",
				"modification": 1,
				"tags": ["Intent", "Delayed"],
				"icon": preload("res://assets/icons/smitten.png"),
				"description": "Delightful: [i]Aww, it's adorable![/i]"
			}
		],
		"Lethargy": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
				"subject": "dreamer",
				"modification": null,
				"show_modification_in_intent": true,
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/shrug.png"),
				"description": "Lethargy: Next turn you will have this amount less {immersion}\n"\
						+ "[i]I need to see behind it...[/i]"
			}
		],
		"Evident": [
			{
				"name": "modify_damage",
				"tags": ["Unblockable", "Intent"],
				"subject": "self",
				"amount": null,
				"icon": preload("res://assets/icons/spectacle-lenses.png"),
				"description": "Evident: This will cause this Torment the specified amount of {damage}."
			}
		],
		"Frustrate": [
			{
				"name": "modify_pathos",
				"tags": ["Intent"],
				"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
				"pathos_type": "repressed",
				"amount": null,
				"icon": preload("res://assets/icons/traffic-cone.png"),
				"description": "Frustrate: This will increase the dreamer's repressed frustration by the shown amount.\n"\
						+ "[i]Every day the same deal...[/i]"
			}
		],
		"Dishearten": [
			{
				"name": "modify_pathos",
				"tags": ["Intent"],
				"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
				"pathos_type": "released",
				"amount": null,
				"icon": preload("res://assets/icons/traffic-cone.png"),
				"description": "Dishearten: This will decrease the dreamer's released frustration by the shown amount.\n"\
						+ "[i]I'll never make it in time...[/i]"
			}
		],
	}
	return(scripts.get(intent_name,{}))

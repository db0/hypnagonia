class_name IntentScripts
extends Resource

export(StreamTexture) var ICON_ATTACK := preload("res://assets/icons/terror.png")
export(StreamTexture) var ICON_PIERCE := preload("res://assets/icons/pierced-heart.png")
export(StreamTexture) var ICON_DEFEND := preload("res://assets/icons/shield.png")
export(StreamTexture) var ICON_DEBUFF := preload("res://assets/icons/cursed-star.png")
export(StreamTexture) var ICON_BUFF := preload("res://assets/icons/growth.png")
export(StreamTexture) var ICON_SPECIAL := preload("res://assets/icons/uncertainty.png")

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
		"PerplexGroup": [
			{
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "boardseek",
				"amount": null,
				"subject_count": "all",
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
				"icon": ICON_DEFEND,
				"description": "Perplex Group: Will give all Torments the specified amount of {perplexity}."
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
		"BuffGroup": [
			{
				"name": "apply_effect",
				"effect_name": null,
				"tags": ["Intent"],
				"subject": "boardseek",
				"modification": null,
				"subject_count": "all",
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
				"icon": ICON_BUFF,
				"description": "This Torment is planning to buff all Torments."
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
		"Unfocus": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"subject": "self",
				"modification": "per_effect_stacks",
				"per_effect_stacks": {
					"subject": "self",
					"effect_name": Terms.ACTIVE_EFFECTS.rebalance.name,
					"is_inverted": true,
				},
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/uncertainty.png"),
				"description": "Unfocus: [i]Somehow this doesn't feel as important as it first appeared...[/i]"
			}
		],
		"Pencils Ready": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.the_exam.name,
				"subject": "dreamer",
				"modification": "per_effect_stacks",
				"per_effect_stacks": {
					"subject": "self",
					"effect_name": Terms.ACTIVE_EFFECTS.rebalance.name,
				},
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/pencil.png"),
				"description": "Pencils Ready: [i]I could feel the teacher's eyes hovering over me.[/i]"
			}
		],
		"Memory Failing": [
			{
				"name": "move_card_to_container",
				"subject": "index",
				"subject_index": "random",
				"src_container": "hand",
				"dest_container": "forgotten",
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/uncertainty.png"),
				"description": "Memory Failing: [i]I know I had studied this. What was it...[/i]"
			},
		],
	}
	return(scripts.get(intent_name,{}))

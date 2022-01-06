extends BossIntents

const INTENTS := [
	{
		"id": "wild_attacks",
		"intent_scripts": ["Wild Attacks"],
		"reshuffle": true,
		"max_in_a_row": 2,
	},
	{
		"id": "learn",
		"intent_scripts": ["Learn"],
		"reshuffle": false,
		"sets_up_intent": "mimic",
	},
	{
		"id": "mimic",
		"intent_scripts": ["Mimic"],
		"reshuffle": false,
		"not_in_rotation": true,
	},
]


func _ready() -> void:
	all_intents = INTENTS.duplicate(true)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Array:
	var intent_scripts := []
	match intent_name:
		"Wild Attacks":
			var amount : int = 4
			if combat_entity.get_property("_difficulty") == "medium":
				amount = 5
			elif combat_entity.get_property("_difficulty") == "hard":
				amount = 6
			var unmodified_amount = amount
			var script : Dictionary
			if combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.impervious.name, 0) > 0\
					or combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.armor.name, 0) > 0:
				var burn = amount - 1
				if combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.impervious.name, 0) +\
					combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.armor.name, 0) > 1:
					burn += 2
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
					"tags": ["Intent", "Delayed"],
					"subject": "dreamer",
					"modification": burn,
					"set_to_mod": true,
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "This Torment is planning to apply a debuff to the Dreamer."
				}
				intent_scripts.append(script)
				amount -= 1
			if combat_entity.cm_flags.get("high_defences", 0) > 0:
				var poison = amount - 2
				if combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.impervious.name, 0) > 1:
					poison += 2
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"tags": ["Intent", "Delayed"],
					"subject": "dreamer",
					"modification": poison,
					"set_to_mod": true,
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "This Torment is planning to apply a debuff to the Dreamer."
				}
				amount -= 1
				intent_scripts.append(script)
				script = {
					"name": "modify_damage",
					"tags": ["Attack", "Intent", "Unblockable"],
					"subject": "dreamer",
					"amount": amount,
					"icon": all_intent_scripts.ICON_PIERCE,
					"description": "Piercing Stress: Will cause the dreamer to take the specified amount of unblockable {anxiety}."
				}
				intent_scripts.append(script)
				amount -= 1
			if combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.thorns.name, 0) > 0:
				script = {
					"name": "modify_damage",
					"tags": ["Attack", "Intent"],
					"subject": "dreamer",
					"amount": amount * unmodified_amount,
					"icon": all_intent_scripts.ICON_ATTACK,
					"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}."
				}
				intent_scripts.append(script)
			else:
				for _iter in range(amount):
					script = {
						"name": "modify_damage",
						"tags": ["Attack", "Intent"],
						"subject": "dreamer",
						"amount": unmodified_amount,
						"icon": all_intent_scripts.ICON_ATTACK,
						"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}."
					}
					intent_scripts.append(script)
			if combat_entity.cm_flags.get("high_attacks", 0) > 1:
				var impervious = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
					"tags": ["Intent", "Delayed"],
					"subject": "self",
					"modification": 2,
					"icon": all_intent_scripts.ICON_BUFF,
					"description": "This Torment is planning to buff itself."
				}
				intent_scripts.append(impervious)
			if combat_entity.cm_flags.get("average_attacks", 0) > 0:
				var thorns = 4
				if combat_entity.cm_flags.get("average_attacks", 0) > 1:
					thorns += 2
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
					"tags": ["Intent", "Delayed"],
					"subject": "self",
					"modification": thorns,
					"set_to_mod": true,
					"icon": all_intent_scripts.ICON_BUFF,
					"description": "This Torment is planning to buff itself."
				}
				intent_scripts.append(script)
			if combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.empower.name, 0) > 0:
				var disempower = 2
				if combat_entity.cm_flags.get("average_attacks", 0) > 1:
					disempower += 4
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"tags": ["Intent", "Delayed"],
					"subject": "dreamer",
					"modification": disempower,
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "This Torment is planning to apply a debuff to the Dreamer."
				}
				intent_scripts.append(script)
			if combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.buffer.name, 0) > 0:
				var drain = 1
				if combat_entity.cm_flags.get("average_attacks", 0) > 1:
					drain += 1
				script = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
					"tags": ["Intent", "Delayed"],
					"subject": "dreamer",
					"modification": drain,
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "This Torment is planning to apply a debuff to the Dreamer."
				}
				intent_scripts.append(script)
		"Learn":
#			print_debug("learning")
			var amount : int = 10
			if combat_entity.get_property("_difficulty") == "medium":
				amount = 15
			elif combat_entity.get_property("_difficulty") == "hard":
				amount = 20
			var script = {
				"name": "null_script",
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/read.png"),
				"description": "It is learning",
			}
			intent_scripts.append(script)
			script = {
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": amount,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description": "Perplex: Will give this Torment the specified amount of {perplexity}."
			}
			intent_scripts.append(script)
			if combat_entity.cm_flags.get("high_attacks", 0) > 0:
				var impervious = {
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
					"tags": ["Intent", "Delayed"],
					"subject": "self",
					"modification": 2,
					"icon": all_intent_scripts.ICON_BUFF,
					"description": "This Torment is planning to buff itself."
				}
				intent_scripts.append(impervious)
		"Mimic":
			if combat_entity.cm_flags.get(Terms.ACTIVE_EFFECTS.thorns.name, 0) > 1:
				var one_big_attack = 0
				for attack in combat_entity.dreamer_attacks:
					one_big_attack += attack
				var mimic_attack = {
					"name": "modify_damage",
					"tags": ["Attack", "Intent"],
					"subject": "dreamer",
					"amount": one_big_attack,
					"icon": all_intent_scripts.ICON_ATTACK,
					"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}."
				}
				intent_scripts.append(mimic_attack)
			elif combat_entity.cm_flags.get("high_defences", 0) > 1:
				for attack in combat_entity.dreamer_attacks:
					var mimic_attack = {
						"name": "modify_damage",
						"tags": ["Attack", "Intent", "Unblockable"],
						"subject": "dreamer",
						"amount": attack,
						"icon": all_intent_scripts.ICON_PIERCE,
						"description": "Piercing Stress: Will cause the dreamer to take the specified amount of unblockable {anxiety}."
					}
					intent_scripts.append(mimic_attack)
			else:
				for attack in combat_entity.dreamer_attacks:
					var mimic_attack = {
						"name": "modify_damage",
						"tags": ["Attack", "Intent"],
						"subject": "dreamer",
						"amount": attack,
						"icon": all_intent_scripts.ICON_ATTACK,
						"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}."
					}
					intent_scripts.append(mimic_attack)
			if combat_entity.dreamer_defences > 0:
				var mimic_defence = {
					"name": "assign_defence",
					"tags": ["Intent"],
					"subject": "self",
					"amount": combat_entity.dreamer_defences,
					"icon": all_intent_scripts.ICON_DEFEND,
					"description": "Perplex: Will give this Torment the specified amount of {perplexity}."
				}
				intent_scripts.append(mimic_defence)
			if combat_entity.dreamer_damage > 0:
				var mimic_exert = {
					"name": "modify_damage",
					"tags": ["Exert", "Intent"],
					"subject": "self",
					"amount": combat_entity.dreamer_damage,
					"icon": preload("res://assets/icons/spectacle-lenses.png"),
					"description": "Evident: This will cause this Torment the specified amount of {damage}."
				}
				intent_scripts.append(mimic_exert)
			for buff in combat_entity.dreamer_effects:
				var mimic_buffs = {
					"name": "apply_effect",
					"effect_name": buff,
					"tags": ["Intent", "Delayed"],
					"subject": "self",
					"modification": combat_entity.dreamer_effects[buff],
					"icon": all_intent_scripts.ICON_BUFF,
					"description": "This Torment is planning to buff itself."
				}
				intent_scripts.append(mimic_buffs)
			for debuff in combat_entity.self_effects:
				var mimic_debuffs = {
					"name": "apply_effect",
					"effect_name": debuff,
					"tags": ["Intent", "Delayed"],
					"subject": "dreamer",
					"modification": combat_entity.self_effects[debuff],
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "This Torment is planning to apply a debuff to the Dreamer."
				}
				intent_scripts.append(mimic_debuffs)
			if combat_entity.dreamer_heals < 0:
				var mimic_heal = {
					"name": "modify_damage",
					"tags": ["Heal", "Intent"],
					"subject": "self",
					"amount": combat_entity.dreamer_heals,
					"icon": all_intent_scripts.ICON_SPECIAL,
					"description": "Is it resting?"
				}
				intent_scripts.append(mimic_heal)
			if intent_scripts.size() == 0:
				var script = {
					"name": "modify_damage",
					"tags": ["Attack", "Intent"],
					"subject": "dreamer",
					"amount": 30,
					"icon": all_intent_scripts.ICON_ATTACK,
					"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}."
				}
				intent_scripts.append(script)
	return(intent_scripts)

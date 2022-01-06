extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["SpamDebuffs"],
		"reshuffle": true,
	},
	{
		"intent_scripts": ["SpamDebuffs"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["SpamBuffs"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["SpamBuffs"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Dispell"],
		"reshuffle": false,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)



#func prepare_intents(_starting_index = null, is_second_try := false) -> Dictionary:
#	if not unused_intents.size():
#		reshuffle_intents()
#	var new_intents : Dictionary = unused_intents.pop_front().duplicate(true)
#	if new_intents.reshuffle:
#		reshuffle_intents()
#	_display_intents(new_intents)
#	return(new_intents)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Array:
	var difficulty: int
	match combat_entity.get_property("_difficulty"):
		"easy":
			difficulty = 3
		"medium":
			difficulty = 4
		"hard":
			difficulty = 5
	var different_effects := CFUtils.randi_range(1,difficulty)
	# warning-ignore:integer_division
	var min_stacks := int(difficulty/different_effects)
	var leftover_stracks := int(difficulty % different_effects)
#	print_debug('amount: %s -  min: %s - left: %s' % [different_effects, min_stacks, leftover_stracks])
	var intent_scripts := []
	match intent_name:
		"SpamBuffs":
			var all_buffs := Terms.get_all_effect_types("Buff")
			CFUtils.shuffle_array(all_buffs)
			all_buffs.erase("Advantage")
			all_buffs.erase("Fascination")
#			print_debug(all_buffs)
			for iter in range(different_effects):
				var script_template := {
					"name": "apply_effect",
					"effect_name": all_buffs.pop_back(),
					"tags": ["Intent", "Delayed"],
					"subject": "self",
					"modification": min_stacks,
					"icon": all_intent_scripts.ICON_BUFF,
					"description": "What is going on?"
				}
				if iter == 0:
					script_template["modification"] += leftover_stracks
				intent_scripts.append(script_template)
			var second_script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 10,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}."
			}
			intent_scripts.append(second_script)
		"SpamDebuffs":
			var all_debuffs := Terms.get_all_effect_types("Debuff")
			CFUtils.shuffle_array(all_debuffs)
			all_debuffs.erase("Delighted")
#			print_debug(all_debuffs)
			for iter in range(different_effects):
				var script_template := {
					"name": "apply_effect",
					"effect_name": all_debuffs.pop_back(),
					"tags": ["Intent", "Delayed"],
					"subject": "dreamer",
					"modification": min_stacks,
					"icon": all_intent_scripts.ICON_DEBUFF,
					"description": "How did it do that?"
				}
				if iter == 0:
					script_template["modification"] += leftover_stracks
				intent_scripts.append(script_template)
			var second_script = {
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 10,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description": "Perplex: Will give this Torment the specified amount of {perplexity}."
			}
			intent_scripts.append(second_script)
		"Dispell":
			var all_concentrations = Terms.get_all_effect_types("Concentration")
			all_concentrations += Terms.get_all_effect_types("Versatile")
			CFUtils.shuffle_array(all_concentrations)
			var found_concentration := ''
			var damage = difficulty * 5
			for concentration in all_concentrations:
				# We do not want to remove the player's negative focus/quicken, if they have any
				if concentration in Terms.get_all_effect_types("Versatile")\
						and cfc.NMAP.board.dreamer.active_effects.get_effect_stacks(concentration) < 0:
					continue
				if cfc.NMAP.board.dreamer.active_effects.get_effect_stacks(concentration) > 0:
					found_concentration = concentration
					damage = difficulty * 2.5
					var dispell_template := {
						"name": "apply_effect",
						"effect_name": found_concentration,
						"tags": ["Intent"],
						"subject": "dreamer",
						"modification": -1,
						"icon": all_intent_scripts.ICON_SPECIAL,
						"description": "What is it doing?"
					}
					intent_scripts.append(dispell_template)
					break
			var second_script = {
					"name": "modify_damage",
					"tags": ["Attack", "Intent"],
					"subject": "dreamer",
					"amount": damage,
					"icon": all_intent_scripts.ICON_ATTACK,
					"description": "Oh no..."
				}
			intent_scripts.append(second_script)
	return(intent_scripts)

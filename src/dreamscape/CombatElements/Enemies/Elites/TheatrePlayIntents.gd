extends BossIntents

var init_intents := true

const INTENTS := [
	{
		"intent_scripts": ["Stage Fright"],
		"reshuffle": true,
		"max_in_a_row": 1,
	},
	{
		"intent_scripts": ["Repeat Acts"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Extend Play"],
		"reshuffle": false,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)

func prepare_intents(specific_index = null, _is_second_try := false) -> Dictionary:
	var difficulty: int
	match combat_entity.get_property("_difficulty"):
		"easy":
			difficulty = 0
		"medium":
			difficulty = 1
		"hard":
			difficulty = 1
	var new_intents : Dictionary
	var selected_intent: Dictionary
	var has_long_term_minions := false
	# We don't want to try and buff the minions after they die
	for minion in get_tree().get_nodes_in_group("MinionEnemyEntities"):
		if minion.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.act_length.name) > 1:
			has_long_term_minions = true
	if specific_index != null:
		selected_intent = all_intents[specific_index]
	elif init_intents:
		selected_intent = all_intents[0]
		init_intents = false
	elif get_tree().get_nodes_in_group("MinionEnemyEntities").size() <= difficulty\
			and last_used_intent != all_intents[2].hash():
		selected_intent = all_intents[2]
	elif last_used_intent == all_intents[0].hash() and has_long_term_minions:
		selected_intent = all_intents[1]
	else:
		selected_intent = all_intents[0]
	last_used_intent = selected_intent.hash()
	new_intents = selected_intent.duplicate(true)
	_display_intents(new_intents)
	return(new_intents)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Array:
	var intent_scripts := []
	var script : Dictionary
	var difficulty
	var pert_destination := 'discard'
	match intent_name:
		"Stage Fright":
			match combat_entity.get_property("_difficulty"):
				"easy":
					difficulty = 1
				"medium":
					difficulty = 2
				"hard":
					difficulty = 2
					pert_destination = 'deck'
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 10,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]I am the main protagonist of this act.[/i]"
			}
			intent_scripts.append(script)
			script = {
					"name": "spawn_card_to_container",
					"tags": ["Intent"],
					"card_name": "Lacuna",
					"object_count": difficulty,
					"dest_container": pert_destination,
					"icon": all_intent_scripts.ICON_SPECIAL,
					"description": "Stage Fright: [i]I can't do this![/i]"
				}
			intent_scripts.append(script)
		"Extend Play":
			script = {
				"name": "spawn_enemy",
				"enemy": EnemyDefinitions.THEATRE_ACT,
				"object_count": 2,
				"starting_effects": [
					{
						"name": Terms.ACTIVE_EFFECTS.act_length.name,
						"stacks": 4,
					},
				],
				"set_spawn_as_minion": true,
				"tags": ["Intent"],
				"icon": preload("res://assets/icons/uncertainty.png"),
				"description": "Extend Play: Will spawn extra minion torments.\n"\
						+ "[i]And just like that, they decided to extend the show at the last minute.[/i]"
			}
			intent_scripts.append(script)
		"Repeat Acts":
			match combat_entity.get_property("_difficulty"):
				"easy":
					difficulty = 2
				"medium":
					difficulty = 4
				"hard":
					difficulty = 5
			script = {
				"name": "modify_damage",
				"tags": ["Heal", "Intent"],
				"subject": "boardseek",
				"subject_count": "all",
				"filter_state_seek": [{
					"filter_group": "MinionEnemyEntities",
				}],
				"amount":  -1,
				"icon": all_intent_scripts.ICON_SPECIAL,
				"description": "Muddle: All Minions will recover {damage}."
			}
			intent_scripts.append(script)
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"subject": "boardseek",
				"subject_count": "all",
				"filter_state_seek": [{
					"filter_group": "MinionEnemyEntities",
				}],
				"modification": difficulty,
				"tags": ["Intent"],
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "Repeat Acts: [i]I still don't have this down.[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": difficulty,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description": "Perplex: Will give this Torment the specified amount of {perplexity}."
			}
			intent_scripts.append(script)

	return(intent_scripts)

#extends CoreScripts
extends "res://src/dreamscape/cards/sets/SetScripts_Core.gd"

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Gaslighter": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "target",
						"is_cost": true,
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "dreamer",
						"modification": 0,
						"set_to_mod": true,
					}
				],
			},
		},
		"Gaslighter Exposed": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "target",
						"is_cost": true,
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "previous",
						"modification": "per_effect_stacks",
						"per_effect_stacks": {
							"subject": "dreamer",
							"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						},
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "dreamer",
						"modification": 0,
						"set_to_mod": true,
					}
				],
			},
		},
		"Broken Mirror": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
						"subject": "target",
						"is_cost": true,
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
						"subject": "dreamer",
						"modification": 0,
						"set_to_mod": true,
					}
				],
			},
		},
		"Broken Mirror Exposed": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
						"subject": "target",
						"is_cost": true,
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
						"subject": "previous",
						"modification": "per_effect_stacks",
						"per_effect_stacks": {
							"subject": "dreamer",
							"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
						},
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
						"subject": "dreamer",
						"modification": 0,
						"set_to_mod": true,
					}
				],
			},
		},
		"Fearmonger": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
					},
					{
						"name": "nested_script",
						"nested_tasks": [
							{
								"name": "move_card_to_container",
								"subject": "tutor",
								"is_cost": true,
								"src_container":  cfc.NMAP.deck,
								"dest_container":  cfc.NMAP.forgotten,
								"filter_state_tutor": [
									{
										"filter_properties": {
											"Type": "Perturbation"
										}
									}
								],
							},
							{
								"name": "move_card_to_container",
								"subject": "tutor",
								"is_else": true,
								"src_container":  cfc.NMAP.discard,
								"dest_container":  cfc.NMAP.forgotten,
								"filter_state_tutor": [
									{
										"filter_properties": {
											"Type": "Perturbation"
										}
									}
								],
							},
						]
					},
				],
			},
		},
		"Fearmonger Exposed": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
					},
					# I need to put this discard here, to prevent the player
					# reusing the card again while waiting for the deck
					# to reshuffle
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "nested_script",
						"nested_tasks": [
							{
								"name": "move_card_to_container",
								"is_cost": true,
								"subject": "tutor",
								"subject_count": 1,
								"sort_by": "random",
								"src_container":  cfc.NMAP.hand,
								"dest_container":  cfc.NMAP.deck,
								"filter_state_tutor": [
									{
										"filter_properties": {
											"Type": "Perturbation"
										}
									}
								],
							},
							{
								"name": "shuffle_container",
								"dest_container": cfc.NMAP.deck,
							},
						]
					},
					{
						"name": "nested_script",
						"nested_tasks": [
							{
								"name": "move_card_to_container",
								"subject": "tutor",
								"is_cost": true,
								"src_container":  cfc.NMAP.deck,
								"dest_container":  cfc.NMAP.forgotten,
								"filter_state_tutor": [
									{
										"filter_properties": {
											"Type": "Perturbation"
										}
									}
								],
							},
							{
								"name": "move_card_to_container",
								"subject": "tutor",
								"is_else": true,
								"src_container":  cfc.NMAP.discard,
								"dest_container":  cfc.NMAP.forgotten,
								"filter_state_tutor": [
									{
										"filter_properties": {
											"Type": "Perturbation"
										}
									}
								],
							},
						]
					},
				],
			},
		},
		"The Laughing One": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"ROFLMAO": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"is_cost": true,
						"tags": ["Healing"],
						"amount": "per_defence",
						"per_defence": {
							"subject": "dreamer",
							"is_inverted": true,
						},
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 0,
						"set_to_mod": true,
					},
				],
			},
		},
		"The Critic": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "target",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"The Critic Unleashed": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Clown": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Unnamed Enemy 1": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Sustained Unnamed Enemy": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
				],
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(_prepare_scripts(scripts, card_name))

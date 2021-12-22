#extends CoreScripts
extends "res://src/dreamscape/cards/sets/SetScripts_Core.gd"


const scripts := {
	"Gaslighter": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"subject": "target",
					"is_cost": true,
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
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
					"amount":  {
						"lookup_property": "_amounts",
						"value_key": "defence_amount",
					},
				},
				{
					"name": "nested_script",
					"nested_tasks": [
						{
							"name": "move_card_to_container",
							"subject": "tutor",
							"is_cost": true,
							"src_container":  "deck",
							"dest_container":  "forgotten",
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
							"src_container":  "discard",
							"dest_container":  "forgotten",
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
					"amount":  {
						"lookup_property": "_amounts",
						"value_key": "defence_amount",
					},
				},
				# I need to put this discard here, to prevent the player
				# reusing the card again while waiting for the deck
				# to reshuffle
				{
					"name": "move_card_to_container",
					"dest_container": "discard",
					"subject": "self",
					"tags": ["Played"],
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
							"src_container":  "hand",
							"dest_container":  "deck",
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
							"dest_container": "deck",
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
							"src_container":  "deck",
							"dest_container":  "forgotten",
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
							"src_container":  "discard",
							"dest_container":  "forgotten",
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
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
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
			],
		},
	},
	"Butterfly": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
				},
			],
		},
	},
	"Sustained Butterfly": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
			],
		},
	},
	"Pialephant": {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "damage_amount"
					},
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
				},
			],
		},
	},
	"The Light Calling": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "defence_amount"
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
				},
			],
		},
	},
	"A Squirrel": {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "damage_amount"
					},
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "exert_amount"
					},
					"tags": ["Exert"],
				},
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "defence_amount"
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
				},
			],
		},
	},
	"Baby": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.delighted.name,
					"subject": "dreamer",
					"tags": ["Delayed"],
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks2",
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
				},
			],
		},
	},
	"Traffic Jam": {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "damage_amount"
					},
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "modify_pathos",
					"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
					"pathos_type": "released",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "released_amount",
					},
				},
				{
					"name": "modify_pathos",
					"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
					"pathos_type": "repressed",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "repressed_amount",
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played"],
				},
			],
		},
	},
	"Stuffed Toy": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.stuffed_toy.name,
					"subject": "dreamer",
					"modification": 1,
				},
			],
		},
	},
	"Mouse": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.mouse.name,
					"subject": "dreamer",
					"modification": 1,
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
					"subject": "dreamer",
					"modification": {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks2",
						"default": 1,
						"is_inverted": true,
					},
				},
			],
		},
	},
	"The Exam": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.the_exam.name,
					"subject": "dreamer",
					"modification": 1,
				},
				{
					"name": "move_card_to_container",
					"src_container": "forgotten",
					"dest_container": "deck",
					"subject_count": {
						"lookup_property": "_amounts",
						"value_key": "card_amount"
					},
					"subject": "index",
					"subject_index": "random",
				},
				{
					"name": "shuffle_container",
					"dest_container": "deck",
				},
			],
		},
	},
	"The Victim": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.the_victim.name,
					"subject": "target",
					"is_cost": true,
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	},

}

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:

	# We return only the scripts that match the card name and trigger
	return(_prepare_scripts(scripts, card_name))

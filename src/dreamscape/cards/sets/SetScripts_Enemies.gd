#extends CoreScripts
extends "res://src/dreamscape/cards/sets/SetScripts_Core.gd"

const BeastMode = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.quicken.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks2"
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks3"
				},
			},
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
}
const HandsyAunt = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": 'per_encounter_event_count',
				"per_encounter_event_count": {
					"event_name": "new_turn",
					"multiplier": {
						"lookup_property": "_amounts",
						"value_key": "beneficial_float"
					}
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const Circular_Arguments = {
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
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "remove_card_from_deck",
				"subject": "self",
				"tags": ["Played", "Card"],
			}
		],
	},
}
const Recurrence = {
	"manual": {
		"hand": [
			{
				"name": "custom_script",
				"tags": ["Card"],
			},
		],
	},
}

const scripts := {
	"Gaslighter": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"subject": "target",
					"needs_subject": true,
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
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"subject": "target",
					"needs_subject": true,
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
					"tags": ["Card"],
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
					"tags": ["Card"],
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
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
					"subject": "target",
					"needs_subject": true,
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
					"tags": ["Card"],
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
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
					"subject": "target",
					"needs_subject": true,
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
					"tags": ["Card"],
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
					"tags": ["Card"],
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
					"tags": ["Card"],
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
							"tags": ["Card"],
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
							"tags": ["Card"],
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
					"tags": ["Card"],
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
					"tags": ["Played", "Card"],
				},
				{
					"name": "nested_script",
					"nested_tasks": [
						{
							"name": "move_card_to_container",
							"tags": ["Card"],
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
							"tags": ["Card"],
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
							"tags": ["Card"],
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
					"tags": ["Card"],
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
					"tags": ["Played", "Card"],
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
					"tags": ["Played", "Card"],
				},
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"is_cost": true,
					"tags": ["Healing", "Card"],
					"amount": "per_defence",
					"per_defence": {
						"subject": "dreamer",
						"is_inverted": true,
					},
				},
				{
					"name": "assign_defence",
					"tags": ["Card"],
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
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
					"subject": "target",
					"needs_subject": true,
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
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"The Critic Unleashed": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
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
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Clown": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
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
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Murmurs": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
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
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Sustained Murmurs": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
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
					"tags": ["Card"],
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
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Sustained Butterfly": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
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
					"tags": ["Attack", "Card"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"The Light Calling": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "detriment_stacks",
					},
				},
				{
					"name": "assign_defence",
					"tags": ["Card"],
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
					"tags": ["Played", "Card"],
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
					"tags": ["Attack", "Card"],
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
					"tags": ["Exert", "Card"],
				},
				{
					"name": "assign_defence",
					"tags": ["Card"],
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
					"tags": ["Played", "Card"],
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
					"tags": ["Delayed", "Card"],
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "detriment_stacks",
					},
				},
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
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
					"tags": ["Played", "Card"],
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
					"tags": ["Attack", "Card"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "modify_pathos",
					"tags": ["Card"],
					"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
					"pathos_type": "released",
					"amount":  {
						"lookup_property": "_amounts",
						"value_key": "released_amount",
					},
				},
				{
					"name": "modify_pathos",
					"tags": ["Card"],
					"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
					"pathos_type": "repressed",
					"amount":  {
						"lookup_property": "_amounts",
						"value_key": "repressed_amount",
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Stuffed Toy": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
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
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.mouse.name,
					"subject": "dreamer",
					"modification": 1,
				},
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
					"subject": "dreamer",
					"modification": {
						"lookup_property": "_amounts",
						"value_key": "detriment_stacks",
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
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.the_exam.name,
					"subject": "dreamer",
					"modification": 1,
				},
				{
					"name": "move_card_to_container",
					"tags": ["Card"],
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
					"tags": ["Card"],
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
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.the_victim.name,
					"subject": "target",
					"needs_subject": true,
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
	"Hyena": {
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
					"tags": ["Attack", "Card"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "custom_script",
					"tags": ["Card"],
					"subject": "previous",
				},
			],
		},
	},
	"Subconscious": {
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
					"tags": ["Attack", "Card"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "custom_script",
					"tags": ["Card"],
					"subject": "previous",
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Impossible Construction": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
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
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Improved Impossible Construction": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
				{
					"name": "assign_defence",
					"tags": ["Card"],
					"subject": "dreamer",
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "defence_amount"
					},
				},
			],
		},
	},
	"Sustained Impossible Construction": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
				},
			],
		},
	},
	"Guilt": {
		"manual": {
			"hand": [
				{
					"name": "move_card_to_container",
					"dest_container": "discard",
					"subject": "self",
					"tags": ["Played", "Card"],
				},
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "damage_amount"
					},
					"tags": ["Attack", "Card"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "draw_cards",
					"tags": ["Card"],
					"card_count": {
						"lookup_property": "_amounts",
						"value_key": "draw_amount"
					},
				},
			],
		},
	},
	"Silent Treatment": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.protection.name,
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
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Void": {
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
					"store_integer": true,
					"tags": ["Attack", "Card"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "modify_damage",
					"tags": ["Healing", "Card"],
					"subject": "dreamer",
					"amount": "retrieve_integer",
					"is_inverted": true,
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Chasm": {
		"manual": {
			"hand": [
				{
					"name": "modify_properties",
					"tags": ["Card"],
					"set_properties": {"Cost": "-1"},
					"subject": "tutor",
					"sort_by": "random",
					"src_container": "hand",
					"filter_state_tutor": [
						{
							"filter_properties": {
								"comparison": "ne",
								"Cost": 'X'
							},
							"filter_properties3": {
								"comparison": "ne",
								"Cost": 'U'
							},
							"filter_properties2": {
								"comparison": "ne",
								"Cost": 0
							},
						},
					]
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Yawning Chasm": {
		"manual": {
			"hand": [
				{
					"name": "modify_properties",
					"tags": ["Card"],
					"set_properties": {"Cost": "-1"},
					"subject": "tutor",
					"sort_by": "random",
					"src_container": "hand",
					"filter_state_tutor": [
						{
							"filter_properties": {
								"comparison": "ne",
								"Cost": 'X'
							},
							"filter_properties3": {
								"comparison": "ne",
								"Cost": 'U'
							},
							"filter_properties2": {
								"comparison": "ne",
								"Cost": 0
							},
						},
					]
				},
			],
		},
	},
	"Steep Chasm": {
		"manual": {
			"hand": [
				{
					"name": "modify_properties",
					"tags": ["Card"],
					"set_properties": {"Cost": 0},
					"subject": "tutor",
					"sort_by": "random",
					"src_container": "hand",
					"filter_state_tutor": [
						{
							"filter_properties": {
								"comparison": "ne",
								"Cost": 'X'
							},
							"filter_properties3": {
								"comparison": "ne",
								"Cost": 'U'
							},
							"filter_properties2": {
								"comparison": "ne",
								"Cost": 0
							},
						},
					]
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Life Path": {
		"manual": {
			"hand": {
				"Action Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Action',
							},
							{
								'property': '_is_upgrade',
								'value': false,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": "forgotten",
						"tags": ["Played", "Card"],
					},
				],
				"Control Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Control',
							},
							{
								'property': '_is_upgrade',
								'value': false,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": "forgotten",
						"tags": ["Played", "Card"],
					},
				],
				"Concentration Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Concentration',
							},
							{
								'property': '_is_upgrade',
								'value': false,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": "forgotten",
						"tags": ["Played", "Card"],
					},
				],
			}
		}
	},
	"Sustained Life Path": {
		"manual": {
			"hand": {
				"Action Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Action',
							},
							{
								'property': '_is_upgrade',
								'value': false,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
				],
				"Control Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Control',
							},
							{
								'property': '_is_upgrade',
								'value': false,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
				],
				"Concentration Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Concentration',
							},
							{
								'property': '_is_upgrade',
								'value': false,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
				],
			}
		}
	},
	"Illuminated Life Path": {
		"manual": {
			"hand": {
				"Action Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Action',
							},
							{
								'property': '_is_upgrade',
								'value': true,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": "forgotten",
						"tags": ["Played", "Card"],
					},
				],
				"Control Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Control',
							},
							{
								'property': '_is_upgrade',
								'value': true,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": "forgotten",
						"tags": ["Played", "Card"],
					},
				],
				"Concentration Card": [
					{
						"name": "spawn_card_to_container",
						"card_filters": [
							{
								'property': 'Type',
								'value': 'Concentration',
							},
							{
								'property': '_is_upgrade',
								'value': true,
							}
						],
						"dest_container": "hand",
						"selection_amount": 1,
						"object_count": {
							"lookup_property": "_amounts",
							"value_key": "spawn_amount"
						},
						"tags": ["Card"],
					},
					{
						"name": "modify_properties",
						"tags": ["Card"],
						"set_properties": {"Cost": "0"},
						"subject": "previous",
						"filter_state_subject": [
							{
								"filter_properties": {
									"comparison": "ne",
									"Cost": 'X'
								},
							},
						]
					},
					{
						"name": "enable_rider",
						"tags": ["Card"],
						"rider": "reset_cost_after_play",
						"subject": "previous",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": "forgotten",
						"tags": ["Played", "Card"],
					},
				],
			}
		}
	},
	"Administration": {
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
					"tags": ["Attack", "Card"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
				{
					"name": "spawn_enemy",
					"enemy": EnemyDefinitions.OVERCHARGED_SERVUS,
					"set_spawn_as_minion": true,
					"object_count": {
						"lookup_property": "_amounts",
						"value_key": "spawn_amount"
					},
					"tags": ["Card"],
				},
			],
		},
	},
	"Cringelord": {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"tags": ["Card"],
					"subject": "dreamer",
					"amount":  {
						"lookup_property": "_amounts",
						"value_key": "defence_amount",
					},
				},
				{
					"name": "perturb",
					"card_name": "Cringeworthy Memory",
					"dest_container": "deck",
					"object_count": {
						"lookup_property": "_amounts",
						"value_key": "perturb_amount",
					},
					"tags": ["Card", "Perturb"],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Nightmare": {
		"manual": {
			"hand": [
				{
					"name": "null_script",
					"tags": ["Card"],
					"subject": "target",
					"needs_subject": true,
					"filter_state_subject": [
						{"filter_group": "BasicEnemyEntities"},
						{"filter_group": "MinionEnemyEntities"},
					],
				},
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.doom.name,
					"subject": "previous",
					"protect_previous": true,
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					},
					"filter_state_subject": [{
						"filter_group": "BasicEnemyEntities",
					}],
				},
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.doom.name,
					"subject": "previous",
					"protect_previous": true,
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks2",
					},
					"filter_state_subject": [{
						"filter_group": "MinionEnemyEntities",
					}],
				},
			],
		},
	},
	"Submerged": {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
					"subject": "target",
					"needs_target": true,
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "detriment_stacks",
						"is_inverted": true,
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Cockroaches": {
		"manual": {
			"hand": [
				{
					"name": "custom_script",
					"tags": ["Card"],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
	"Beast Mode": BeastMode,
	"Handsy Aunt": HandsyAunt,
	"Circular Arguments": Circular_Arguments,
	"Recurrence": Recurrence,
}

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String, _get_modified := true) -> Dictionary:

	# We return only the scripts that match the card name and trigger
	return(_prepare_scripts(scripts, card_name, _get_modified))

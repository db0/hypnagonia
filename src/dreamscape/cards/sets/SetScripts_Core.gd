# See README.md
extends Reference

# If the upgraded card name is prepending one of these words
# Then we know it's going to be using the same script definition as the original
# card.
# This allows us to avoid writing new definitions when all that is changing
# is the card statistics (like cost)
const SAME_SCRIPT_MODIFIERS := [
	"Easy", # Used when the upgraded card has just lower cost
	"Solid", # Used when the upgraded card has just higher amount or damage or defence.
	"Enhanced", # Used when the upgraded card has just higher amount of effect stacks.
	"Ephemeral", # Used when the upgraded card is just adding an extra task to remove the card from deck.
]

const EPHEMERAL_TASK := {
	"name": "remove_card_from_deck",
	"subject": "self",
}


# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var script_name := card_name
	# This match allows us to reuse the same scripts, for upgraded cards which
	# do not change the script code.
	var scripts := {
		"Interpretation": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			},
		},
		"Confidence": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
					}
				],
			},
		},
		"Noisy Whip": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 5,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
						"subject": "previous",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					}
				],
			},
		},
		"Dive-in": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "dreamer",
						"modification": 2,
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
						"subject": "dreamer",
						"modification": 1,
					}
				],
			},
		},
		"Safety of Air": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": -4,
						"tags": ["Healing"],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Nothing to Fear": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Tough Nothing to Fear": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
						"subject": "dreamer",
						"modification": 1,
						"upgrade_name": "tough",
					},
				],
			},
		},
		"Out of Reach": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					},
				],
			},
		},
		"Confounding Movements": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 9,
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
						"subject": "target",
						"is_cost": true,
						"modification": 1,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Inner Justice": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "immersion",
						"modification": 4,
					},
				],
			},
		},
		"Whirlwind": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 3,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": 3,
						"tags": ["Attack"],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": 3,
						"tags": ["Attack"],
					},
				],
			},
		},
		"Overview": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "target",
						"amount": 0,
						"set_to_mod": true,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			},
		},
		"Rubber Eggs": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"The Joke": {
			"manual": {
				"hand": [
					{
						"name": "custom_script",
						"subject": "target",
						"is_cost": true,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Nunclucks": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.nunclucks.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Gummiraptor": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 10,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"is_cost": true,
						"amount": 10,
						"tags": ["Attack"],
						"subject": "previous",
						"filter_gummiraptor": true,
					}
				],
			},
		},
		"Cocky Retort": {
			"manual": {
				"hand": [
					# We have a function to discard manually to ensure
					# it's not counted for checking if the hand is full
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 8,
					},
					{
						"name": "draw_cards",
						"card_count": 1,
					},
				],
			},
		},
		"Rapid Encirclement": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": 2,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Barrel Through": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 8,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "custom_script",
						"subject": "previous",
					},
				],
			},
		},
		"Intimidate": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": 2,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Cheeky Approach": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 10,
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "target",
						"is_cost": true,
						"modification": 3,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Laugh at Danger": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.laugh_at_danger.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Towering Presence": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"tags": ["Attack"],
						"amount": "per_defence",
						"per_defence": {
							"subject": "dreamer",
						},
					},
				],
			},
		},
		"Unassailable": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.unassailable.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Audacity": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 8,
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Boast": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": "per_defence",
						"per_defence": {
							"subject": "dreamer",
						},
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
						"subject": "dreamer",
						"modification": 0,
						"set_to_mod": true
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Solid Understanding": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 5,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 5,
					},
				],
			},
		},
		"No Second Thoughts": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
						"subject": "dreamer",
						"modification": 2,
					},
				],
			},
		},
		"High Morale": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 6,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Tags": Terms.ACTIVE_EFFECTS.fortify.name
								}
							}
						],
					},
				],
			},
		},
		"Confident Slap": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "target",
						"is_cost": true,
						"modification": 5,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Swoop": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 8,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
						"filter_dreamer_effect": Terms.ACTIVE_EFFECTS.impervious.name,
						"filter_stacks": 0,
						"comparison": "eq",
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 12,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
						"filter_dreamer_effect": Terms.ACTIVE_EFFECTS.impervious.name,
						"filter_stacks": 1,
						"comparison": "ge",
					},
				],
			},
		},
		"Drag and Drop": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 10,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "custom_script",
						"subject": "previous",
					},
				],
			},
		},
		"Running Start": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 6,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Tags": Terms.ACTIVE_EFFECTS.impervious.name
								}
							}
						],
					},
				],
			},
		},
		"Master of Skies": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.master_of_skies.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Zen of Flight": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.zen_of_flight.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Loop de loop": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 7,
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
						"subject": "dreamer",
					}
				],
			},
		},
		"Headless": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
						"subject": "dreamer",
						"modification": 4
					}
				],
			},
		},
		"Utterly Ridiculous": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "boardseek",
						"subject_count": "all",
						"tags": ["Attack"],
						"amount": 20,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
				"filter_per_effect_stacks": {
					"subject": "boardseek",
					"subject_count": "all",
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"filter_stacks": 6,
					"comparison": "ge",
				}
			},
		},
		"Ventriloquism": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 8,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.hand,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Tags": Terms.ACTIVE_EFFECTS.disempower.name
								}
							}
						],
					},
				],
			},
		},
		"unnamed_card_1": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.discard,
						"dest_container": cfc.NMAP.deck,
						"subject_count": "all",
						"subject": "index",
						"subject_index": "top",
					},
					{
						"name": "shuffle_container",
						"dest_container": cfc.NMAP.deck,
					},
					{
						"name": "autoplay_card",
						"src_container": cfc.NMAP.deck,
						"subject_count": 1,
						"subject": "index",
						"subject_index": "random",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"unnamed_card_2": {
			"manual": {
				"hand": [
					{
						"name": "custom_script",
						"subject": "boardseek",
						"subject_count": "all",
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"unnamed_card_3": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "boardseek",
						"amount": 8,
						"subject_count": "all",
						"tags": ["Attack"],
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			},
		},
		"Absurdity Unleashed": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.absurdity_unleashed.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Dread": {
			"manual": {
				"hand": [
					{
						"name": "remove_card_from_deck",
						"subject": "self",
					},
				],
			},
		},
		"unnamed_card_4": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 11,
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
			"on_player_turn_ended": {
				"hand": [
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Change of Mind": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 8,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.deck,
					},
					{
						"name": "shuffle_container",
						"dest_container": cfc.NMAP.deck,
					},
				],
			},
		},
		"Brilliance": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.brilliance.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Recall": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.recall.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Eureka!": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.eureka.name,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Rapid Theorizing": {
			"manual": {
				"hand": [
					# We have a function to discard manually to ensure
					# it's not counted for checking if the hand is full
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 8,
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 2,
						"filter_event_count": {
							"event": "deck_shuffled",
							"filter_count": 1,
							"comparison": "ge",
						}
					},
					{
						"name": "draw_cards",
						"card_count": 1,
						"filter_turn_event_count": {
							"event": "deck_shuffled",
							"filter_count": 1,
							"comparison": "ge",
						}
					},
				],
			},
		},
		"Wild Inspiration": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.forgotten,
						"src_container": cfc.NMAP.deck,
						"subject": "index",
						"subject_index": "top",
						"is_cost": true,
					},
					{
						"name": "mod_counter",
						"counter_name": "immersion",
						"modification": 1,
					},
					{
						"name": "draw_cards",
						"card_count": 2,
					},
				],
			},
		},
		"unnamed_card_5": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 10,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "nested_script",
						"nested_tasks": [
							{
								"name": "move_card_to_container",
								"is_cost": true,
								"subject": "index",
								"subject_count": "all",
								"subject_index": "top",
								SP.KEY_NEEDS_SELECTION: true,
								SP.KEY_SELECTION_COUNT: 2,
								SP.KEY_SELECTION_TYPE: "equal",
								SP.KEY_SELECTION_OPTIONAL: true,
								SP.KEY_SELECTION_IGNORE_SELF: true,
								"src_container": cfc.NMAP.hand,
								"dest_container": cfc.NMAP.discard,
							},
							{
								"name": "move_card_to_container",
								"subject": "self",
								"dest_container": cfc.NMAP.deck,
							},
							{
								"name": "shuffle_container",
								"dest_container": cfc.NMAP.deck,
							},
						]
					}
				],
			},
		},
		"It's alive!": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 12,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": "per_encounter_event_count",
						"tags": ["Attack"],
						"per_encounter_event_count": {
							"event_name": "deck_shuffled",
							"multiplier": 2,
						}
					},
				],
			},
		},
		"Detect Weaknesses": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 9,
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "previous",
						"modification": 2,
						"filter_turn_event_count": {
							"event": "deck_shuffled",
							"filter_count": 1,
							"comparison": "ge",
						}
					},
				],
			},
		},
	}
	var break_loop := false
	var is_ephemeral := false
	for script_id in scripts:
		for prepend in SAME_SCRIPT_MODIFIERS:
			var card_name_with_unmodified_scripts = prepend + ' ' + script_id
			if card_name == card_name_with_unmodified_scripts:
				script_name = script_id
				if prepend == "Ephemeral":
					is_ephemeral = true
				break_loop = true
				break
		if break_loop: break
	# If an upgraded card uses the same script as the original
	# and it cannot be matched using SAME_SCRIPT_MODIFIERS
	# Then we can add it here
#	match card_name:
#		"Easy Confidence", "Solid Confidence":
#			script_name = "Confidence"
	# We return only the scripts that match the card name and trigger
	var ret_script = scripts.get(script_name,{}).duplicate(true)
	# We use this trick to avoid creating a whole new script for the ephemeral
	# upgraded versions, just to add the "remove from deck" task
	if is_ephemeral:
		ret_script["manual"]["hand"].append(EPHEMERAL_TASK)
	return(ret_script)

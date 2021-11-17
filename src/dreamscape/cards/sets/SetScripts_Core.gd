# Don't know why, but putting a class name here, breaks HTML exports
#class_name CoreScripts
extends Reference

# If the upgraded card name is prepending one of these words
# Then we know it's going to be using the same script definition as the original
# card.
# This allows us to avoid writing new definitions when all that is changing
# is the card statistics (like cost)
const SAME_SCRIPT_ADJECTIVES := [
	"Easy", # Used when the upgraded card has just lower cost
	"Solid", # Used when the upgraded card has higher amount or damage or defence.
	"Enhanced", # Used when the upgraded card has higher amount of effect stacks.
	"Ephemeral", # Used when the upgraded card is adding an extra task to remove the card from deck.
	"Fleeting", # Used when the upgraded card is adding an extra task to exhaust the card.
	"Swift", # Used when the upgraded card is increasing the amount of cards drawn.
	"Balanced", # Used when the upgraded card is tweaking all values at the same time.
]
const SAME_SCRIPT_SYMBOLS := [
	"@", # Used when the upgraded card has just lower cost
	"+", # Used when the upgraded card has higher amount of damage or defence.
	"*", # Used when the upgraded card has higher amount of effect stacks.
	"-", # Used when the upgraded card is adding an extra task to remove the card from deck.
	"~", # Used when the upgraded card is adding an extra task to exhaust the card.
	"!", # Used when the upgraded card is increasing the amount of cards drawn.
	"=", # Used when the upgraded card is tweaking all values at the same time.
	"%", # Used when the upgraded card is rebalancing all values at the same time.
	"^", # Used when the upgraded card is receiving the alpha keyword.
	"Ω", # Used when the upgraded card is receiving the omega keyword.
]

# When a the "Ephemeral" prepend has been added to a card upgrade
# It means the card is permanently removed from the deck after using it.
# This is the ScEng task that does this, and it is automatically appended
# to the card's normal scripts.
# For this to work properly, the card definition needs to also have
# The "_avoid_normal_discard" property set to true
const EPHEMERAL_TASK := {
	"name": "remove_card_from_deck",
	"subject": "self",
}



# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var Interpretation = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var Confidence = {
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
	}
	var NoisyWhip = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
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
	}
	var Divein = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks2"),
				}
			],
		},
	}
	var SafetyofAir = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": -cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("healing_amount", 0),
					"tags": ["Healing"],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.forgotten,
				},
			],
		},
	}
	var SustainedSafetyofAir = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": -cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("healing_amount", 0),
					"tags": ["Healing"],
				},
			],
		},
	}
	var NothingtoFear = {
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
	}
	var AbsolutelyNothingtoFear = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "absolutely",
				},
			],
		},
	}
	var OutofReach = {
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
	}
	var ConfoundingMovements = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"subject": "target",
					"needs_subject": true,
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				}
			],
		},
	}
	var InnerJustice = {
		"manual": {
			"hand": [
				{
					"name": "mod_counter",
					"counter_name": "immersion",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("immersion_amount"),
				},
			],
		},
	}
	var Whirlwind = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"repeat": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("chain_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var Overview = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "target",
					"amount": 0,
					"set_to_mod": true,
					"needs_subject": true,
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var PiercingOverview = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "target",
					"amount": 0,
					"set_to_mod": true,
					"needs_subject": true,
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
					"subject": "previous",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				},
			],
		},
	}
	var RubberEggs = {
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
	}
	var HardRubberEggs = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "hard",
				},
			],
		},
	}
	var BouncyRubberEggs = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "bouncy",
				},
			],
		},
	}
	var TheJoke = {
		"manual": {
			"hand": [
				{
					"name": "custom_script",
					"subject": "target",
					"needs_subject": true,
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				}
			],
		},
	}
	var Nunclucks = {
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
	}
	var MassiveNunclucks = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.nunclucks.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "massive",
				},
			],
		},
	}
	var Gummiraptor = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "modify_damage",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"subject": "previous",
					"filter_intent_stress": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("stress_amount"),
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				}
			],
		},
	}
	var CockyRetort = {
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
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "draw_cards",
					"card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
				},
			],
		},
	}
	var RapidEncirclement = {
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
				}
			],
		},
	}
	var BarrelThrough = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
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
	}
	var Intimidate = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"subject": "boardseek",
					"subject_count": "all",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				}
			],
		},
	}
	var CheekyApproach = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"subject": "target",
					"needs_subject": true,
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				}
			],
		},
	}
	var LaughatDanger = {
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
	}
	var RoaringLaughatDanger = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.laugh_at_danger.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "roaring",
				},
			],
		},
	}
	var ToweringPresence = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"tags": ["Attack"],
					"amount": "per_defence",
					"per_defence": {
						"subject": "dreamer",
					},
				},
			],
		},
	}
	var OverwhelmingPresence = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"tags": ["Attack"],
					"amount": "per_defence",
					"per_defence": {
						"subject": "dreamer",
					},
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "modify_damage",
					"subject": "previous",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
				},
			],
		},
	}
	var Unassailable = {
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
	}
	var CompletelyUnassailable = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.unassailable.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "completely",
				},
			],
		},
	}
	var Audacity = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				},
			],
		},
	}
	var Boast = {
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
	}
	var MassiveBoast = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
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
	}
	var SustainedBoast = {
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
			],
		},
	}
	var SolidUnderstanding = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
			],
		},
	}
	var NoSecondThoughts = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				},
			],
		},
	}
	var HighMorale = {
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
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "move_card_to_container",
					"subject": "tutor",
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
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
	}
	var ConfidentSlap = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"subject": "target",
					"needs_subject": true,
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				}
			],
		},
	}
	var CarefulObservation = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
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
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount2"),
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
	}
	var DragandDrop = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
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
	}
	var RunningStart = {
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
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "move_card_to_container",
					"subject": "tutor",
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
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
	}
	var MasterofSkies = {
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
	}
	var GloriousMasterofSkies = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.master_of_skies.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "glorious",
				},
			],
		},
	}
	var ZenofFlight = {
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
	}
	var MasterfulZenofFlight = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.zen_of_flight.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "masterful",
				},
			],
		},
	}
	var Loopdeloop = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				}
			],
		},
	}
	var Mania = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				}
			],
		},
	}
	var UtterlyRidiculous = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "boardseek",
					"subject_count": "all",
					"tags": ["Attack"],
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
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
				"filter_stacks": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("filter_amount"),
				"comparison": "ge",
			}
		},
	}
	var Ventriloquism = {
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
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "move_card_to_container",
					"subject": "tutor",
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
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
	}
	var BlindTrial = {
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
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
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
	}
	var SustainedBlindTrial = {
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
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
					"subject": "index",
					"subject_index": "random",
				},
			],
		},
	}
	var FowlLanguage =  {
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
	}
	var Cockfighting = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "boardseek",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"subject_count": "all",
					"tags": ["Attack"],
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var AbsurdityUnleashed = {
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
	}
	var TotalAbsurdityUnleashed = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.absurdity_unleashed.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "total",
				},
			],
		},
	}
	var unnamed_card_4 = {
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
	}
	var ChangeofMind = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
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
	}
	var Brilliance = {
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
	}
	var BlindingBrilliance = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.brilliance.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "blinding",
				},
			],
		},
	}
	var Recall = {
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
	}
	var TotalRecall = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.recall.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "total",
				},
			],
		},
	}
	var Eureka = {
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
	}
	var InspiredEureka = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.eureka.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "inspired",
				},
			],
		},
	}
	var RapidTheorizing = {
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
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount2"),
					"filter_turn_event_count": {
						"event": "deck_shuffled",
						"filter_count": 1,
						"comparison": "ge",
					}
				},
				{
					"name": "draw_cards",
					"card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
					"filter_turn_event_count": {
						"event": "deck_shuffled",
						"filter_count": 1,
						"comparison": "ge",
					}
				},
			],
		},
	}
	var WildInspiration = {
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
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("forget_amount"),
					"is_cost": true,
				},
				{
					"name": "mod_counter",
					"counter_name": "immersion",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("immersion_amount"),
				},
				{
					"name": "draw_cards",
					"card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
				},
			],
		},
	}
	var VexingConcept = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
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
							SP.KEY_SELECTION_COUNT: cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("discard_amount"),
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
	}
	var Itsalive = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
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
						"multiplier": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount2"),
					}
				},
			],
		},
	}
	var DetectWeaknesses = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
					"subject": "previous",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
					"filter_turn_event_count": {
						"event": "deck_shuffled",
						"filter_count": 1,
						"comparison": "ge",
					}
				},
			],
		},
	}
	var Flashbacks = {
		"manual": {
			"hand": [
				{
					"name": "draw_cards",
					"card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
				},
				{
					"name": "modify_properties",
					"set_properties": {"Cost": "0"},
					"subject": "previous",
				},
				{
					"name": "enable_rider",
					"rider": "reset_cost_after_play",
					"subject": "previous",
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.forgotten,
				},
			],
		},
	}
	var SustainedFlashbacks = {
		"manual": {
			"hand": [
				{
					"name": "draw_cards",
					"card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
				},
				{
					"name": "modify_properties",
					"set_properties": {"Cost": "0"},
					"subject": "previous",
				},
				{
					"name": "enable_rider",
					"rider": "reset_cost_after_play",
					"subject": "previous",
				},
			],
		},
	}
	var Perseverance = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				},
				{
					"name": "mod_counter",
					"counter_name": "immersion",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("immersion_amount"),
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.forgotten,
				},
			],
		},
	}
	var ImprovedPerseverance = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				},
				{
					"name": "mod_counter",
					"counter_name": "immersion",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("immersion_amount"),
				},
				{
					"name": "draw_cards",
					"card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.forgotten,
				},
			],
		},
	}
	var ItsTheSmallThings = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "modify_damage",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount2"),
					"tags": ["Attack"],
					"subject": "previous",
					"filter_turn_event_count": {
						"event": "immersion_increased",
						"filter_count": 1,
						"comparison": "ge",
					},
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var Confrontation = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"x_modifier": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("x_modifer", '0'),
					"x_operation": "multiply",
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var Dodge = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"is_cost": true,
					"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
					"filter_dreamer_defence": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("requirements_amount"),
					"comparison": "ge",
					"fail_cost_on_skip": true,
				},
			],
		},
	}
	var Introspection = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.introspection.name,
					"subject": "dreamer",
					"modification": 1,
				},
			],
		},
	}
	var LightIntrospection = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.introspection.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "light",
				},
			],
		},
	}
	var DeepIntrospection = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.introspection.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "deep",
				},
			],
		},
	}
	var Dismissal = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("exert_amount"),
					"tags": ["Exert"],
				},
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				}
			],
		},
	}
	var CouldBeWorse = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("exert_amount"),
					"tags": ["Exert"],
				},
			],
		},
	}
	var TheHappyPlace = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.the_happy_place.name,
					"subject": "dreamer",
					"modification": 1,
				},
			],
		},
	}
	var SelfDeception = {
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
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("exert_amount"),
					"tags": ["Exert"],
				},
				{
					"name": "draw_cards",
					"card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
				},
				{
					"name": "move_card_to_container",
					"subject": "tutor",
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount2"),
					"src_container":  cfc.NMAP.deck,
					"dest_container":  cfc.NMAP.hand,
					"filter_state_tutor": [
						{
							"filter_properties": {
								"Tags": Terms.GENERIC_TAGS.exert.name
							}
						}
					],
				},
			],
		},
	}
	var ThatTooShallPass = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("exert_amount"),
					"tags": ["Exert"],
				},
				{
					"name": "mod_counter",
					"counter_name": "immersion",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("immersion_amount"),
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.forgotten,
				},
			],
		},
	}
	var ThatTooMustPass = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("exert_amount"),
					"tags": ["Exert"],
				},
				{
					"name": "mod_counter",
					"counter_name": "immersion",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("immersion_amount"),
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.forgotten,
				},
				{
					"name": "draw_cards",
					"card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount"),
				},

			],
		},
	}
	var ItsNotAboutMe = {
		"manual": {
			"hand": {
				"Take Anxiety to Interpret all Torments": [
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("exert_amount"),
						"tags": ["Exert"],
					},
					{
						"name": "modify_damage",
						"subject": "boardseek",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"subject_count": "all",
						"tags": ["Attack"],
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
				"Interpret single Torment": [
					{
						"name": "modify_damage",
						"subject": "target",
						"needs_subject": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			}
		},
	}
	var Rancor = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "modify_damage",
					"subject": "boardseek",
					"amount": "per_turn_event_count",
					"tags": ["Attack"],
					"per_turn_event_count": {
						"event_name": "player_total_damage",
					},
					"subject_count": "all",
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var JustifiedRancor = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "boardseek",
					"amount": "per_turn_event_count",
					"tags": ["Attack"],
					"per_turn_event_count": {
						"multiplier": 3,
						"event_name": "player_total_damage",
					},
					"subject_count": "all",
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var LastOut = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.lash_out.name,
					"subject": "dreamer",
					"modification": 1,
				},
			],
		},
	}
	var FrustratedLastOut = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.lash_out.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "frustrated",
				},
			],
		},
	}
	var IsItMyFault = {
		"manual": {
			"hand": {
				"Take Anxiety to interpret single Torment bypassing perplexity": [
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("exert_amount"),
						"tags": ["Exert"],
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"needs_subject": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack", "Unblockable"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
				"Interpret single Torment": [
					{
						"name": "modify_damage",
						"subject": "target",
						"needs_subject": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			}
		},
	}
	var EnoughIsEnough = {
		"manual": {
			"hand": {
				"Take Anxiety to interpret and inflict Doubt on single Torment.": [
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("exert_amount"),
						"tags": ["Exert"],
					},
					{
						"name": "modify_damage",
						"subject": "target",
						"needs_subject": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "previous",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
				"Interpret single Torment": [
					{
						"name": "modify_damage",
						"subject": "target",
						"needs_subject": true,
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("damage_amount"),
						"tags": ["Attack"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			}
		},
	}
	var Grit = {
		"manual": {
			"hand": {
				"Take Anxiety to gain Confidence and Courage.": [
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("exert_amount"),
						"tags": ["Exert"],
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
						"subject": "dreamer",
						"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
				"Gain Confidence": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
					}
				],
			}
		},
	}
	var Excuses = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.excuses.name,
					"subject": "dreamer",
					"modification": 1,
				},
			],
		},
	}
	var EndlessExcuses = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.excuses.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "endless",
				},
			],
		},
	}
	var Tolerance = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.tolerance.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
				},
			],
		},
	}
	var ExtremeTolerance = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.tolerance.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("effect_stacks"),
					"upgrade_name": "extreme",
				},
			],
		},
	}
	var Catatonia = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": -cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("healing_amount", 0),
					"tags": ["Healing"],
					"filter_damage_percent": {
						"percent": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("health_percent", 0),
						"comparison": "ge",
					},
				},
				{
					"name": "modify_damage",
					"amount": -cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("healing_amount", 0),
					"tags": ["Healing"],
					"subject": "dreamer",
					"filter_encounter_event_count": {
						"event": "player_total_damage_own_turn",
						"filter_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("anxiety_taken", 0),
						"comparison": "ge",
					},
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.forgotten,
				},
			],
		},
	}
	var Disengage = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
			],
		},
	}
	var SurvivalMode = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "mod_counter",
					"counter_name": "immersion",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("immersion_amount"),
					"filter_damage_percent": {
						"percent": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("health_percent", 0),
						"comparison": "ge",
					},
				},
			],
		},
	}
	var AThousandSqueaks = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "boardseek",
					"subject_count": "all",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"x_modifier": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("x_modifer", '0'),
					"x_operation": "multiply",
					"tags": ["Attack"],
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"subject": "boardseek",
					"subject_count": "all",
					"modification": 1,
					"x_modifier": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("x_modifer", '0'),
					"x_operation": "multiply",
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				}
			],
		},
	}
	var Hyperfocus = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
					"x_modifier": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("x_modifer", '0'),
					"x_operation": "multiply",
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks", '0'),
					"x_modifier": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("x_modifer", '0'),
					"x_operation": "multiply",
				}
			],
		},
	}
	var Misunderstood = {
		"manual": {
			"hand": {
				"Gain Confidence, take Anxiety and shuffle card back into the deck.": [
					{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("exert_amount"),
						"tags": ["Exert"],
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
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
				"Gain Confidence": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("defence_amount"),
					},
					# We add the discard manually, because the card ignores normal discard.
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.discard,
					},
				],
			}
		},
	}
	var DeathRay = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "boardseek",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"subject_count": "all",
					"tags": ["Attack"],
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "modify_damage",
					"subject": "boardseek",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount2"),
					"subject_count": "all",
					"tags": ["Attack"],
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
					"filter_per_tutor_count": {
						"src_container": cfc.NMAP.deck,
						"subject": "tutor",
						"subject_count": "all",
						"filter_card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("deck_size", 0),
						"comparison": "ge",
					},
				},
			],
		},
	}
	var Unconventional = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.unconventional.name,
					"subject": "dreamer",
					"modification": 1,
				},
			],
		},
	}
	var WeirdlyUnconventional = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.unconventional.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "weirdly"
				},
			],
		},
	}
	var EndlessPosibilities = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.deck,
					"filter_per_tutor_count": {
						"src_container": cfc.NMAP.deck,
						"subject": "tutor",
						"subject_count": "all",
						"filter_card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("deck_size", 0),
						"comparison": "ge",
					},
				},
				{
					"name": "shuffle_container",
					"dest_container": cfc.NMAP.deck,
					"filter_per_tutor_count": {
						"src_container": cfc.NMAP.deck,
						"subject": "tutor",
						"subject_count": "all",
						"filter_card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("deck_size", 0),
						"comparison": "ge",
					},
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks2"),
					"filter_per_tutor_count": {
						"src_container": cfc.NMAP.deck,
						"subject": "tutor",
						"subject_count": "all",
						"filter_card_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("deck_size", 0),
						"comparison": "ge",
					},
				},
			],
		},
	}
	var IllShowThemAll = {
		"manual": {
			"hand": [
				{
					"name": "move_card_to_container",
					"dest_container": cfc.NMAP.discard,
					"subject": "self",
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
					"subject": "dreamer",
					"modification": 0,
					"store_integer": true,
					"set_to_mod": true,
				},
				{
					"name": "mod_counter",
					"counter_name": "immersion",
					"modification": "retrieve_integer",
					"adjust_retrieved_integer": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("immersion_amount", 0),
					"store_integer": true,
					"is_inverted": true
				},
				{
					"name": "draw_cards",
					"card_count": "retrieve_integer",
					"adjust_retrieved_integer": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("draw_amount", 0),
				},

			],
		},
	}
	var AFineSpecimen = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "modify_damage",
					"subject": "previous",
					"amount": "per_tutor",
					"tags": ["Attack"],
					"per_tutor": {
						"src_container": cfc.NMAP.deck,
						"subject": "tutor",
						"subject_count": "all",
						"multiplier": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("chain_amount"),
						"divider": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("per_division"),
					},
				},
			],
		},
	}
	var MisplacedResearch = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "move_card_to_container",
					"src_container": cfc.NMAP.discard,
					"dest_container": cfc.NMAP.deck,
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("card_amount"),
					"subject": "index",
					"subject_index": "top",
				},
				{
					"name": "shuffle_container",
					"dest_container": cfc.NMAP.deck,
				},
			],
		},
	}
	var Excogitate = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "move_card_to_container",
					"src_container": cfc.NMAP.forgotten,
					"dest_container": cfc.NMAP.deck,
					"subject_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("card_amount"),
					"subject": "index",
					"subject_index": "random",
				},
				{
					"name": "shuffle_container",
					"dest_container": cfc.NMAP.deck,
				},
			],
		},
	}
	var TheWhippyFlippy = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks1"),
					"store_integer": true,
					"filter_intent_stress": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("stress_threshold1"),
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.empower.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks2"),
					"store_integer": true,
					"filter_intent_stress": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("stress_threshold2"),
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks3"),
					"store_integer": true,
					"filter_intent_stress": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("stress_threshold3"),
				},
			],
		},
	}
	var ThePlotChickens = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "nested_script",
					"nested_tasks": [
						{
							"name": "assign_defence",
							"subject": "dreamer",
							"amount": cfc.card_definitions[card_name]\
									.get("_amounts",{}).get("defence_amount"),
						},
						{
							"name": "apply_effect",
							"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
							"subject": "dreamer",
							"modification": cfc.card_definitions[card_name]\
									.get("_amounts",{}).get("effect_stacks"),
						},
					],
					# This trick allows me to trigger parts of the script only
					# if the previous target matches a filter
					"subject": "previous",
					"filter_state_subject": [{
						"filter_effects": [
							{
								"filter_effect_name": "Confusion",
							},
						]
					}],
				}
			],
		},
	}
	var AStrangeGaida = {
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
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.marked.name,
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
	}
	var OneWithThePoultry = {
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
							"name": "apply_effect",
							"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
							"subject": "dreamer",
							"modification": cfc.card_definitions[card_name]\
									.get("_amounts",{}).get("effect_stacks"),
						},
					],
					# This trick allows me to trigger parts of the script only
					# if the previous target matches a filter
					"subject": "dreamer",
					"filter_state_subject": [{
						"filter_effects": [
							{
								"filter_effect_name": "Fascination",
							},
						]
					}],
				}
			],
		},
	}
	var SneakBeaky = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.sneaky_beaky.name,
					"subject": "dreamer",
					"modification": 1,
				},
			],
		},
	}
	var Sensuous = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"subject": "target",
					"needs_subject": true,
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
					"subject": "dreamer",
					"modification": "per_effect_stacks",
					"per_effect_stacks": {
						"effect_name": "Confusion",
						"subject": "previous",
						"original_previous": true,
					}
				},
			],
		},
	}
	var MassiveEggression = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
						.get("_amounts",{}).get("effect_stacks"),
				},
			],
		},
	}
	var Impugn = {
		"manual": {
			"hand": [
				{
					"name": "null_script",
					"subject": "target",
					"needs_subject": true,
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "modify_damage",
					"subject": "previous",
					"protect_previous": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack", "Unblockable"],
					"filter_state_subject": [{
						"filter_effects": [
							{
								"filter_effect_name": "Doubt",
								"filter_count": 1,
								"comparison": "ge",
							},
						]
					}],
				},
				{
					"name": "modify_damage",
					"subject": "previous",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_effects": [
							{
								"filter_effect_name": "Doubt",
								"filter_count": 0,
								"comparison": "eq",
							},
						]
					}],
				},
			],
		},
	}
	var Unshakeable = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": cfc.NMAP.forgotten,
				},
			],
		},
	}
	var ConfidentlyUnshakeable = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": 0,
					"set_to_mod": true,
				},
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
				}
			],
		},
	}
	var Tenacity = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.tenacity.name,
					"subject": "dreamer",
					"modification": 1,
				},
			],
		},
	}
	var DoggedTenacity = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.tenacity.name,
					"subject": "dreamer",
					"modification": 1,
					"upgrade_name": "dogged",
				},
			],
		},
	}
	var TheFinger = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
					"filter_dreamer_defence": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("requirements_amount"),
					"comparison": "le",
				},
			],
		},
	}
	var BringIt = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "boardseek",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"subject_count": "all",
					"tags": ["Attack"],
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
					"subject": "boardseek",
					"sort_by": "random",
					"modification": cfc.card_definitions[card_name]\
						.get("_amounts",{}).get("effect_stacks"),
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
				},
			],
		},
	}
	var Sanguine = {
		"manual": {
			"hand": [
				{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("defence_amount"),
					"x_modifier": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("x_modifer", '0'),
					"x_operation": "multiply",
				}
			],
		},
	}
	var Launch = {
		"manual": {
			"hand": [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
					"subject": "dreamer",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks"),
					"x_modifier": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("x_modifer", 0),
					"x_operation": "multiply",
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
					"subject": "boardseek",
					"subject_count": "all",
					"modification": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("effect_stacks2"),
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					}],
					"filter_x_usage": {
						"filter_count": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("x_requirement"),
					}
				}

			],
		},
	}
	var Swoop = {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": cfc.card_definitions[card_name]\
							.get("_amounts",{}).get("damage_amount"),
					"repeat": "per_effect_stacks",
					"tags": ["Attack"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					}],
					"per_effect_stacks": {
						"effect_name": "Untouchable",
						"subject": "dreamer",
						"modifier": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("per_modifier", 0),
						"multiplier": cfc.card_definitions[card_name]\
								.get("_amounts",{}).get("per_multiplier", 1),
					}
				},
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
					"subject": "dreamer",
					"modification": 0,
					"set_to_mod": true
				},
			],
		},
	}


	# This format allows me to trace which script failed during load
	var scripts := {
		"Interpretation": Interpretation,
		"Confidence": Confidence,
		"Noisy Whip": NoisyWhip,
		"Dive-in": Divein,
		"Safety of Air": SafetyofAir,
		"Sustained Safety of Air": SustainedSafetyofAir,
		"Nothing to Fear": NothingtoFear,
		"Absolutely Nothing to Fear": AbsolutelyNothingtoFear,
		"Out of Reach": OutofReach,
		"Confounding Movements": ConfoundingMovements,
		"Inner Justice": InnerJustice,
		"Whirlwind": Whirlwind,
		"Overview": Overview,
		"Piercing Overview": PiercingOverview,
		"Rubber Eggs": RubberEggs,
		"Hard Rubber Eggs": HardRubberEggs,
		"Bouncy Rubber Eggs": BouncyRubberEggs,
		"The Joke": TheJoke,
		"Nunclucks": Nunclucks,
		"Massive Nunclucks": MassiveNunclucks,
		"Gummiraptor": Gummiraptor,
		"Cocky Retort": CockyRetort,
		"Rapid Encirclement": RapidEncirclement,
		"Barrel Through": BarrelThrough,
		"Intimidate": Intimidate,
		"Cheeky Approach": CheekyApproach,
		"Laugh at Danger": LaughatDanger,
		"Roaring Laugh at Danger": RoaringLaughatDanger,
		"Towering Presence": ToweringPresence,
		"Overwhelming Presence": OverwhelmingPresence,
		"Unassailable": Unassailable,
		"Completely Unassailable": CompletelyUnassailable,
		"Audacity": Audacity,
		"Boast": Boast,
		"Massive Boast": MassiveBoast,
		"Sustained Boast": SustainedBoast,
		"Solid Understanding": SolidUnderstanding,
		"No Second Thoughts": NoSecondThoughts,
		"High Morale": HighMorale,
		"Confident Slap": ConfidentSlap,
		"CarefulObservation": CarefulObservation,
		"Drag and Drop": DragandDrop,
		"Running Start": RunningStart,
		"Master of Skies": MasterofSkies,
		"Glorious Master of Skies": GloriousMasterofSkies,
		"Zen of Flight": ZenofFlight,
		"Masterful Zen of Flight": MasterfulZenofFlight,
		"Loop de loop": Loopdeloop,
		"Mania": Mania,
		"Utterly Ridiculous": UtterlyRidiculous,
		"Ventriloquism": Ventriloquism,
		"Blind Trial": BlindTrial,
		"Sustained Blind Trial": SustainedBlindTrial,
		"Fowl Language": FowlLanguage,
		"Cockfighting": Cockfighting,
		"Absurdity Unleashed": AbsurdityUnleashed,
		"Total Absurdity Unleashed": TotalAbsurdityUnleashed,
		"unnamed_card_4": unnamed_card_4,
		"Change of Mind": ChangeofMind,
		"Brilliance": Brilliance,
		"Blinding Brilliance": BlindingBrilliance,
		"Recall": Recall,
		"Total Recall": TotalRecall,
		"Eureka!": Eureka,
		"Inspired Eureka!": InspiredEureka,
		"Rapid Theorizing": RapidTheorizing,
		"Wild Inspiration": WildInspiration,
		"Vexing Concept": VexingConcept,
		"It's alive!": Itsalive,
		"Detect Weaknesses": DetectWeaknesses,
		"Flashbacks": Flashbacks,
		"Sustained Flashbacks": SustainedFlashbacks,
		"Perseverance": Perseverance,
		"Improved Perseverance": ImprovedPerseverance,
		"It's The Small Things": ItsTheSmallThings,
		"Confrontation": Confrontation,
		"Dodge": Dodge,
		"Introspection": Introspection,
		"Light Introspection": LightIntrospection,
		"Deep Introspection": DeepIntrospection,
		"Dismissal": Dismissal,
		"Could Be Worse": CouldBeWorse,
		"The Happy Place": TheHappyPlace,
		"Self-Deception": SelfDeception,
		"That too, shall pass": ThatTooShallPass,
		"That too, must pass": ThatTooMustPass,
		"It's not about me": ItsNotAboutMe,
		"Rancor": Rancor,
		"Justified Rancor": JustifiedRancor,
		"Lash-out": LastOut,
		"Frustrated Lash-out": FrustratedLastOut,
		"Is it my fault?": IsItMyFault,
		"Enough if enough!": EnoughIsEnough,
		"Grit": Grit,
		"Excuses": Excuses,
		"Endless Excuses": EndlessExcuses,
		"Tolerance": Tolerance,
		"Extreme Tolerance": ExtremeTolerance,
		"Catatonia": Catatonia,
		"Disengage": Disengage,
		"Survival Mode": SurvivalMode,
		"A Thousand Squeaks": AThousandSqueaks,
		"Hyperfocus": Hyperfocus,
		"Misunderstood": Misunderstood,
		"Death Ray": DeathRay,
		"Unconventional": Unconventional,
		"Weirdly Unconventional": WeirdlyUnconventional,
		"Endless Posibilities": EndlessPosibilities,
		"I'll Show Them All": IllShowThemAll,
		"A Fine Specimen": AFineSpecimen,
		"Misplaced Research": MisplacedResearch,
		"Excogitate": Excogitate,
		"The Whippy-Flippy": TheWhippyFlippy,
		"A Strange Gaida": AStrangeGaida,
		"One With The Poultry": OneWithThePoultry,
		"Sneaky-Beaky": SneakBeaky,
		"Sensuous": Sensuous,
		"Massive Eggression": MassiveEggression,
		"The Plot Chickens...": ThePlotChickens,
		"Impugn": Impugn,
		"Unshakeable": Unshakeable,
		"Confidently Unshakeable": ConfidentlyUnshakeable,
		"Tenacity": Tenacity,
		"Dogged Tenacity": DoggedTenacity,
		"The Finger": TheFinger,
		"Bring It!": BringIt,
		"Sanguine": Sanguine,
		"Launch": Launch,
		"Swoop": Swoop,
	}
	return(_prepare_scripts(scripts, card_name))

# Takes care to return the correct script, even for card with standard upgrades
func _prepare_scripts(all_scripts: Dictionary, card_name: String) -> Dictionary:
	# When a the "Fleeting" prepend has been added to a card upgrade
	# It means the card is forgotten after using it.
	# This is the ScEng task that does this, and it is automatically appended
	# to the card's normal scripts.
	# We cannot make this into a const as it refers via NMAP
	var FLEETING_TASK := {
		"name": "move_card_to_container",
		"subject": "self",
		"dest_container": cfc.NMAP.forgotten,
	}
	var script_name := card_name
	var break_loop := false
	var special_destination = null
	for script_id in all_scripts:
		for prepend in SAME_SCRIPT_ADJECTIVES:
			var card_name_with_unmodified_scripts = prepend + ' ' + script_id
			if card_name == card_name_with_unmodified_scripts:
				script_name = script_id
				if prepend in ["Ephemeral", "Fleeting"]:
					special_destination = prepend
				break_loop = true
				break
		for symbol in SAME_SCRIPT_SYMBOLS:
			var card_name_with_unmodified_scripts = symbol + ' ' + script_id + ' ' + symbol
			if card_name == card_name_with_unmodified_scripts:
				script_name = script_id
				if symbol in ["-", "~"]:
					special_destination = symbol
				break_loop = true
				break
		if break_loop: break
	# We can mark which script to reuse in each card's definition
	# This allows us to reuse scripts, using different names than the prepends
	# in SAME_SCRIPT_ADJECTIVES
	if cfc.card_definitions[card_name].has("_reuse_script"):
		script_name = cfc.card_definitions[card_name]["_reuse_script"]
	# We return only the scripts that match the card name and trigger
	var ret_script = all_scripts.get(script_name,{}).duplicate(true)
	# We use this trick to avoid creating a whole new script for the ephemeral
	# upgraded versions, just to add the "remove from deck" task
	match special_destination:
		"Ephemeral", '-':
			ret_script["manual"]["hand"].append(EPHEMERAL_TASK)
		"Fleeting", '~':
			ret_script["manual"]["hand"].append(FLEETING_TASK)
	return(ret_script)

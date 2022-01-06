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
	"tags": ["Played", "Card"],
}


const Interpretation = {
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
		],
	},
}
const Confidence = {
	"manual": {
		"hand": [
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
}
const NoisyWhip = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": 5,
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"subject": "previous",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			}
		],
	},
}
const Divein = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks2"
				},
			}
		],
	},
}
const SafetyofAir = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "healing_amount",
					"default": 0,
					"is_inverted": true,
				},
				"tags": ["Healing", "Card"],
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
const SustainedSafetyofAir = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "healing_amount",
					"default": 0,
					"is_inverted": true,
				},
				"tags": ["Healing", "Card"],
			},
		],
	},
}
const NothingtoFear = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const AbsolutelyNothingtoFear = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "absolutely",
			},
		],
	},
}
const OutofReach = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	},
}
const ConfoundingMovements = {
	"manual": {
		"hand": [
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"subject": "target",
				"needs_subject": true,
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const InnerJustice = {
	"manual": {
		"hand": [
			{
				"name": "mod_counter",
				"tags": ["Card"],
				"counter_name": "immersion",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "immersion_amount"
				},
			},
		],
	},
}
const Whirlwind = {
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
				"repeat": {
					"lookup_property": "_amounts",
					"value_key": "chain_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const Overview = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "target",
				"amount": 0,
				"set_to_mod": true,
				"needs_subject": true,
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const PiercingOverview = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "target",
				"amount": 0,
				"set_to_mod": true,
				"needs_subject": true,
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"subject": "previous",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	},
}
const RubberEggs = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const HardRubberEggs = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "hard",
			},
		],
	},
}
const BouncyRubberEggs = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.rubber_eggs.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "bouncy",
			},
		],
	},
}
const TheJoke = {
	"manual": {
		"hand": [
			{
				"name": "custom_script",
				"tags": ["Card"],
				"subject": "target",
				"needs_subject": true,
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const Nunclucks = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.nunclucks.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const MassiveNunclucks = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.nunclucks.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "massive",
			},
		],
	},
}
const FindWeakness = {
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
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"subject": "previous",
				"filter_intent_stress": {
					"lookup_property": "_amounts",
					"value_key": "stress_amount"
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const CockyRetort = {
	"manual": {
		"hand": [
			# We have a function to discard manually to ensure
			# it's not counted for checking if the hand is full
			{
				"name": "move_card_to_container",
				"dest_container": "discard",
				"subject": "self",
				"tags": ["Played", "Card"],
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
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
		],
	},
}
const RapidEncirclement = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"subject": "boardseek",
				"subject_count": "all",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const BarrelThrough = {
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
				"subject": "previous",
			},
		],
	},
}
const Intimidate = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
				"subject": "boardseek",
				"subject_count": "all",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const CheekyApproach = {
	"manual": {
		"hand": [
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
				"subject": "target",
				"needs_subject": true,
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const LaughatDanger = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.laugh_at_danger.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const RoaringLaughatDanger = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.laugh_at_danger.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "roaring",
			},
		],
	},
}
const ToweringPresence = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"tags": ["Attack", "Card"],
				"amount": "per_defence",
				"per_defence": {
					"subject": "dreamer",
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const OverwhelmingPresence = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"tags": ["Attack", "Card"],
				"amount": "per_defence",
				"per_defence": {
					"subject": "dreamer",
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "modify_damage",
				"subject": "previous",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
			},
		],
	},
}
const Unassailable = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.unassailable.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const CompletelyUnassailable = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.unassailable.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "completely",
			},
		],
	},
}
const Audacity = {
	"manual": {
		"hand": [
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	},
}
const Boast = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": "per_defence",
				"per_defence": {
					"subject": "dreamer",
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": 0,
				"set_to_mod": true
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
const MassiveBoast = {
	"manual": {
		"hand": [
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
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": "per_defence",
				"per_defence": {
					"subject": "dreamer",
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": 0,
				"set_to_mod": true
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
const SustainedBoast = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": "per_defence",
				"per_defence": {
					"subject": "dreamer",
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": 0,
				"set_to_mod": true
			},
		],
	},
}
const SolidUnderstanding = {
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
}
const NoSecondThoughts = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	},
}
const HighMorale = {
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
				"name": "move_card_to_container",
				"tags": ["Card"],
				"subject": "tutor",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
				"src_container":  "deck",
				"dest_container":  "hand",
				"filter_state_tutor": [
					{
						"filter_properties": {
							"Tags": Terms.ACTIVE_EFFECTS.fortify.name
						},
					},
				],
			},
		],
	},
}
const ConfidentSlap = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
				"subject": "target",
				"needs_subject": true,
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const CarefulObservation = {
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
				"filter_dreamer_effect": Terms.ACTIVE_EFFECTS.impervious.name,
				"filter_stacks": 0,
				"comparison": "eq",
			},
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount2"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
				"filter_dreamer_effect": Terms.ACTIVE_EFFECTS.impervious.name,
				"filter_stacks": 1,
				"comparison": "ge",
			},
		],
	},
}
const DragandDrop = {
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
}
const RunningStart = {
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
				"name": "move_card_to_container",
				"tags": ["Card"],
				"subject": "tutor",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
				"src_container":  "deck",
				"dest_container":  "hand",
				"filter_state_tutor": [
					{
						"filter_properties": {
							"Tags": Terms.ACTIVE_EFFECTS.impervious.name
						},
					},
				],
			},
		],
	},
}
const MasterofSkies = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.master_of_skies.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const GloriousMasterofSkies = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.master_of_skies.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "glorious",
			},
		],
	},
}
const ZenofFlight = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.zen_of_flight.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "turns_amount"
				},
			},
		],
	},
}
const MasterfulZenofFlight = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.zen_of_flight.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "turns_amount"
				},
				"upgrade_name": "masterful",
			},
		],
	},
}
const Loopdeloop = {
	"manual": {
		"hand": [
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			}
		],
	},
}
const Mania = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			}
		],
	},
}
const UtterlyRidiculous = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"subject_count": "all",
				"tags": ["Attack", "Card"],
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
		"filter_per_effect_stacks": {
			"subject": "boardseek",
			"subject_count": "all",
			"filter_state_seek": [{
				"filter_group": "EnemyEntities",
			}],
			"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
			"filter_stacks": {
					"lookup_property": "_amounts",
					"value_key": "filter_amount"
				},
			"comparison": "ge",
		}
	},
}
const Ventriloquism = {
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
				"name": "move_card_to_container",
				"tags": ["Card"],
				"subject": "tutor",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
				"src_container":  "deck",
				"dest_container":  "hand",
				"filter_state_tutor": [
					{
						"filter_properties": {
							"Tags": Terms.ACTIVE_EFFECTS.disempower.name
						},
					},
				],
			},
		],
	},
}
const BlindTrial = {
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"src_container": "discard",
				"dest_container": "deck",
				"subject_count": "all",
				"subject": "index",
				"subject_index": "top",
			},
			{
				"name": "shuffle_container",
				"tags": ["Card"],
				"dest_container": "deck",
			},
			{
				"name": "autoplay_card",
				"src_container": "deck",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
				"subject": "index",
				"subject_index": "random",
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
const SustainedBlindTrial = {
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"src_container": "discard",
				"dest_container": "deck",
				"subject_count": "all",
				"subject": "index",
				"subject_index": "top",
			},
			{
				"name": "shuffle_container",
				"tags": ["Card"],
				"dest_container": "deck",
			},
			{
				"name": "autoplay_card",
				"tags": ["Card"],
				"src_container": "deck",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
				"subject": "index",
				"subject_index": "random",
			},
		],
	},
}
const FowlLanguage =  {
	"manual": {
		"hand": [
			{
				"name": "custom_script",
				"tags": ["Card"],
				"subject": "boardseek",
				"subject_count": "all",
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const Cockfighting = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"subject_count": "all",
				"tags": ["Attack", "Card"],
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const AbsurdityUnleashed = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.absurdity_unleashed.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const TotalAbsurdityUnleashed = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.absurdity_unleashed.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "total",
			},
		],
	},
}
const unnamed_card_4 = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": 11,
			},
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
	"on_player_turn_ended": {
		"hand": [
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"subject": "self",
				"dest_container": "forgotten",
			},
		],
	},
}
const ChangeofMind = {
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
				"dest_container": "deck",
				"tags": ["Played", "Card"],
			},
			{
				"name": "shuffle_container",
				"tags": ["Card"],
				"dest_container": "deck",
			},
		],
	},
}
const Brilliance = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.brilliance.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const BlindingBrilliance = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.brilliance.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "blinding",
			},
		],
	},
}
const Recall = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.recall.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const TotalRecall = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.recall.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "total",
			},
		],
	},
}
const Eureka = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.eureka.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const InspiredEureka = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.eureka.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "inspired",
			},
		],
	},
}
const RapidTheorizing = {
	"manual": {
		"hand": [
			# We have a function to discard manually to ensure
			# it's not counted for checking if the hand is full
			{
				"name": "move_card_to_container",
				"dest_container": "discard",
				"subject": "self",
				"tags": ["Played", "Card"],
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
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "defence_amount2"
				},
				"filter_turn_event_count": {
					"event": "deck_shuffled",
					"filter_count": 1,
					"comparison": "ge",
				},
			},
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
				"filter_turn_event_count": {
					"event": "deck_shuffled",
					"filter_count": 1,
					"comparison": "ge",
				},
			},
		],
	},
}
const WildInspiration = {
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"dest_container": "discard",
				"subject": "self",
				"tags": ["Played", "Card"],
			},
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"dest_container": "forgotten",
				"src_container": "deck",
				"subject": "index",
				"subject_index": "top",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "forget_amount"
				},
				"is_cost": true,
			},
			{
				"name": "mod_counter",
				"tags": ["Card"],
				"counter_name": "immersion",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "immersion_amount"
				},
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
}
const VexingConcept = {
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
				"name": "nested_script",
				"nested_tasks": [
					{
						"name": "move_card_to_container",
						"tags": ["Card"],
						"is_cost": true,
						"subject": "index",
						"subject_count": "all",
						"subject_index": "top",
						SP.KEY_NEEDS_SELECTION: true,
						SP.KEY_SELECTION_COUNT: {
							"lookup_property": "_amounts",
							"value_key": "discard_amount"
						},
						SP.KEY_SELECTION_TYPE: "equal",
						SP.KEY_SELECTION_OPTIONAL: true,
						SP.KEY_SELECTION_IGNORE_SELF: true,
						"src_container": "hand",
						"dest_container": "discard",
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": "deck",
						"tags": ["Played", "Card"],
					},
					{
						"name": "shuffle_container",
						"tags": ["Card"],
						"dest_container": "deck",
					},
				]
			}
		],
	},
}
const Itsalive = {
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
				"subject": "previous",
				"amount": "per_encounter_event_count",
				"tags": ["Attack", "Card"],
				"per_encounter_event_count": {
					"event_name": "deck_shuffled",
					"multiplier": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount2"
				},
				},
			},
		],
	},
}
const DetectWeaknesses = {
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"subject": "previous",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_turn_event_count": {
					"event": "deck_shuffled",
					"filter_count": 1,
					"comparison": "ge",
				},
			},
		],
	},
}
const Flashbacks = {
	"manual": {
		"hand": [
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
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
	},
}
const SustainedFlashbacks = {
	"manual": {
		"hand": [
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
			{
				"name": "modify_properties",
				"tags": ["Card"],
				"set_properties": {"Cost": "0"},
				"subject": "previous",
			},
			{
				"name": "enable_rider",
				"tags": ["Card"],
				"rider": "reset_cost_after_play",
				"subject": "previous",
			},
		],
	},
}
const Perseverance = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
			{
				"name": "mod_counter",
				"tags": ["Card"],
				"counter_name": "immersion",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "immersion_amount"
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
const ImprovedPerseverance = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
			{
				"name": "mod_counter",
				"tags": ["Card"],
				"counter_name": "immersion",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "immersion_amount"
				},
			},
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
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
const ItsTheSmallThings = {
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
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount2"
				},
				"tags": ["Attack", "Card"],
				"subject": "previous",
				"filter_turn_event_count": {
					"event": "immersion_increased",
					"filter_count": 1,
					"comparison": "ge",
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const Confrontation = {
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
				"x_modifier": {
					"lookup_property": "_amounts",
					"value_key": "x_modifer",
					"default": '0',
				},
				"x_operation": "multiply",
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const Dodge = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"is_cost": true,
				"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_dreamer_defence": {
					"lookup_property": "_amounts",
					"value_key": "requirements_amount"
				},
				"comparison": "ge",
				"fail_cost_on_skip": true,
			},
		],
	},
}
const Introspection = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.introspection.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "turns_amount"
				},
			},
		],
	},
}
const LightIntrospection = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.introspection.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "turns_amount"
				},
				"upgrade_name": "light",
			},
		],
	},
}
const DeepIntrospection = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.introspection.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "turns_amount"
				},
				"upgrade_name": "deep",
			},
		],
	},
}
const Dismissal = {
	"manual": {
		"hand": [
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
			}
		],
	},
}
const CouldBeWorse = {
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
		],
	},
}
const TheHappyPlace = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.the_happy_place.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const SelfDeception = {
	"manual": {
		"hand": [
			# We have a function to discard manually to ensure
			# it's not counted for checking if the hand is full
			{
				"name": "move_card_to_container",
				"dest_container": "discard",
				"subject": "self",
				"tags": ["Played", "Card"],
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
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"subject": "tutor",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount2"
				},
				"src_container":  "deck",
				"dest_container":  "hand",
				"filter_state_tutor": [
					{
						"filter_properties": {
							"Tags": Terms.GENERIC_TAGS.exert.name
						},
					},
				],
			},
		],
	},
}
const ThatTooShallPass = {
	"manual": {
		"hand": [
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
				"name": "mod_counter",
				"tags": ["Card"],
				"counter_name": "immersion",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "immersion_amount"
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
const ThatTooMustPass = {
	"manual": {
		"hand": [
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
				"name": "mod_counter",
				"counter_name": "immersion",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "immersion_amount"
				},
			},
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
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
}
const ItsNotAboutMe = {
	"manual": {
		"hand": {
			"Take Anxiety to Interpret all Torments": [
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
					"name": "modify_damage",
					"subject": "boardseek",
					"amount": {
					"lookup_property": "_amounts",
						"value_key": "damage_amount"
					},
					"subject_count": "all",
					"tags": ["Attack", "Card"],
					"filter_state_seek": [{
						"filter_group": "EnemyEntities",
					},],
				},
			],
			"Interpret single Torment": [
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
			],
		}
	},
}
const Rancor = {
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
				"subject": "boardseek",
				"amount": "per_turn_event_count",
				"tags": ["Attack", "Card"],
				"per_turn_event_count": {
					"event_name": "player_total_damage",
				},
				"subject_count": "all",
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const JustifiedRancor = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"amount": "per_turn_event_count",
				"tags": ["Attack", "Card"],
				"per_turn_event_count": {
					"multiplier": 3,
					"event_name": "player_total_damage",
				},
				"subject_count": "all",
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const LastOut = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.lash_out.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const FrustratedLastOut = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.lash_out.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "frustrated",
			},
		],
	},
}
const IsItMyFault = {
	"manual": {
		"hand": {
			"Take Anxiety to interpret single Torment bypassing perplexity": [
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
					"name": "modify_damage",
					"subject": "target",
					"needs_subject": true,
					"amount": {
					"lookup_property": "_amounts",
						"value_key": "damage_amount"
					},
					"tags": ["Attack", "Unblockable", "Card"],
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
			],
			"Interpret single Torment": [
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
			],
		}
	},
}
const EnoughIsEnough = {
	"manual": {
		"hand": {
			"Take Anxiety to interpret and inflict Doubt on single Torment.": [
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
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"subject": "previous",
					"modification": {
					"lookup_property": "_amounts",
						"value_key": "effect_stacks"
					},
					"filter_state_subject": [{
						"filter_group": "EnemyEntities",
					},],
				},
			],
			"Interpret single Torment": [
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
			],
		}
	},
}
const Grit = {
	"manual": {
		"hand": {
			"Take Anxiety to gain Confidence and Courage.": [
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
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
					"subject": "dreamer",
					"modification": {
					"lookup_property": "_amounts",
						"value_key": "effect_stacks"
					},
				},
			],
			"Gain Confidence": [
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
		}
	},
}
const Excuses = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.excuses.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const EndlessExcuses = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.excuses.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "endless",
			},
		],
	},
}
const Tolerance = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.tolerance.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
						"value_key": "effect_stacks"
					},
			},
		],
	},
}
const ExtremeTolerance = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.tolerance.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
						"value_key": "effect_stacks"
					},
				"upgrade_name": "extreme",
			},
		],
	},
}
const Catatonia = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "healing_amount",
					"default": 0,
					"is_inverted": true,
				},
				"tags": ["Healing", "Card"],
				"filter_damage_percent": {
					"percent": {
					"lookup_property": "_amounts",
					"value_key": "health_percent",
					"default": 0,
				},
					"comparison": "ge",
				},
			},
			{
				"name": "modify_damage",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "healing_amount",
					"default": 0,
					"is_inverted": true,
				},
				"tags": ["Healing", "Card"],
				"subject": "dreamer",
				"filter_encounter_event_count": {
					"event": "player_total_damage_own_turn",
					"filter_count": {
					"lookup_property": "_amounts",
					"value_key": "anxiety_taken",
					"default": 0,
				},
					"comparison": "ge",
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
const Disengage = {
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
}
const SurvivalMode = {
	"manual": {
		"hand": [
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
				"name": "mod_counter",
				"tags": ["Card"],
				"counter_name": "immersion",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "immersion_amount"
				},
				"filter_damage_percent": {
					"percent": {
						"lookup_property": "_amounts",
						"value_key": "health_percent",
						"default": 0,
					},
					"comparison": "ge",
				},
			},
		],
	},
}
const AThousandSqueaks = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"subject_count": "all",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"x_modifier": {
					"lookup_property": "_amounts",
					"value_key": "x_modifer",
					"default": '0',
				},
				"x_operation": "multiply",
				"tags": ["Attack", "Card"],
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"subject": "boardseek",
				"subject_count": "all",
				"modification": 1,
				"x_modifier": {
					"lookup_property": "_amounts",
					"value_key": "x_modifer",
					"default": '0',
				},
				"x_operation": "multiply",
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			}
		],
	},
}
const Hyperfocus = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "defence_amount"
				},
				"x_modifier": {
					"lookup_property": "_amounts",
					"value_key": "x_modifer",
					"default": '0',
				},
				"x_operation": "multiply",
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks",
					"default": '0',
				},
				"x_modifier": {
					"lookup_property": "_amounts",
					"value_key": "x_modifer",
					"default": '0',
				},
				"x_operation": "multiply",
			},
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
				"filter_turn_event_count": {
					"event": "buffer_immersion_gained",
					"filter_count": 1,
					"comparison": "ge",
				},
			},
		],
	},
}
const Misunderstood = {
	"manual": {
		"hand": {
			"Gain Confidence, take Anxiety and shuffle card back into the deck.": [
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
					"dest_container": "deck",
					"tags": ["Played", "Card"],
				},
				{
					"name": "shuffle_container",
					"tags": ["Card"],
					"dest_container": "deck",
				},
			],
			"Gain Confidence": [
				{
					"name": "assign_defence",
					"tags": ["Card"],
					"subject": "dreamer",
					"amount": {
					"lookup_property": "_amounts",
						"value_key": "defence_amount"
					},
				},
				# We add the discard manually, because the card ignores normal discard.
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "discard",
					"tags": ["Played", "Card"],
				},
			],
		}
	},
}
const DeathRay = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"subject_count": "all",
				"tags": ["Attack", "Card"],
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount2"
				},
				"subject_count": "all",
				"tags": ["Attack", "Card"],
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
				"filter_per_tutor_count": {
					"src_container": "deck",
					"subject": "tutor",
					"subject_count": "all",
					"filter_card_count": {
					"lookup_property": "_amounts",
					"value_key": "deck_size",
					"default": 0,
				},
					"comparison": "ge",
				},
			},
		],
	},
}
const Unconventional = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.unconventional.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const WeirdlyUnconventional = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.unconventional.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "weirdly"
			},
		],
	},
}
const EndlessPosibilities = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "deck",
				"tags": ["Played", "Card"],
				"filter_per_tutor_count": {
					"src_container": "deck",
					"subject": "tutor",
					"subject_count": "all",
					"filter_card_count": {
					"lookup_property": "_amounts",
					"value_key": "deck_size",
					"default": 0,
				},
					"comparison": "ge",
				},
			},
			{
				"name": "shuffle_container",
				"tags": ["Card"],
				"dest_container": "deck",
				"filter_per_tutor_count": {
					"src_container": "deck",
					"subject": "tutor",
					"subject_count": "all",
					"filter_card_count": {
					"lookup_property": "_amounts",
					"value_key": "deck_size",
					"default": 0,
				},
					"comparison": "ge",
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks2"
				},
				"filter_per_tutor_count": {
					"src_container": "deck",
					"subject": "tutor",
					"subject_count": "all",
					"filter_card_count": {
					"lookup_property": "_amounts",
					"value_key": "deck_size",
					"default": 0,
				},
					"comparison": "ge",
				},
			},
		],
	},
}
const IllShowThemAll = {
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"dest_container": "discard",
				"subject": "self",
				"tags": ["Played", "Card"],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": 0,
				"store_integer": true,
				"set_to_mod": true,
			},
			{
				"name": "mod_counter",
				"tags": ["Card"],
				"counter_name": "immersion",
				"modification": "retrieve_integer",
				"adjust_retrieved_integer": {
					"lookup_property": "_amounts",
					"value_key": "immersion_amount",
					"default": 0,
				},
				"store_integer": true,
				"is_inverted": true
			},
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": "retrieve_integer",
				"adjust_retrieved_integer": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount",
					"default": 0,
				},
			},

		],
	},
}
const AFineSpecimen = {
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
				"subject": "previous",
				"amount": "per_tutor",
				"tags": ["Attack", "Card"],
				"per_tutor": {
					"src_container": "deck",
					"subject": "tutor",
					"subject_count": "all",
					"multiplier": {
					"lookup_property": "_amounts",
						"value_key": "chain_amount"
					},
					"divider": {
					"lookup_property": "_amounts",
						"value_key": "per_division"
					},
				},
			},
		],
	},
}
const MisplacedResearch = {
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
				"tags": ["Card"],
				"src_container": "discard",
				"dest_container": "deck",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "card_amount"
				},
				"subject": "index",
				"subject_index": "top",
			},
			{
				"name": "shuffle_container",
				"dest_container": "deck",
			},
		],
	},
}
const Excogitate = {
	"manual": {
		"hand": [
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
}
const TheWhippyFlippy = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks1"
				},
				"store_integer": true,
				"filter_intent_stress": {
					"lookup_property": "_amounts",
					"value_key": "stress_threshold1"
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.empower.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks2"
				},
				"store_integer": true,
				"filter_intent_stress": {
					"lookup_property": "_amounts",
					"value_key": "stress_threshold2"
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks3"
				},
				"store_integer": true,
				"filter_intent_stress": {
					"lookup_property": "_amounts",
					"value_key": "stress_threshold3"
				},
			},
		],
	},
}
const ThePlotChickens = {
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
				"name": "nested_script",
				"nested_tasks": [
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
						"name": "apply_effect",
						"tags": ["Card"],
						"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
						"subject": "dreamer",
						"modification": {
							"lookup_property": "_amounts",
							"value_key": "effect_stacks"
						},
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
				},],
			}
		],
	},
}
const AStrangeGaida = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"subject": "boardseek",
				"subject_count": "all",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.marked.name,
				"subject": "boardseek",
				"subject_count": "all",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_state_seek": [{
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
}
const OneWithThePoultry = {
	"manual": {
		"hand": [
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
				"name": "nested_script",
				"nested_tasks": [
					{
						"name": "apply_effect",
						"tags": ["Card"],
						"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
						"subject": "dreamer",
						"modification": {
							"lookup_property": "_amounts",
							"value_key": "effect_stacks"
						},
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
				},],
			}
		],
	},
}
const SneakBeaky = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.sneaky_beaky.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const Sensuous = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"subject": "target",
				"needs_subject": true,
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
				"subject": "dreamer",
				"predict_requires_target": true,
				"modification": "per_effect_stacks",
				"per_effect_stacks": {
					"effect_name": "Confusion",
					"subject": "previous",
					"original_previous": true,
				},
			},
		],
	},
}
const MassiveEggression = {
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
				"value_key": "effect_stacks"
			}
			},
		],
	},
}
const Impugn = {
	"manual": {
		"hand": [
			{
				"name": "null_script",
				"tags": ["Card"],
				"subject": "target",
				"needs_subject": true,
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "modify_damage",
				"subject": "previous",
				"protect_previous": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Unblockable", "Card"],
				"filter_state_subject": [{
					"filter_effects": [
						{
							"filter_effect_name": "Doubt",
							"filter_count": 1,
							"comparison": "ge",
						},
					]
				},],
			},
			{
				"name": "modify_damage",
				"subject": "previous",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_effects": [
						{
							"filter_effect_name": "Doubt",
							"filter_count": 0,
							"comparison": "eq",
						},
					]
				},],
			},
		],
	},
}
const Unshakeable = {
	"manual": {
		"hand": [
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
}
const ConfidentlyUnshakeable = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": 0,
				"set_to_mod": true,
			},
			{
				"name": "assign_defence",
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "defence_amount"
				},
			}
		],
	},
}
const Tenacity = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.tenacity.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const DoggedTenacity = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.tenacity.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "dogged",
			},
		],
	},
}
const TheFinger = {
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_dreamer_defence": {
					"lookup_property": "_amounts",
					"value_key": "requirements_amount"
				},
				"comparison": "le",
			},
		],
	},
}
const BringIt = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"subject_count": "all",
				"tags": ["Attack", "Card"],
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.advantage.name,
				"subject": "boardseek",
				"sort_by": "random",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const Sanguine = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "defence_amount"
				},
				"x_modifier": {
					"lookup_property": "_amounts",
					"value_key": "x_modifer",
					"default": '0',
				},
				"x_operation": "multiply",
			}
		],
	},
}
const Launch = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"x_modifier": {
					"lookup_property": "_amounts",
					"value_key": "x_modifer",
					"default": 0,
				},
				"x_operation": "multiply",
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
				"subject": "boardseek",
				"subject_count": "all",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks2"
				},
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
				"filter_x_usage": {
					"filter_count": {
					"lookup_property": "_amounts",
					"value_key": "x_requirement"
				},
				},
			}

		],
	},
}
const Swoop = {
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
				"repeat": "per_effect_stacks",
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
				"per_effect_stacks": {
					"effect_name": "Untouchable",
					"subject": "dreamer",
					"modifier": {
					"lookup_property": "_amounts",
						"value_key": "per_modifier",
						"default": 0,
					},
					"multiplier": {
					"lookup_property": "_amounts",
						"value_key": "per_multiplier",
						"default": 1,
					},
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
				"subject": "dreamer",
				"modification": 0,
				"set_to_mod": true
			},
		],
	},
}
const PanickedTakeoff = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.panicked_takeoff.name,
				"subject": "dreamer",
				"modification": 1,
			},
		],
	},
}
const WildlyPanickedTakeoff = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.panicked_takeoff.name,
				"subject": "dreamer",
				"modification": 1,
				"upgrade_name": "wildly",
			},
		],
	},
}
const AChickOfTheLight = {
	"manual": {
		"hand": [
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_intent_stress": {
					"lookup_property": "_amounts",
					"value_key": "stress_amount"
				},
			}
		],
	},
}
const NearGroundFlight = {
	"manual": {
		"hand": [
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
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"filter_damage_percent": {
					"percent": {
						"lookup_property": "_amounts",
						"value_key": "health_percent",
						"default": 0,
					},
					"comparison": "le",
				},
			},
		],
	},
}

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
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
		"Find Weakness": FindWeakness,
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
		"Careful Observation": CarefulObservation,
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
		"Enough is enough!": EnoughIsEnough,
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
		"Panicked Takeoff": PanickedTakeoff,
		"Wildly Panicked Takeoff": WildlyPanickedTakeoff,
		"A Chick of the Light": AChickOfTheLight,
		"Near-ground Flight": NearGroundFlight,
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
		"dest_container": "forgotten",
		"tags": ["Played", "Card"],
	}
	var script_name := card_name
	var break_loop := false
	var special_destination = null
	if not all_scripts.has(card_name):
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
	lookup_script_property(ret_script, card_name)
	return(ret_script)


# This function will go through all the dictionaries in the card scripts
# and look for dictionaries with a key lookup_property
# This signifies a value that needs to be looked up from the card itself
# So we do that and replace the value in that dictionary with the looked up value.
# This allows us to tweak the values of scripts from the card definitions
# and thus have only one adjustment point
func lookup_script_property(script: Dictionary, card_name: String) -> void:
	for key in script:
		if typeof(script[key]) == TYPE_DICTIONARY:
			if script[key].has("lookup_property"):
				var lookup = script[key].duplicate()
				var lookup_property = lookup.get("lookup_property")
				var value_key = lookup.get("value_key")
				var default_value = lookup.get("default")
				var value = cfc.card_definitions[card_name]\
						.get(lookup_property, {}).get(value_key, default_value)
				if lookup.get("is_inverted"):
					value *= -1
				script[key] = value
			else:
				lookup_script_property(script[key], card_name)
		elif typeof(script[key]) == TYPE_ARRAY:
			for task in script[key]:
				if typeof(task) == TYPE_DICTIONARY:
					lookup_script_property(task, card_name)


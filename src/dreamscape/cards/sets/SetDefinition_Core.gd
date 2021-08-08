#class_name CoreDefinitions
extends Reference

const SET = "Core Set"
const CARDS := {
	"Confidence": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 5
		},
		"_upgrade_threshold": 5,
		"_upgrades": [
			"Solid Confidence",
			"Easy Confidence",
			"Ephemeral Confidence",
		],
	},
	"Solid Confidence": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8
		},
		"_is_upgrade": true,
	},
	"Easy Confidence": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 4
		},
		"_is_upgrade": true,
	},
	"Ephemeral Confidence": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}. {release}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_keywords": ["confidence","release"],
		"_avoid_normal_discard": true,
		"_amounts": {
			"defence_amount": 10
		},
		"_is_upgrade": true,
	},
	"Interpretation": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6
		},
		"_upgrade_threshold": 5,
		"_upgrades": [
			"Solid Interpretation",
			"Easy Interpretation",
			"Ephemeral Interpretation",
		],
	},
	"Easy Interpretation": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5
		},
		"_is_upgrade": true,
	},
	"Solid Interpretation": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9
		},
		"_is_upgrade": true,
	},
	"Ephemeral Interpretation": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. {release}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_keywords": ["interpretation","release"],
		"_avoid_normal_discard": true,
		"_amounts": {
			"damage_amount": 12
		},
		"_is_upgrade": true,
	},
	"Out of Reach": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Gain {effect_stacks} {untouchable}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 1
		},
		"_upgrade_threshold": 6,
		"_upgrades": [
			"Easy Out of Reach",
			"Enhanced Out of Reach",
		],
	},
	"Easy Out of Reach": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Gain {effect_stacks} {untouchable}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 1
		},
		"_is_upgrade": true,
	},
	"Enhanced Out of Reach": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Gain {effect_stacks} {untouchable}",
		"Cost": 5,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 2
		},
		"_is_upgrade": true,
	},
	"Dive-in": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "Gain {effect_stacks} {shaken}\nYour next {damage} is doubled.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.PLAYER
		},
		"_keywords": ["interpretation"],
		"_amounts": {
			"effect_stacks": 2
		},
		"_upgrade_threshold": 7,
		"_upgrades": [
			"Powerful Dive-in",
			"Enhanced Dive-in",
		],
	},
	"Enhanced Dive-in": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "Gain {effect_stacks} {shaken}\nYour next {damage} is doubled.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.PLAYER
		},
		"_keywords": ["interpretation"],
		"_amounts": {
			"effect_stacks": 1
		},
		"_is_upgrade": true,
	},
	"Powerful Dive-in": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "Gain {effect_stacks} {shaken}\nYour next {damage} is tripled.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.PLAYER
		},
		"_keywords": ["interpretation"],
		"_amounts": {
			"effect_stacks": 3
		},
		"_is_upgrade": true,
	},
	"Safety of Air": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "{relax} for {healing_amount}. {forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 4
		},
		"_upgrade_threshold": 8,
		"_upgrades": [
			"Solid Safety of Air",
			"Sustained Safety of Air",
			"Easy Safety of Air",
		],
	},
	"Solid Safety of Air": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "{relax} for {healing_amount}. {forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 7
		},
		"_is_upgrade": true,
	},
	"Easy Safety of Air": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "{relax} for {healing_amount}. {forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 4
		},
		"_is_upgrade": true,
	},
	"Sustained Safety of Air": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "{relax} for {healing_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": [],
		"_amounts": {
			"healing_amount": 4
		},
		"_is_upgrade": true,
	},
	"Nothing to Fear": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.risky.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 1 {immersion} at the start of each turn.\n"\
			+ " Increase all {stress} taken from Torment intents by 2.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["stress"],
		"_upgrade_threshold": 5,
		"_upgrades": [
			"Easy Nothing to Fear",
			"Tough Nothing to Fear",
		],
	},
	"Easy Nothing to Fear": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.risky.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 1 {immersion} at the start of each turn.\n"\
			+ " Increase all {stress} taken from Torment intents by 2.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["stress"],
		"_is_upgrade": true,
	},
	"Tough Nothing to Fear": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.risky.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 1 {immersion} at the start of each turn.\n"\
			+ " Increase all {stress} taken from Torment intents by 1.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["stress"],
		"_is_upgrade": true,
	},
	"Confounding Movements": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {confusion} to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 9,
			"effect_stacks": 1,
		},
		"_upgrade_threshold": 7,
		"_upgrades": [
			"Solid Confounding Movements",
			"Enhanced Confounding Movements",
		],
	},
	"Solid Confounding Movements": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {confusion} to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 14,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Enhanced Confounding Movements": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {confusion} to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 10,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Noisy Whip": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {confusion}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
			"effect_stacks": 1,
		},
		"_upgrade_threshold": 6,
		"_upgrades": [
			"Solid Noisy Whip",
			"Easy Noisy Whip",
			"Enhanced Noisy Whip",
		],
	},
	"Easy Noisy Whip": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {confusion}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Solid Noisy Whip": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {confusion}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Enhanced Noisy Whip": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {effect_stacks} {confusion}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Inner Justice": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_amounts": {
			"immersion_amount": 4,
		},
		"_upgrade_threshold": 6,
		"_upgrades": [
			"Easy Inner Justice",
			"Solid Inner Justice",
			"Fleeting Inner Justice",
		],
	},
	"Easy Inner Justice": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_amounts": {
			"immersion_amount": 3,
		},
		"_is_upgrade": true,
	},
	"Solid Inner Justice": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion}",
		"Cost": 4,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_amounts": {
			"immersion_amount": 7,
		},
		"_is_upgrade": true,
	},
	"Fleeting Inner Justice": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {immersion_amount} {immersion}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Starting",
		"_amounts": {
			"immersion_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Whirlwind": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for 3. Repeat 3 times",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"]
	},
	"Overview": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Remove all {defence} from target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["perplexity"]
	},
	"War Paint": { #TODO
		"Type": "Control",
		"Tags": [],
		"Abilities": "All {damage} is increased by 1 this turn.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"]
	},
	"Rubber Eggs": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, {damage} a random Torment with {confusion} for 6.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"]
	},
	"The Joke": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Target a Torment. If it doesn't have {confusion} Apply 3 {confusion}"\
			+ " If it has {confusion}, {damage} 10.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"]
	},
	"Nunclucks": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Increase your {damage} by 1 for each stack of {confusion} on the Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Rare",
		"_keywords": ["interpretation"]
	},
	"Gummiraptor": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for 10.\n"\
			+ "Repeat this if Torments are not going to be inflicting any {stress} this turn.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "stress"]
	},
	"Cocky Retort": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain 8 {confidence}\n Draw a card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence"]
	},
	"Rapid Encirclement": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Apply 2 {shaken} to all Torments.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"Barrel Through": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for 8.\nIf the Torment has {shaken}, {damage} all other Torments for 12.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"]
	},
	"Intimidate": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply 2 {doubt} to all Torments",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"Cheeky Approach": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Gain 10 {confidence}\nApply 3 {doubt} to target Torment.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["confidence"]
	},
	"Laugh at Danger": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "After a Torment performs {stress}, it gains 1 {doubt}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Rare",
		"_keywords": ["stress"]
	},
	"Towering Presence": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} equal to your current {confidence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"]
	},
	"Unassailable": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply {doubt}, gain 1 {confidence}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"]
	},
	"Audacity": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain 8 {confidence}\nApply 1 {courage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["confidence"]
	},
	"Boast": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Double your {confidence}\nRemove all {courage} {forget}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_keywords": ["confidence", "forget"]
	},
	"Solid Understanding": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Gain 5 {confidence}\n{damage} for 5.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"]
	},
	"No Second Thoughts": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain 2 {courage}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
	},
	"High Morale": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for 6.\nDraw a {courage} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"]
	},
	"Confident Slap": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Apply 5 {doubt} to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"Swoop": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for 8. If you have {untouchable}, {damage} for 12 instead.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"]
	},
	"Drag and Drop": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "{damage} for 10. If Torment is {overcome}, gain 1 {untouchable}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation", "overcome"]
	},
	"Running Start": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "{damage} for 5.\nDraw a {untouchable} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"]
	},
	"Master of Skies": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Whenever you gain {untouchable}, Gain 1 {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Rare",
	},
	"Zen of Flight": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "At the end of each turn, {relax} 1.\nIf you have {untouchable}, {relax} 1 extra.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Rare",
	},
	"Loop de loop": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain 7 {confidence}\nGain 1 {fascination}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["confidence"]
	},
	"Headless": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain 4 {fascination}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Common",
	},
	"Utterly Ridiculous": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Can only be played if there's a total of 6 or more {confusion} among Torments\n"\
				+ "{damage} all Torments for 20",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"]
	},
	"Ventriloquism": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for 8.\nDraw a {confusion} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"]
	},
	"unnamed_card_1": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{shuffle} your discard pile into your deck.\nPlay a Random card from your deck. {forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"]
	},
	"unnamed_card_2": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Each Torment is applied {doubt} equals to its {confusion} x2",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
	},
	"unnamed_card_3": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments for 8",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"]
	},
	"Absurdity Unleashed": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply {confusion} to a Torment, {damage} it for 4",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"]
	},
	"Dread": {
		"Type": "Perturbation",
		"Tags": [],
		"Abilities": "{release}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Temporary",
		"_keywords": ["release"]
	},
	"unnamed_card_4": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fading.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain 11 {confidence}. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Common",
		"_keywords": ["confidence", "forget"]
	},
	"Change of Mind": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}. {shuffle} this card into your deck.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
		},
		"_upgrade_threshold": 6,
		"_upgrades": [
			"Solid Change of Mind",
			"Easy Change of Mind",
		],
	},
	"Solid Change of Mind": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}. {shuffle} this card into your deck.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 11,
		},
		"_is_upgrade": true,
	},
	"Easy Change of Mind": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}. {shuffle} this card into your deck.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
		},
		"_is_upgrade": true,
	},
	"Brilliance": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you {shuffle} your deck, gain 4 {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"]
	},
	"Rapid Theorizing": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain 8 {confidence}.\n"\
				+ "If you've {shuffled} your deck this turn, gain 3 {confidence} and draw a card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"]
	},
	"Wild Inspiration": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "{forget} the top card of the deck: Gain 1 {immersion}. Draw 2 cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"]
	},
	"Recall": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "At the end of your turn, {shuffle} the top card from the discard pile into the deck.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"unnamed_card_5": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for 10. You may {discard} two cards from your hand to {shuffle} this card into your deck.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"It's alive!": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for 12.\n{damage} for 2 for each time your deck was shuffled.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"]
	},
	"Detect Weaknesses": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "{damage} for 9. If you've shuffled your deck this turn, apply 2 {vulnerable}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"]
	},
	"Eureka!": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain 1 {buffer} every other time you shuffle your deck.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": []
	},
}

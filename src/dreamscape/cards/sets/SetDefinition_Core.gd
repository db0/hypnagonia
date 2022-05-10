#class_name CoreDefinitions
extends Reference

"""
The key "_amount_purpose_map" is used to map _amount keys that apply effects
to the exact effect each of them is meant to modify. It is not used by
the scripting engine, but rather for things like artifacts which modify
amounts for specific effects, to be able to target the right amount
It is generally only needed for cards which apply multiple effect types at the
same time
"""

const SET = "Core Set"
const CARDS := {
	"Confidence": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}",
		"Cost": 1,
		"_illustration": "Sebastian Piszczatowski",
		"_rarity": "Basic",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 5
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Confidence +",
			"@ Confidence @",
			"- Confidence -",
		],
	},
	"+ Confidence +": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}",
		"Cost": 1,
		"_illustration": "Sebastian Piszczatowski",
		"_rarity": "Basic",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8
		},
		"_is_upgrade": true,
	},
	"@ Confidence @": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}",
		"Cost": 0,
		"_illustration": "Sebastian Piszczatowski",
		"_rarity": "Basic",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 4
		},
		"_is_upgrade": true,
	},
	"- Confidence -": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}. {release}",
		"Cost": 1,
		"_illustration": "Sebastian Piszczatowski",
		"_rarity": "Basic",
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
		"_illustration": "Cabbage",
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Interpretation +",
			"@ Interpretation @",
			"- Interpretation -",
		],
	},
	"@ Interpretation @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5
		},
		"_is_upgrade": true,
	},
	"+ Interpretation +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9
		},
		"_is_upgrade": true,
	},
	"- Interpretation -": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. {release}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Basic",
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
		"Abilities": "Gain {effect_stacks} {impervious}.",
		"Cost": 2,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Basic",
		"_amounts": {
			"effect_stacks": 3
		},
		"_upgrade_threshold_modifier": 1,
		"_upgrades": [
			"@ Out of Reach @",
			"* Out of Reach *",
		],
	},
	"@ Out of Reach @": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Gain {effect_stacks} {impervious}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Basic",
		"_amounts": {
			"effect_stacks": 3
		},
		"_is_upgrade": true,
	},
	"* Out of Reach *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Gain {effect_stacks} {impervious}.",
		"Cost": 2,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Basic",
		"_amounts": {
			"effect_stacks": 6
		},
		"_is_upgrade": true,
	},
	"Dive-in": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "Gain {effect_stacks} {shaken}\nGain {effect_stacks2} {advantage}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.PLAYER
		},
		"_keywords": ["interpretation"],
		"_amounts": {
			"effect_stacks": 2,
			"effect_stacks2": 1
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.vulnerable.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.advantage.name,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Dive-in *",
			"Enhanced Dive-in",
		],
	},
	"Enhanced Dive-in": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "Gain {effect_stacks} {shaken}\nGain {effect_stacks2} {advantage}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.PLAYER
		},
		"_keywords": ["interpretation"],
		"_amounts": {
			"effect_stacks": 1,
			"effect_stacks2": 1
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.vulnerable.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.advantage.name,
		},
		"_is_upgrade": true,
	},
	"* Dive-in *": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "Gain {effect_stacks} {shaken}\nGain {effect_stacks2} {advantage}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.PLAYER
		},
		"_keywords": ["interpretation"],
		"_amounts": {
			"effect_stacks": 3,
			"effect_stacks2": 3
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.vulnerable.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.advantage.name,
		},
		"_is_upgrade": true,
	},
	"Safety of Air": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{relax} for {healing_amount}. {forget}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 4
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Safety of Air +",
			"Sustained Safety of Air",
			"@ Safety of Air @",
		],
	},
	"+ Safety of Air +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{relax} for {healing_amount}. {forget}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 7
		},
		"_is_upgrade": true,
	},
	"@ Safety of Air @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{relax} for {healing_amount}. {forget}.",
		"Cost": 0,
		"_illustration": "SkylarkGSH",
		"_rarity": "Uncommon",
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
		"_illustration": "SkylarkGSH",
		"_rarity": "Uncommon",
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
		"_illustration": "SkylarkGSH",
		"_rarity": "Basic",
		"_keywords": ["stress"],
		"_upgrade_threshold_modifier": +3,
		"_upgrades": [
			"@ Nothing to Fear @",
			"Absolutely Nothing to Fear",
		],
	},
	"@ Nothing to Fear @": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.risky.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 1 {immersion} at the start of each turn.\n"\
			+ " Increase all {stress} taken from Torment intents by 2.",
		"Cost": 0,
		"_illustration": "SkylarkGSH",
		"_rarity": "Basic",
		"_keywords": ["stress"],
		"_is_upgrade": true,
	},
	"Absolutely Nothing to Fear": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.risky.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 1 {immersion} at the start of each turn.\n"\
			+ " Increase all {stress} taken from Torment intents by 1.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Basic",
		"_keywords": ["stress"],
		"_is_upgrade": true,
	},
	"Confounding Movements": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {confusion} to target Torment.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Confounding Movements +",
			"* Confounding Movements *",
		],
	},
	"+ Confounding Movements +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {confusion} to target Torment.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 11,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"* Confounding Movements *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {confusion} to target Torment.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 9,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Noisy Whip": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {effect_stacks} {confusion}",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Noisy Whip +",
			"@ Noisy Whip @",
			"* Noisy Whip *",
			"- Noisy Whip -",
		],
	},
	"@ Noisy Whip @": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {effect_stacks} {confusion}",
		"Cost": 0,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 4,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"+ Noisy Whip +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {effect_stacks} {confusion}",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"* Noisy Whip *": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {effect_stacks} {confusion}",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"- Noisy Whip -": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "{damage} for {damage_amount}.\nApply {effect_stacks} {confusion}\n{release}",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Basic",
		"_keywords": ["interpretation","release"],
		"_amounts": {
			"damage_amount": 10,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Inner Justice": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.once_off.name, Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion}. Take {exert_amount} {anxiety}",
		"Cost": 3,
		"_illustration": "Cabbage",
		"_rarity": "Basic",
		"_amounts": {
			"immersion_amount": 4,
			"exert_amount": 2,
		},
		"_upgrade_threshold_modifier": +5,
		"_upgrades": [
			"@ Inner Justice @",
			"+ Inner Justice +",
			"~ Inner Justice ~",
		],
	},
	"@ Inner Justice @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.once_off.name, Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion}. Take {exert_amount} {anxiety}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_amounts": {
			"immersion_amount": 3,
			"exert_amount": 2,
		},
		"_is_upgrade": true,
	},
	"+ Inner Justice +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.once_off.name, Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion}. Take {exert_amount} {anxiety}",
		"Cost": 4,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_amounts": {
			"immersion_amount": 6,
			"exert_amount": 2,
		},
		"_is_upgrade": true,
	},
	"~ Inner Justice ~": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.once_off.name, Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {immersion_amount} {immersion}. Take {exert_amount} {anxiety}\n{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_amounts": {
			"immersion_amount": 2,
			"exert_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Whirlwind": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 2,
			"chain_amount": 5,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Whirlwind +",
			"= Whirlwind =",
		],
	},
	"+ Whirlwind +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 4,
			"chain_amount": 4,
		},
		"_is_upgrade": true,
	},
	"= Whirlwind =": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 2,
			"chain_amount": 8,
		},
		"_is_upgrade": true,
	},
	"Overview": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Remove all {defence} from target Torment.",
		"Cost": 0,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_keywords": ["perplexity"],
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Ω Overview Ω",
			"Piercing Overview",
		],
	},
	"Ω Overview Ω": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Remove all {defence} from target Torment.",
		"Cost": 0,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_keywords": ["perplexity"],
		"_is_upgrade": true,
	},
	"Piercing Overview": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "Remove all {defence} from target Torment and apply {effect_stacks} Shaken",
		"Cost": 0,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_keywords": ["perplexity"],
		"_amounts": {
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
	},
	"War Paint": { #TODO
		"Type": "Control",
		"Tags": [],
		"Abilities": "All {damage} is increased by 1 this turn.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
	},
	"Rubber Eggs": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, {damage} a random Torment with {confusion} for {concentration_damage}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"concentration_damage": 6,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Rubber Eggs @",
			"Bouncy Rubber Eggs",
			"Hard Rubber Eggs",
		],
	},
	"@ Rubber Eggs @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, {damage} a random Torment with {confusion} for {concentration_damage}.",
		"Cost": 0,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_amounts": {
			"concentration_damage": 6,
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_is_upgrade": true,
	},
	"Hard Rubber Eggs": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, {damage} a random Torment with {confusion} for {concentration_damage}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_amounts": {
			"concentration_damage": 9,
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_is_upgrade": true,
	},
	"Bouncy Rubber Eggs": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, {damage} all Torments with {confusion} for {concentration_damage}.",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_amounts": {
			"concentration_damage": 6,
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_is_upgrade": true,
	},
	"The Joke": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Target a Torment. If it doesn't have {confusion} Apply {effect_stacks} {confusion}"\
			+ " If it has {confusion}, {damage} for {damage_amount}.",
		"Cost": 2,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 15,
			"effect_stacks": 4,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* The Joke *",
			"+ The Joke +",
			"= The Joke =",
		],

	},
	"* The Joke *": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Target a Torment. If it doesn't have {confusion} Apply {effect_stacks} {confusion}"\
			+ " If it has {confusion}, {damage} for {damage_amount}.",
		"Cost": 2,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 14,
			"effect_stacks": 7,
		},
		"_is_upgrade": true,
		"_reuse_script": "The Joke",
	},
	"+ The Joke +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Target a Torment. If it doesn't have {confusion} Apply {effect_stacks} {confusion}"\
			+ " If it has {confusion}, {damage} for {damage_amount}.",
		"Cost": 2,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 22,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
		"_reuse_script": "The Joke",
	},
	"= The Joke =": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Target a Torment. If it doesn't have {confusion} Apply {effect_stacks} {confusion}"\
			+ " If it has {confusion}, {damage} for {damage_amount}.",
		"Cost": 2,
		"_illustration": "SkylarkGSH",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 18,
			"effect_stacks": 5,
		},
		"_is_upgrade": true,
		"_reuse_script": "The Joke",
	},
	"Nunclucks": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Increase your {damage} by {concentration_damage} for each stack of {confusion} on the Torment.",
		"Cost": 1,
		"_illustration": "axilirate",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"concentration_damage": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Nunclucks @",
			"Massive Nunclucks",
		],
	},
	"@ Nunclucks @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Increase your {damage} by {concentration_damage} for each stack of {confusion} on the Torment.",
		"Cost": 0,
		"_illustration": "axilirate",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"concentration_damage": 1,
		},
		"_is_upgrade": true,
	},
	"Massive Nunclucks": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Increase your {damage} by {concentration_damage} for each stack of {confusion} on the Torment.",
		"Cost": 1,
		"_illustration": "axilirate",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"concentration_damage": 2,
		},
		"_is_upgrade": true,
	},
	"Find Weakness": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
			+ "Repeat this if no Torment is going to be inflicting more than {max_requirements_amount} {stress} this turn.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "stress"],
		"_amounts": {
			"damage_amount": 15,
			"max_requirements_amount": 0,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Find Weakness @",
			"+ Find Weakness +",
			"% Find Weakness %",
		],
	},
	"@ Find Weakness @": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
			+ "Repeat this if no Torment is going to be inflicting more than {max_requirements_amount} {stress} this turn.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "stress"],
		"_amounts": {
			"damage_amount": 14,
			"max_requirements_amount": 0,
		},
		"_is_upgrade": true,
	},
	"+ Find Weakness +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
			+ "Repeat this if no Torment is going to be inflicting more than {max_requirements_amount} {stress} this turn.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "stress"],
		"_amounts": {
			"damage_amount": 19,
			"max_requirements_amount": 0,
		},
		"_is_upgrade": true,
	},
	"% Find Weakness %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
			+ "Repeat this if no Torment is going to be inflicting more than {max_requirements_amount} {stress} this turn.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "stress"],
		"_amounts": {
			"damage_amount": 15,
			"max_requirements_amount": 5,
		},
		"_is_upgrade": true,
	},
	"Cocky Retort": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain {defence_amount} {confidence}\n Draw {draw_amount} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"draw_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Cocky Retort +",
			"! Cocky Retort !",
		],
	},
	"+ Cocky Retort +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain {defence_amount} {confidence}\n Draw {draw_amount} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 12,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"! Cocky Retort !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain {defence_amount} {confidence}\n Draw {draw_amount} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Rapid Encirclement": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "Apply {effect_stacks} {shaken} to all Torments.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Rapid Encirclement *",
			"~ Rapid Encirclement ~",
		],
	},
	"* Rapid Encirclement *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "Apply {effect_stacks} {shaken} to all Torments.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"~ Rapid Encirclement ~": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "Apply {effect_stacks} {shaken} to all Torments. {forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 7,
		},
		"_is_upgrade": true,
	},
	"Barrel Through": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\nIf the Torment has {shaken}, "\
				+ "{damage} all other Torments for {damage_amount2}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"damage_amount2": 12,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Barrel Through +",
			"= Barrel Through =",
		],
	},
	"+ Barrel Through +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\nIf the Torment has {shaken}, "\
				+ "{damage} all other Torments for {damage_amount2}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 12,
			"damage_amount2": 12,
		},
		"_is_upgrade": true,
	},
	"= Barrel Through =": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\nIf the Torment has {shaken}, "\
				+ "{damage} all other Torments for {damage_amount2}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 15,
			"damage_amount2": 8,
		},
		"_is_upgrade": true,
	},
	"Intimidate": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {doubt} to all Torments",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Intimidate @",
			"* Intimidate *",
		],
	},
	"@ Intimidate @": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {doubt} to all Torments",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"* Intimidate *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {doubt} to all Torments",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Cheeky Approach": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {doubt} to target Torment.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 10,
			"effect_stacks": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"= Cheeky Approach =",
			"+ Cheeky Approach +",
			"* Cheeky Approach *",
		],
	},
	"= Cheeky Approach =": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {doubt} to target Torment.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 12,
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"+ Cheeky Approach +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {doubt} to target Torment.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 18,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"* Cheeky Approach *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {doubt} to target Torment.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 7,
			"effect_stacks": 6,
		},
		"_is_upgrade": true,
	},
	"Laugh at Danger": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "After a Torment performs {stress}, it gains {concentration_stacks} {doubt}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Rare",
		"_keywords": ["stress"],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Laugh at Danger @",
			"Roaring Laugh at Danger",
		],
	},
	"@ Laugh at Danger @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "After a Torment performs {stress}, it gains {concentration_stacks} {doubt}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Rare",
		"_keywords": ["stress"],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Roaring Laugh at Danger": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "After a Torment performs {stress}, it gains {concentration_stacks} {doubt}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Rare",
		"_keywords": ["stress"],
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Towering Presence": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} equal to your current {confidence}",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"],
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Towering Presence @",
			"Overwhelming Presence",
		],
		"_difficulty_cost_adjustment": {
			"permanent_defence": {
				true: 3
			}
		}
	},
	"@ Towering Presence @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} equal to your current {confidence}",
		"Cost": 0,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"],
		"_is_upgrade": true,
		"_difficulty_cost_adjustment": {
			"permanent_defence": {
				true: 3
			}
		}
	},
	"Overwhelming Presence": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} equal to your current {confidence} + {damage_amount}",
		"Cost": 1,
		"_illustration": "SkylarkGSH",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"],
		"_amounts": {
			"damage_amount": 6,
		},
		"_is_upgrade": true,
		"_difficulty_cost_adjustment": {
			"permanent_defence": {
				true: 3
			}
		}
	},
	"Unassailable": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply {doubt}, gain {concentration_defence} {confidence}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Unassailable @",
			"Completely Unassailable",
		],
	},
	"@ Unassailable @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply {doubt}, gain {concentration_defence} {confidence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 2,
		},
		"_is_upgrade": true,
	},
	"Completely Unassailable": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply {doubt}, gain {concentration_defence} {confidence}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 4,
		},
		"_is_upgrade": true,
	},
	"Audacity": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {courage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Audacity +",
			"* Audacity *",
		],
	},
	"+ Audacity +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {courage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 12,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"* Audacity *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nApply {effect_stacks} {courage}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 17,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Boast": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Double your {confidence}\nRemove all {courage}\n{forget}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_keywords": ["confidence", "forget"],
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Massive Boast",
			"@ Boast @",
			"Sustained Boast",
		],
	},
	"@ Boast @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Double your {confidence}\nRemove all {courage}\n{forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_keywords": ["confidence", "forget"],
		"_is_upgrade": true,
	},
	"Massive Boast": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain 4 {confidence}\nDouble your {confidence}\nRemove all {courage}\n{forget}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_keywords": ["confidence", "forget"],
		"_amounts": {
			"defence_amount": 4,
		},
		"_is_upgrade": true,
	},
	"Sustained Boast": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Double your {confidence}\nRemove all {courage}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_is_upgrade": true,
	},
	"Solid Understanding": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}\n{damage} for {damage_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"],
		"_amounts": {
			"defence_amount": 5,
			"damage_amount": 5,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Solid Understanding +",
			"= Solid Understanding =",
			"% Solid Understanding %",
		],
	},
	"+ Solid Understanding +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}\n{damage} for {damage_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"],
		"_amounts": {
			"defence_amount": 5,
			"damage_amount": 9,
		},
		"_is_upgrade": true,
	},
	"% Solid Understanding %": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}\n{damage} for {damage_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"],
		"_amounts": {
			"defence_amount": 9,
			"damage_amount": 5,
		},
		"_is_upgrade": true,
	},
	"= Solid Understanding =": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}\n{damage} for {damage_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "interpretation"],
		"_amounts": {
			"defence_amount": 7,
			"damage_amount": 7,
		},
		"_is_upgrade": true,
	},
	"No Second Thoughts": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {effect_stacks} {courage}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"effect_stacks": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ No Second Thoughts @",
			"~ No Second Thoughts ~",
		],
	},
	"@ No Second Thoughts @": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {effect_stacks} {courage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"~ No Second Thoughts ~": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {effect_stacks} {courage}\n{forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"High Morale": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {courage} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 7,
			"draw_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ High Morale +",
			"! High Morale !",
		],
	},
	"+ High Morale +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {courage} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 10,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"! High Morale !": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {courage} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 7,
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Confident Slap": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {doubt} to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 5,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Confident Slap *",
			"@ Confident Slap @",
		],
	},
	"* Confident Slap *": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {doubt} to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 6,
		},
		"_is_upgrade": true,
	},
	"@ Confident Slap @": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {doubt} to target Torment.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"Careful Observation": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. If you have {untouchable}, {damage} for {damage_amount2} instead.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"damage_amount2": 12,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Careful Observation +",
			"% Careful Observation %",
		],
	},
	"+ Careful Observation +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. If you have {untouchable}, {damage} for {damage_amount2} instead.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 12,
			"damage_amount2": 16,
		},
		"_is_upgrade": true,
	},
	"% Careful Observation %": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. If you have {untouchable}, {damage} for {damage_amount2} instead.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"damage_amount2": 20,
		},
		"_is_upgrade": true,
	},
	"Drag and Drop": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "{damage} for {damage_amount}. If Torment is {overcome}, gain {effect_stacks} {untouchable}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation", "overcome"],
		"_amounts": {
			"damage_amount": 12,
			"effect_stacks": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Drag and Drop +",
			"@ Drag and Drop @",
		],
	},
	"+ Drag and Drop +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "{damage} for {damage_amount}. If Torment is {overcome}, gain {effect_stacks} {untouchable}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation", "overcome"],
		"_amounts": {
			"damage_amount": 16,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"@ Drag and Drop @": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "{damage} for {damage_amount}. If Torment is {overcome}, gain {effect_stacks} {untouchable}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation", "overcome"],
		"_amounts": {
			"damage_amount": 11,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Running Start": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {untouchable} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
			"draw_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Running Start +",
			"! Running Start !",
			"@ Running Start @",
		],
	},
	"+ Running Start +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {untouchable} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 10,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"! Running Start !": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {untouchable} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"@ Running Start @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {untouchable} card.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 4,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Master of Skies": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Whenever you gain {untouchable}, Gain {concentration_stacks} {buffer}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Glorious Master of Skies",
			"@ Master of Skies @",
		],
	},
	"@ Master of Skies @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Whenever you gain {untouchable}, Gain {concentration_stacks} {buffer}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Glorious Master of Skies": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Whenever you gain {untouchable}, Gain {concentration_stacks} {buffer}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Zen of Flight": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "At the end of the next {turns_amount} turns, {relax} for {concentration_healing}.\n"\
				+ "If you have {untouchable}, {relax} {concentration_healing} extra.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"turns_amount": 6,
			"concentration_healing": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Masterful Zen of Flight",
			"@ Zen of Flight @",
		],
	},
	"@ Zen of Flight @": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "At the end of the next {turns_amount} turns, {relax} for {concentration_healing}.\n"\
				+ "If you have {untouchable}, {relax} {concentration_healing} extra.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"turns_amount": 6,
			"concentration_healing": 1,
		},
		"_is_upgrade": true,
	},
	"Masterful Zen of Flight": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "At the end of the next {turns_amount} turns, {relax} for {concentration_healing}.\n"\
				+ "If you have {untouchable}, {relax} {concentration_healing} extra.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"turns_amount": 6,
			"concentration_healing": 2,
		},
		"_is_upgrade": true,
	},
	"Loop de loop": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fascination}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"effect_stacks": 1,
			"defence_amount": 7,
		},
		"_upgrade_threshold_modifier": 5,
		"_upgrades": [
			"+ Loop de loop +",
			"* Loop de loop *",
		],
	},
	"+ Loop de loop +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fascination}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"effect_stacks": 1,
			"defence_amount": 11,
		},
		"_is_upgrade": true,
	},
	"* Loop de loop *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fascination}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"effect_stacks": 2,
			"defence_amount": 7,
		},
		"_is_upgrade": true,
	},
	"Mania": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {effect_stacks} {fascination}",
		"Cost": 2,
		"_illustration": "Maria Thoukydidou",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"effect_stacks": 4,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Mania @",
			"* Mania *",
			"% Mania %",
		],
	},
	"@ Mania @": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {effect_stacks} {fascination}",
		"Cost": 0,
		"_illustration": "Maria Thoukydidou",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"* Mania *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {effect_stacks} {fascination}",
		"Cost": 2,
		"_illustration": "Maria Thoukydidou",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"effect_stacks": 6,
		},
		"_is_upgrade": true,
	},
	"% Mania %": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {effect_stacks} {fascination}",
		"Cost": 3,
		"_illustration": "Maria Thoukydidou",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"effect_stacks": 10,
		},
		"_is_upgrade": true,
	},
	"Utterly Ridiculous": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Can only be played if there's a total of {filter_amount} or more {confusion} among Torments\n"\
				+ "{damage} all Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 20,
			"filter_amount": 6,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Utterly Ridiculous @",
			"+ Utterly Ridiculous +",
			"% Utterly Ridiculous %",
			"= Utterly Ridiculous =",
		],
	},
	"@ Utterly Ridiculous @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Can only be played if there's a total of {filter_amount} or more {confusion} among Torments\n"\
				+ "{damage} all Torments for {damage_amount}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 20,
			"filter_amount": 6,
		},
		"_is_upgrade": true,
	},
	"+ Utterly Ridiculous +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Can only be played if there's a total of {filter_amount} or more {confusion} among Torments\n"\
				+ "{damage} all Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 26,
			"filter_amount": 6,
		},
		"_is_upgrade": true,
	},
	"% Utterly Ridiculous %": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Can only be played if there's a total of {filter_amount} or more {confusion} among Torments\n"\
				+ "{damage} all Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 20,
			"filter_amount": 4,
		},
		"_is_upgrade": true,
	},
	"= Utterly Ridiculous =": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Can only be played if there's a total of {filter_amount} or more {confusion} among Torments\n"\
				+ "{damage} all Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 40,
			"filter_amount": 10,
		},
		"_is_upgrade": true,
	},
	"Ventriloquism": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {confusion} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"draw_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Ventriloquism @",
			"+ Ventriloquism +",
			"! Ventriloquism !",
		],
	},
	"@ Ventriloquism @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {confusion} card.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"+ Ventriloquism +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {confusion} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 11,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"! Ventriloquism !": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {confusion} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Blind Trial": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{shuffle} your discard pile into your draw pile.\nPlay {draw_amount} Random card from your draw pile. {forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 1
		},
		"_upgrade_threshold_modifier": 3,
		"_upgrades": [
			"@ Blind Trial @",
			"! Blind Trial !",
			"Sustained Blind Trial",
		],
	},
	"@ Blind Trial @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{shuffle} your discard pile into your draw pile.\nPlay {draw_amount} Random card from your draw pile. {forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 1
		},
		"_is_upgrade": true,
	},
	"! Blind Trial !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{shuffle} your discard pile into your draw pile.\nPlay {draw_amount} Random card from your draw pile. {forget}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 2
		},
		"_is_upgrade": true,
	},
	"Sustained Blind Trial": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{shuffle} your discard pile into your draw pile.\nPlay {draw_amount} Random card from your draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": [],
		"_amounts": {
			"draw_amount": 1
		},
		"_is_upgrade": true,
	},
	"Fowl Language": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Each Torment is applied {doubt} equals to its {confusion}x{multiplier_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"multiplier_amount": 2
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Fowl Language @",
			"* Fowl Language *",
			"% Fowl Language %",
		],
	},
	"@ Fowl Language @": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Each Torment is applied {doubt} equals to its {confusion}x{multiplier_amount}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"multiplier_amount": 2
		},
		"_is_upgrade": true,
	},
	"* Fowl Language *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Each Torment is applied {doubt} equals to its {confusion}x{multiplier_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"multiplier_amount": 3
		},
		"_is_upgrade": true,
	},
	"% Fowl Language %": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Each Torment is applied {doubt} equals to its ({confusion}+1)x{multiplier_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_amounts": {
			"multiplier_amount": 2
		},
		"_is_upgrade": true,
	},
	"Cockfighting": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Cockfighting +",
			"~ Cockfighting ~",
		],
	},
	"+ Cockfighting +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 11
		},
		"_is_upgrade": true,
	},
	"~ Cockfighting ~": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{damage} all Torments for {damage_amount}.\n{forget}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "forget"],
		"_amounts": {
			"damage_amount": 18
		},
		"_is_upgrade": true,
	},
	"Absurdity Unleashed": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply {confusion} to a Torment, {damage} it for {concentration_damage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"concentration_damage": 4
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Absurdity Unleashed @",
			"^ Absurdity Unleashed ^",
			"Total Absurdity Unleashed",
		],
	},
	"@ Absurdity Unleashed @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply {confusion} to a Torment, {damage} it for {concentration_damage}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"concentration_damage": 4
		},
		"_is_upgrade": true,
	},
	"^ Absurdity Unleashed ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Whenever you apply {confusion} to a Torment, {damage} it for {concentration_damage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"concentration_damage": 4
		},
		"_is_upgrade": true,
	},
	"Total Absurdity Unleashed": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply {confusion} to a Torment, {damage} it for {concentration_damage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"concentration_damage": 6
		},
		"_is_upgrade": true,
	},
	# Not yet assigned to an archetype
	"Change of Mind": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}. {shuffle} this card into your draw pile.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_avoid_normal_discard": true,
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Change of Mind +",
			"@ Change of Mind @",
		],
	},
	"+ Change of Mind +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}. {shuffle} this card into your draw pile.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_avoid_normal_discard": true,
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9,
		},
		"_is_upgrade": true,
	},
	"@ Change of Mind @": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}. {shuffle} this card into your draw pile.",
		"Cost": 0,
		"_illustration": "Maria Thoukydidou",
		"_avoid_normal_discard": true,
		"_rarity": "Basic",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 4,
		},
		"_is_upgrade": true,
	},
	"Brilliance": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you {shuffle} your draw pile, gain {concentration_defence} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 4,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Blinding Brilliance",
			"@ Brilliance @",
			"^ Brilliance ^",
		],
	},
	"@ Brilliance @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you {shuffle} your draw pile, gain {concentration_defence} {confidence}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 4,
		},
		"_is_upgrade": true,
	},
	"^ Brilliance ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Whenever you {shuffle} your draw pile, gain {concentration_defence} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 4,
		},
		"_is_upgrade": true,
	},
	"Blinding Brilliance": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you {shuffle} your draw pile, gain {concentration_defence} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 6,
		},
		"_is_upgrade": true,
	},
	"Rapid Theorizing": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain {defence_amount} {confidence}.\n"\
				+ "If you've {shuffle}d your draw pile this turn, "\
				+ "gain {defence_amount2} {confidence} and draw {draw_amount} card.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"defence_amount2": 3,
			"draw_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Rapid Theorizing +",
			"! Rapid Theorizing !",
			"% Rapid Theorizing %",
		],
	},
	"+ Rapid Theorizing +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain {defence_amount} {confidence}.\n"\
				+ "If you've {shuffle}d your draw pile this turn, "\
				+ "gain {defence_amount2} {confidence} and draw {draw_amount} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 12,
			"defence_amount2": 3,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"! Rapid Theorizing !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain {defence_amount} {confidence}.\n"\
				+ "If you've {shuffle}d your draw pile this turn, "\
				+ "gain {defence_amount2} {confidence} and draw {draw_amount} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 9,
			"defence_amount2": 3,
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"% Rapid Theorizing %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain {defence_amount} {confidence}.\n"\
				+ "If you've {shuffle}d your draw pile this turn, "\
				+ "gain {defence_amount2} {confidence} and draw {draw_amount} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_avoid_normal_discard": true,
		"_amounts": {
			"defence_amount": 6,
			"defence_amount2": 11,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Wild Inspiration": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.slumber.name,
			Terms.GENERIC_TAGS.purpose.name,
			Terms.GENERIC_TAGS.swift.name
		],
		"Abilities": "{forget} the top {forget_amount} card of the draw pile: Gain {immersion_amount} {immersion}. Draw {draw_amount} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"immersion_amount": 1,
			"draw_amount": 2,
			"forget_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Wild Inspiration +",
			"! Wild Inspiration !",
		],
	},
	"+ Wild Inspiration +": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.slumber.name,
			Terms.GENERIC_TAGS.purpose.name,
			Terms.GENERIC_TAGS.swift.name
		],

		"Abilities": "{forget} the top {forget_amount} card of the draw pile: Gain {immersion_amount} {immersion}. Draw {draw_amount} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"immersion_amount": 2,
			"draw_amount": 3,
			"forget_amount": 2,
		},
		"_is_upgrade": true,
	},
	"! Wild Inspiration !": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.slumber.name,
			Terms.GENERIC_TAGS.purpose.name,
			Terms.GENERIC_TAGS.swift.name
		],

		"Abilities": "{forget} the top {forget_amount} card of the draw pile: Gain {immersion_amount} {immersion}. Draw {draw_amount} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"immersion_amount": 1,
			"draw_amount": 3,
			"forget_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Recall": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "At the end of your turn, {shuffle} the top {concentration_cards} card "\
				+ "from the discard pile into the draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_amounts": {
			"concentration_cards": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Total Recall",
			"^ Recall ^",
			"@ Recall @",
		],
	},
	"^ Recall ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "At the end of your turn, {shuffle} the top {concentration_cards} card "\
				+ "from the discard pile into the draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_amounts": {
			"concentration_cards": 1,
		},
		"_is_upgrade": true,
	},
	"@ Recall @": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "At the end of your turn, {shuffle} the top {concentration_cards} card "\
				+ "from the discard pile into the draw pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_amounts": {
			"concentration_cards": 1,
		},
		"_is_upgrade": true,
	},
	"Total Recall": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "At the end of your turn, {shuffle} the top {concentration_cards} cards "\
				+ "from the discard pile into the draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_amounts": {
			"concentration_cards": 2,
		},
		"_is_upgrade": true,
	},
	"Vexing Concept": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "{damage} for {damage_amount}. You may {discard} {discard_amount} cards from your hand "\
				+ "to {shuffle} this card into your draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_amounts": {
			"damage_amount": 9,
			"discard_amount": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Vexing Concept +",
			"! Vexing Concept !",
		],
	},
	"+ Vexing Concept +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "{damage} for {damage_amount}. You may {discard} {discard_amount} cards from your hand "\
				+ "to {shuffle} this card into your draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_amounts": {
			"damage_amount": 12,
			"discard_amount": 2,
		},
		"_is_upgrade": true,
	},
	"! Vexing Concept !": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "{damage} for {damage_amount}. You may {discard} {discard_amount} card from your hand "\
				+ "to {shuffle} this card into your draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_amounts": {
			"damage_amount": 10,
			"discard_amount": 1,
		},
		"_is_upgrade": true,
	},
	"It's alive!": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "{damage} for {damage_amount2} for each time your draw pile was shuffled.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 12,
			"damage_amount2": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ It's alive! +",
			"= It's alive! =",
		],
	},
	"+ It's alive! +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "{damage} for {damage_amount2} for each time your draw pile was shuffled.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 16,
			"damage_amount2": 2,
		},
		"_is_upgrade": true,
	},
	"= It's alive! =": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "{damage} for {damage_amount2} for each time your draw pile was shuffled.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 14,
			"damage_amount2": 3,
		},
		"_is_upgrade": true,
	},
	"Detect Weaknesses": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you've shuffled your draw pile this turn, apply {effect_stacks} {vulnerable}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9,
			"effect_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Detect Weaknesses +",
			"* Detect Weaknesses *",
		],
	},
	"+ Detect Weaknesses +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you've shuffled your draw pile this turn, apply {effect_stacks} {vulnerable}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 13,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"* Detect Weaknesses *": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you've shuffled your draw pile this turn, apply {effect_stacks} {vulnerable}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 10,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Eureka!": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {concentration_stacks} {buffer} every other time you shuffle your draw pile.",
		"Cost": 2,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Eureka! @",
			"Inspired Eureka!",
			"^ Eureka! ^",
		],
	},
	"@ Eureka! @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {concentration_stacks} {buffer} every other time you shuffle your draw pile.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"^ Eureka! ^": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Gain {concentration_stacks} {buffer} every other time you shuffle your draw pile.",
		"Cost": 2,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Inspired Eureka!": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {concentration_stacks} {buffer} every other time you shuffle your draw pile.",
		"Cost": 2,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Flashbacks": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Draw {draw_amount} card. It costs 0 {immersion} until played. {forget}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! Flashbacks !",
			"Painful Flashbacks",
		],
	},
	"! Flashbacks !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Draw {draw_amount} cards. They costs 0 {immersion} until played. {forget}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Painful Flashbacks": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name,Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}.\nDraw {draw_amount} card. It costs 0 {immersion} until played.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_amounts": {
			"draw_amount": 1,
			"exert_amount": 3,
		},
		"_is_upgrade": true,
	},
	"Perseverance": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {immersion_amount} {immersion}\nGain {effect_stacks} {drain}\n{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.drain.name: Terms.PLAYER
		},
		"_amounts": {
			"immersion_amount": 3,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Improved Perseverance",
			"+ Perseverance +",
		],
	},
	"Improved Perseverance": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain {immersion_amount} {immersion}\nDraw {draw_amount} card\nGain {effect_stacks} {drain}\n{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.drain.name: Terms.PLAYER
		},
		"_amounts": {
			"immersion_amount": 3,
			"effect_stacks": 1,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"+ Perseverance +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {immersion_amount} {immersion}\nGain {effect_stacks} {drain}\n{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.drain.name: Terms.PLAYER
		},
		"_amounts": {
			"immersion_amount": 4,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"It's The Small Things": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you have gained extra {immersion} this turn, {damage} for {damage_amount2} extra.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 7,
			"damage_amount2": 5,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"% It's The Small Things %",
			"+ It's The Small Things +",
		],
	},
	"+ It's The Small Things +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you have gained extra {immersion} this turn, {damage} for {damage_amount2} extra.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"damage_amount2": 7,
		},
		"_is_upgrade": true,
	},
	"% It's The Small Things %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "If you have gained extra {immersion} this turn, {damage} for {damage_amount2}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 0,
			"damage_amount2": 20,
		},
		"_is_upgrade": true,
	},
	"Confrontation": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for X * {damage_amount}.",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Confrontation @",
			"+ Confrontation +",
		],
	},
	"@ Confrontation @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for (X + 1) * {damage_amount}.",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
			"x_modifer": "+1",
		},
		"_is_upgrade": true,
	},
	"+ Confrontation +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for X * {damage_amount}.",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9,
		},
		"_is_upgrade": true,
	},
	"Dodge": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Gain {effect_stacks} {untouchable}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Dancing Dodge",
			"* Dodge *",
		],
	},
	"Dancing Dodge": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name,Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain {effect_stacks} {untouchable}. Draw {draw_amount} card.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 1,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"* Dodge *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Gain {effect_stacks} {untouchable}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
		"_amounts": {
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Introspection": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "At the end of the next {turns_amount} turns where you have not played "\
				+ "any {attack_card} cards, {relax} for {concentration_healing}.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_keywords": ["interpretation"],
		"_rarity": "Uncommon",
		"_amounts": {
			"turns_amount": 4,
			"concentration_healing": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Deep Introspection",
			"Light Introspection",
		],
	},
	"Deep Introspection": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "At the end of the next {turns_amount} turns where you have not played any {attack_card} cards, {relax} for {concentration_healing}.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Uncommon",
		"_amounts": {
			"turns_amount": 3,
			"concentration_healing": 3,
		},
		"_is_upgrade": true,
	},
	"Light Introspection": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "At the end of the next {turns_amount} turns where you have not played more than 1 {attack_card} card, {relax} for {concentration_healing}",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Uncommon",
		"_amounts": {
			"turns_amount": 4,
			"concentration_healing": 2,
		},
		"_is_upgrade": true,
	},
	"Dismissal": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\nGain {defence_amount} {defence}",
		"Cost": 0,
		"_illustration": "Cabbage",
		"_rarity": "Common",
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"exert_amount": 3,
			"defence_amount": 14
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Dismissal +",
			"% Dismissal %",
		],
	},
	"+ Dismissal +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\nGain {defence_amount} {defence}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"exert_amount": 3,
			"defence_amount": 17
		},
		"_is_upgrade": true,
	},
	"% Dismissal %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\nGain {defence_amount} {defence}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"exert_amount": 6,
			"defence_amount": 25
		},
		"_is_upgrade": true,
	},
	"Could Be Worse": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\n{damage} for {damage_amount}.",
		"Cost": 0,
		"_illustration": "Cabbage",
		"_rarity": "Common",
		"_keywords": ["interpretation", "anxiety"],
		"_amounts": {
			"exert_amount": 3,
			"damage_amount": 15,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Could Be Worse +",
			"% Could Be Worse %",
		],
	},
	"+ Could Be Worse +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\n{damage} for {damage_amount}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "anxiety"],
		"_amounts": {
			"exert_amount": 3,
			"damage_amount": 19,
		},
		"_is_upgrade": true,
	},
	"% Could Be Worse %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\n{damage} for {damage_amount}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "anxiety"],
		"_amounts": {
			"exert_amount": 2,
			"damage_amount": 17,
		},
		"_is_upgrade": true,
	},
	"The Happy Place": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "Whenever you take {anxiety} during your turn, gain {concentration_stacks} {armor}",
		"Cost": 1,
		"_illustration": "Cabbage",
		"_keywords": ["anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ The Happy Place @",
			"^ The Happy Place ^",
		],
	},
	"@ The Happy Place @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "Whenever you take {anxiety} during your turn, gain {concentration_stacks} {armor}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_keywords": ["anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"^ The Happy Place ^": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name,Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Whenever you take {anxiety} during your turn, gain {concentration_stacks} {armor}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER
		},
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Self-Deception": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Take {exert_amount} {anxiety}\nDraw {draw_amount} {exert} card.\n"\
				+ "Draw {draw_amount2} card.",
		"Cost": 0,
		"_illustration": "Cabbage",
		"_rarity": "Uncommon",
		"_keywords": ["anxiety"],
		"_amounts": {
			"exert_amount": 3,
			"draw_amount": 1,
			"draw_amount2": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! Self-Deception !",
			"% Self-Deception %",
		],
	},
	"! Self-Deception !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Take {exert_amount} {anxiety}\nDraw {draw_amount} {exert} card.\n"\
				+ "Draw {draw_amount2} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["anxiety"],
		"_amounts": {
			"exert_amount": 4,
			"draw_amount": 1,
			"draw_amount2": 2,
		},
		"_is_upgrade": true,
	},
	"% Self-Deception %": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Draw {draw_amount2} {exert} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["anxiety"],
		"_amounts": {
			"exert_amount": 0,
			"draw_amount": 0,
			"draw_amount2": 2,
		},
		"_is_upgrade": true,
	},
	"That too, shall pass": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\nGain {immersion_amount} {immersion}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["anxiety"],
		"_amounts": {
			"exert_amount": 3,
			"immersion_amount": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"% That too, shall pass %",
			"+ That too, shall pass +",
			"That too, must pass",
		],
	},
	"% That too, shall pass %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\nGain {immersion_amount} {immersion}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_keywords": ["anxiety"],
		"_rarity": "Uncommon",
		"_amounts": {
			"exert_amount": 5,
			"immersion_amount": 5,
		},
		"_is_upgrade": true,
	},
	"+ That too, shall pass +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\nGain {immersion_amount} {immersion}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_keywords": ["anxiety"],
		"_rarity": "Uncommon",
		"_amounts": {
			"exert_amount": 3,
			"immersion_amount": 3,
		},
		"_is_upgrade": true,
	},
	"That too, must pass": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.purpose.name,
			Terms.GENERIC_TAGS.exert.name,
			Terms.GENERIC_TAGS.swift.name
		],
		"Abilities": "Take {exert_amount} {anxiety}\nGain {immersion_amount} {immersion}.\nDraw {draw_amount} card",
		"Cost": 0,
		"_illustration": "Nobody",
		"_keywords": ["anxiety"],
		"_rarity": "Uncommon",
		"_amounts": {
			"exert_amount": 4,
			"immersion_amount": 3,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Rancor": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "{damage} all Torments by the amount of {anxiety} you've taken in your turn during this ordeal.",
		"Cost": 1,
		"_illustration": "Cabbage",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "anxiety"],
		"_amounts": {
			"damage_amount": 8,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Rancor +",
			"Justified Rancor",
		],
	},
	"+ Rancor +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "{damage} all Torments by the amount of {anxiety} you've taken in your turn during this ordeal.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "anxiety"],
		"_amounts": {
			"damage_amount": 11,
		},
		"_is_upgrade": true,
	},
	"Justified Rancor": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} all Torments by triple the amount of {anxiety} you've taken in your turn during this ordeal.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "anxiety"],
		"_is_upgrade": true,
	},
	"Lash-out": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "After you take {anxiety} during your turn, {damage} a random Torment for triple that amount.",
		"Cost": 1,
		"_illustration": "Cabbage",
		"_keywords": ["interpretation", "anxiety"],
		"_rarity": "Uncommon",
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Lash-out @",
			"^ Lash-out ^",
			"Frustrated Lash-out",
		],
	},
	"@ Lash-out @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "After you take {anxiety} during your turn, {damage} a random Torment for triple that amount.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_keywords": ["interpretation", "anxiety"],
		"_rarity": "Uncommon",
		"_is_upgrade": true,
	},
	"^ Lash-out ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "After you take {anxiety} during your turn, {damage} a random Torment for triple that amount.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["interpretation", "anxiety"],
		"_rarity": "Uncommon",
		"_is_upgrade": true,
	},
	"Frustrated Lash-out": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "After you take {anxiety} during your turn, {damage} a random Torment for quintuple that amount.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_keywords": ["interpretation", "anxiety"],
		"_rarity": "Uncommon",
		"_is_upgrade": true,
	},
	"It's not about me": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "You may take {exert_amount} {anxiety} to {damage} all other Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "anxiety"],
		"_amounts": {
			"damage_amount": 10,
			"exert_amount": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ It's not about me +",
			"% It's not about me %",
		],
	},
	"+ It's not about me +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "You may take {exert_amount} {anxiety} to {damage} all other Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "anxiety"],
		"_amounts": {
			"damage_amount": 13,
			"exert_amount": 3,
		},
		"_is_upgrade": true,
	},
	"% It's not about me %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "You may take {exert_amount} {anxiety} to {damage} all other Torments for {damage_amount}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "anxiety"],
		"_amounts": {
			"damage_amount": 10,
			"exert_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Is it my fault?": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.protection.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you've taken at least {anxiety_taken} on your turn during this ordeal "\
				+ "{pierce} and gain {effect_stacks} {protection}",
		"Cost": 1,
		"_illustration": "Cabbage",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "pierce", "anxiety"],
		"_amounts": {
			"damage_amount": 11,
			"anxiety_taken": 5,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Is it my fault? +",
			"% Is it my fault? %",
		],
	},
	"+ Is it my fault? +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.protection.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you've taken at least {anxiety_taken} on your turn during this ordeal "\
				+ "{pierce} and gain {effect_stacks} {protection}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "pierce", "anxiety"],
		"_amounts": {
			"damage_amount": 14,
			"anxiety_taken": 5,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"% Is it my fault? %": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.protection.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you've taken at least {anxiety_taken} on your turn during this ordeal "\
				+ "{pierce} and gain {effect_stacks} {protection}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "pierce", "anxiety"],
		"_amounts": {
			"damage_amount": 12,
			"anxiety_taken": 2,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Enough is enough!": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "You may take {exert_amount} {anxiety} to inflict {effect_stacks} {poison}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_amounts": {
			"damage_amount": 9,
			"exert_amount": 2,
			"effect_stacks": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Enough is enough! +",
			"* Enough is enough! *",
		],
	},
	"+ Enough is enough! +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "You may take {exert_amount} {anxiety} to inflict {effect_stacks} {poison}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_amounts": {
			"damage_amount": 12,
			"exert_amount": 2,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"* Enough is enough! *": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "You may take {exert_amount} {anxiety} to inflict {effect_stacks} {poison}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_amounts": {
			"damage_amount": 10,
			"exert_amount": 4,
			"effect_stacks": 6,
		},
		"_is_upgrade": true,
	},
	"Grit": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {defence}\n"\
				+ "You may take {exert_amount} {anxiety} to gain {effect_stacks} {fortify}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_amounts": {
			"exert_amount": 4,
			"defence_amount": 10,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Grit +",
			"% Grit %",
		],
	},
	"+ Grit +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {defence}\n"\
				+ "You may take {exert_amount} {anxiety} to gain {effect_stacks} {fortify}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_amounts": {
			"exert_amount": 4,
			"defence_amount": 13,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"% Grit %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {defence}\n"\
				+ "You may take {exert_amount} {anxiety} to gain {effect_stacks} {fortify}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "anxiety"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_amounts": {
			"exert_amount": 7,
			"defence_amount": 14,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Excuses": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "The first {concentration_threshold} time you take {anxiety} during your turn reduce it to 1.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["anxiety"],
		"_amounts": {
			"concentration_threshold": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Excuses @",
			"Endless Excuses",
		],
	},
	"@ Excuses @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "The first {concentration_threshold} time you take {anxiety} during your turn reduce it to 1.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["anxiety"],
		"_amounts": {
			"concentration_threshold": 1,
		},
		"_is_upgrade": true,
	},
	"Endless Excuses": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "The first {concentration_threshold} times you take {anxiety} during your turn reduce it to 1.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["anxiety"],
		"_amounts": {
			"concentration_threshold": 2,
		},
		"_is_upgrade": true,
	},
	"Tolerance": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "The next {concentration_threshold} time your {anxiety} would reach its maximum, "\
				+ "you take no {anxiety}, gain {concentration_special} {immersion} and draw {concentration_special} card.",
		"Cost": 1,
		"_illustration": "Cabbage",
		"_rarity": "Rare",
		"_keywords": ["anxiety"],
		"_amounts": {
			"concentration_threshold": 1,
			"concentration_special": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Tolerance *",
			"Extreme Tolerance",
		],
	},
	"* Tolerance *": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "The next {concentration_threshold} times your {anxiety} would reach its maximum, "\
				+ "you take no {anxiety}, gain {concentration_special} {immersion} and draw {concentration_special} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["anxiety"],
		"_amounts": {
			"concentration_threshold": 2,
			"concentration_special": 1,
		},
		"_is_upgrade": true,
	},
	"Extreme Tolerance": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "The next {concentration_threshold} time your {anxiety} would reach its maximum, "\
				+ "you take no {anxiety}, gain {concentration_special} {immersion} and draw {concentration_special} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["anxiety"],
		"_amounts": {
			"concentration_threshold": 1,
			"concentration_special": 2,
		},
		"_is_upgrade": true,
	},
	"Catatonia": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "If your {anxiety} is at least {health_percent}% full, {relax} for {healing_amount}.\n"\
				+ "If you have taken at least {anxiety_taken} {anxiety} during your turn during "\
				+ "this Ordeal, {relax} for {healing_amount}.\n{forget}",
		"Cost": 1,
		"_illustration": "Cabbage",
		"_rarity": "Rare",
		"_keywords": ["forget", "anxiety"],
		"_amounts": {
			"healing_amount": 10,
			"health_percent": 70,
			"anxiety_taken": 10,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Catatonia +",
			"% Catatonia %",
		],
	},
	"+ Catatonia +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "If your {anxiety} is at least {health_percent}% full, {relax} for {healing_amount}.\n"\
				+ "If you have taken at least {anxiety_taken} {anxiety} during your turn during "\
				+ "this Ordeal, {relax} for {healing_amount}.\n{forget}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["forget", "anxiety"],
		"_amounts": {
			"healing_amount": 15,
			"health_percent": 70,
			"anxiety_taken": 10,
		},
		"_is_upgrade": true,
	},
	"% Catatonia %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "If your {anxiety} is at least {health_percent}% full, {relax} for {healing_amount}.\n"\
				+ "If you have taken at least {anxiety_taken} {anxiety} during your turn during "\
				+ "this Ordeal, {relax} for {healing_amount}.\n{forget}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["forget", "anxiety"],
		"_amounts": {
			"healing_amount": 12,
			"health_percent": 60,
			"anxiety_taken": 8,
		},
		"_is_upgrade": true,
	},
	"Disengage": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}\nGain {defence_amount} {defence}",
		"Cost": 4,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation","confidence"],
		"_amounts": {
			"damage_amount": 25,
			"defence_amount": 25,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Disengage +",
			"@ Disengage @",
			"- Disengage -",
		],
	},
	"+ Disengage +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}\nGain {defence_amount} {defence}",
		"Cost": 4,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation","confidence"],
		"_amounts": {
			"damage_amount": 34,
			"defence_amount": 34,
		},
		"_is_upgrade": true,
	},
	"- Disengage -": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}\nGain {defence_amount} {defence}\n{release}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation","confidence","release"],
		"_amounts": {
			"damage_amount": 25,
			"defence_amount": 25,
		},
		"_is_upgrade": true,
	},
	"@ Disengage @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}\nGain {defence_amount} {defence}",
		"Cost": 5,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation","confidence"],
		"_amounts": {
			"damage_amount": 50,
			"defence_amount": 50,
		},
		"_is_upgrade": true,
	},
	"Survival Mode": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If your {anxiety} is at least {health_percent}% full, gain {immersion_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"immersion_amount": 1,
			"defence_amount": 14,
			"health_percent": 70,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Survival Mode +",
			"= Survival Mode =",
			"% Survival Mode %",
		],
	},
	"+ Survival Mode +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If your {anxiety} is at least {health_percent}% full, gain {immersion_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"immersion_amount": 1,
			"defence_amount": 18,
			"health_percent": 70,
		},
		"_is_upgrade": true,
	},
	"= Survival Mode =": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If your {anxiety} is at least {health_percent}% full, gain {immersion_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"immersion_amount": 1,
			"defence_amount": 17,
			"health_percent": 60,
		},
		"_is_upgrade": true,
	},
	"% Survival Mode %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If your {anxiety} is at least {health_percent}% full, gain {immersion_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"immersion_amount": 2,
			"defence_amount": 17,
			"health_percent": 80,
		},
		"_is_upgrade": true,
	},
	"A Thousand Squeaks": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments for X * {damage_amount}\n"\
				+ "All Torments gain X {confusion}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_amounts": {
			"damage_amount": 4,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ A Thousand Squeaks +",
			"@ A Thousand Squeaks @",
		],
	},
	"+ A Thousand Squeaks +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments for X * {damage_amount}\n"\
				+ "All Torments gain X {confusion}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_amounts": {
			"damage_amount": 6,
		},
		"_is_upgrade": true,
	},
	"@ A Thousand Squeaks @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments for (X + 1) * {damage_amount}\n"\
				+ "All Torments gain (X + 1) {confusion}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_amounts": {
			"damage_amount": 4,
			"x_modifer": "+1",
		},
		"_is_upgrade": true,
	},
	"Hyperfocus": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain X * {defence_amount} {confidence}\n"\
				+ "Gain X * {effect_stacks} {buffer}\n"\
				+ "If you gained immersion through {buffer} this turn. {forget}.",
		"Cost": 'X',
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"defence_amount": 3,
			"effect_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Hyperfocus +",
			"* Hyperfocus *",
		],
	},
	"+ Hyperfocus +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain X * {defence_amount} {confidence}\n"\
				+ "Gain X * {effect_stacks} {buffer}\n"\
				+ "If you gained immersion through {buffer} this turn. {forget}.",
		"Cost": 'X',
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"defence_amount": 5,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"* Hyperfocus *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain X * {defence_amount} {confidence}\n"\
				+ "Gain X * {effect_stacks} {buffer}\n"\
				+ "If you gained immersion through {buffer} this turn. {forget}.",
		"Cost": 'X',
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"defence_amount": 3,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Misunderstood": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "You may take {exert_amount} {anxiety} "\
				+ "to {shuffle} this card into your draw pile.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_avoid_normal_discard": true,
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"exert_amount": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Misunderstood +",
			"% Misunderstood %",
		],
	},
	"+ Misunderstood +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "You may take {exert_amount} {anxiety} "\
				+ "to {shuffle} this card into your draw pile.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_avoid_normal_discard": true,
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 11,
			"exert_amount": 2,
		},
		"_is_upgrade": true,
	},
	"% Misunderstood %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "You may take {exert_amount} {anxiety} "\
				+ "to {shuffle} this card into your draw pile.",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_avoid_normal_discard": true,
		"_rarity": "Common",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 13,
			"exert_amount": 5,
		},
		"_is_upgrade": true,
	},
	"Death Ray": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} all Torments for {damage_amount}.\n"\
				+ "If your draw pile currently has at least {deck_size} cards, "\
				+ "{damage} all Torments for {damage_amount2}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 15,
			"damage_amount2": 15,
			"deck_size": 10,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Death Ray +",
			"% Death Ray %",
			"= Death Ray =",
		],
	},
	"+ Death Ray +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} all Torments for {damage_amount}.\n"\
				+ "If your draw pile currently has at least {deck_size} cards, "\
				+ "{damage} all Torments for {damage_amount2}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 22,
			"damage_amount2": 15,
			"deck_size": 10,
		},
		"_is_upgrade": true,
	},
	"% Death Ray %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} all Torments for {damage_amount}.\n"\
				+ "If your draw pile currently has at least {deck_size} cards, "\
				+ "{damage} all Torments for {damage_amount2}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 15,
			"damage_amount2": 25,
			"deck_size": 10,
		},
		"_is_upgrade": true,
	},
	"= Death Ray =": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} all Torments for {damage_amount}.\n"\
				+ "If your draw pile currently has at least {deck_size} cards, "\
				+ "{damage} all Torments for {damage_amount2}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 19,
			"damage_amount2": 19,
			"deck_size": 8,
		},
		"_is_upgrade": true,
	},
	"Unconventional": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, "\
				+ "if your discard pile has at most {concentration_threshold} cards, "\
				+ "gain {concentration_defence} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 3,
			"concentration_threshold": 5,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Weirdly Unconventional",
			"@ Unconventional @",
		],
	},
	"Weirdly Unconventional": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, "\
				+ "if your discard pile has at most {concentration_threshold} cards, "\
				+ "gain {concentration_defence} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 4,
			"concentration_threshold": 6,
		},
		"_is_upgrade": true,
	},
	"@ Unconventional @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, "\
				+ "if your discard pile has at most {concentration_threshold} cards, "\
				+ "gain {concentration_defence} {confidence}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 3,
			"concentration_threshold": 5,
		},
		"_is_upgrade": true,
	},
	"Endless Posibilities": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.spark.name, 
			Terms.ACTIVE_EFFECTS.armor.name,
			Terms.ACTIVE_EFFECTS.buffer.name
		],
		"Abilities": "Gain {effect_stacks} {armor}.\n"\
				+ "If your draw pile currently has at least {deck_size} cards, "\
				+ "shuffle this card back into the draw pile and gain {effect_stacks2} {buffer}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 4,
			"effect_stacks2": 2,
			"deck_size": 9,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.armor.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.buffer.name,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Endless Posibilities +",
			"* Endless Posibilities *",
			"% Endless Posibilities %",
		],
	},
	"+ Endless Posibilities +": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.spark.name, 
			Terms.ACTIVE_EFFECTS.armor.name,
			Terms.ACTIVE_EFFECTS.buffer.name
		],

		"Abilities": "Gain {effect_stacks} {armor}.\n"\
				+ "If your draw pile currently has at least {deck_size} cards, "\
				+ "shuffle this card back into the draw pile and gain {effect_stacks2} {buffer}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 5,
			"effect_stacks2": 2,
			"deck_size": 9,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.armor.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.buffer.name,
		},
		"_is_upgrade": true,
	},
	"* Endless Posibilities *": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.spark.name, 
			Terms.ACTIVE_EFFECTS.armor.name,
			Terms.ACTIVE_EFFECTS.buffer.name
		],

		"Abilities": "Gain {effect_stacks} {armor}.\n"\
				+ "If your draw pile currently has at least {deck_size} cards, "\
				+ "shuffle this card back into the draw pile and gain {effect_stacks2} {buffer}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 4,
			"effect_stacks2": 3,
			"deck_size": 9,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.armor.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.buffer.name,
		},
		"_is_upgrade": true,
	},
	"% Endless Posibilities %": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.spark.name, 
			Terms.ACTIVE_EFFECTS.armor.name,
			Terms.ACTIVE_EFFECTS.buffer.name
		],

		"Abilities": "Gain {effect_stacks} {armor}.\n"\
				+ "If your draw pile currently has at least {deck_size} cards, "\
				+ "shuffle this card back into the draw pile and gain {effect_stacks2} {buffer}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 5,
			"effect_stacks2": 3,
			"deck_size": 15,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.armor.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.buffer.name,
		},
		"_is_upgrade": true,
	},
	"I'll Show Them All": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.once_off.name, Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Remove all {buffer}: Gain that much {immersion} "\
				+ "and draw that many cards + {draw_amount}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"draw_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! I'll Show Them All !",
			"@ I'll Show Them All @",
		],
	},
	"! I'll Show Them All !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.once_off.name, Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Remove all {buffer}: Gain that much {immersion} "\
				+ "and draw that many cards + {draw_amount}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"@ I'll Show Them All @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.once_off.name, Terms.GENERIC_TAGS.purpose.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Remove all {buffer}: Gain that much {immersion} + {immersion_amount} "\
				+ "and draw that many cards + 1.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_amounts": {
			# It is 0 here, becuase immersion will adjust the stored integer + 1
			"draw_amount": 0,
			"immersion_amount": 1,
		},
		"_is_upgrade": true,
	},
	"A Fine Specimen": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "{damage} for {chain_amount} for every {detrimental_float} cards currently in your draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 7,
			"chain_amount": 1,
			"detrimental_float": 5.0,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ A Fine Specimen +",
			"% A Fine Specimen %",
		],
	},
	"+ A Fine Specimen +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "{damage} for {chain_amount} for every {detrimental_float} cards currently in your draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 10,
			"chain_amount": 1,
			"detrimental_float": 5.0,
		},
		"_is_upgrade": true,
	},
	"% A Fine Specimen %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "{damage} for {chain_amount} for every {detrimental_float} cards currently in your draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 7,
			"chain_amount": 2,
			"detrimental_float": 4.0,
		},
		"_is_upgrade": true,
	},
	"Misplaced Research": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Shuffle the top {card_amount} card of the discard pile into the draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9,
			"card_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Misplaced Research +",
			"! Misplaced Research !",
		],
	},
	"+ Misplaced Research +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Shuffle the top {card_amount} card of the discard pile into the draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 12,
			"card_amount": 1,
		},
		"_is_upgrade": true,
	},
	"! Misplaced Research !": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Shuffle the top {card_amount} cards of the discard pile into the draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 10,
			"card_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Excogitate": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Shuffle {card_amount} random card from the forgotten pile into the draw pile.",
		"Cost": 2,
		"_illustration": "Miikka Veijola",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 12,
			"card_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! Excogitate !",
			"Ω Excogitate Ω",
		],
	},
	"! Excogitate !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Shuffle up to {card_amount} random cards from the forgotten pile into the draw pile.",
		"Cost": 2,
		"_illustration": "Miikka Veijola",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 9,
			"card_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Ω Excogitate Ω": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Shuffle {card_amount} random card from the forgotten pile into the draw pile.",
		"Cost": 2,
		"_illustration": "Miikka Veijola",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 15,
			"card_amount": 1,
		},
		"_is_upgrade": true,
	},
	"The Whippy-Flippy": {
		"Type": "Control",
		"Tags": [
			Terms.ACTIVE_EFFECTS.buffer.name, 
			Terms.ACTIVE_EFFECTS.empower.name,
			Terms.ACTIVE_EFFECTS.strengthen.name
		],
		"Abilities": "If every Torment {stress}:\n"\
				+ "{stress} ≤ {beneficial_integer}: Gain {effect_stacks} {buffer}\n"\
				+ "{stress} ≤ {beneficial_integer2}: Gain {effect_stacks2} {empower}\n"\
				+ "{stress} ≤ {beneficial_integer3}: Gain {effect_stacks3} {strengthen}\n",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Rare",
		"_keywords": ["stress"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.empower.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 2,
			"beneficial_integer": 10,
			"effect_stacks2": 2,
			"beneficial_integer2": 5,
			"effect_stacks3": 1,
			"beneficial_integer3": 0,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.buffer.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.empower.name,
			"effect_stacks3": Terms.ACTIVE_EFFECTS.strengthen.name,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* The Whippy-Flippy *",
			"% The Whippy-Flippy %",
			"= The Whippy-Flippy =",
		],
	},
	"* The Whippy-Flippy *": {
		"Type": "Control",
		"Tags": [
			Terms.ACTIVE_EFFECTS.buffer.name, 
			Terms.ACTIVE_EFFECTS.empower.name,
			Terms.ACTIVE_EFFECTS.strengthen.name
		],

		"Abilities": "If every Torment {stress}:\n"\
				+ "{stress} ≤ {beneficial_integer}: Gain {effect_stacks} {buffer}\n"\
				+ "{stress} ≤ {beneficial_integer2}: Gain {effect_stacks2} {empower}\n"\
				+ "{stress} ≤ {beneficial_integer3}: Gain {effect_stacks3} {strengthen}\n",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Rare",
		"_keywords": ["stress"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.empower.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 3,
			"beneficial_integer": 10,
			"effect_stacks2": 3,
			"beneficial_integer2": 5,
			"effect_stacks3": 1,
			"beneficial_integer3": 0,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.buffer.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.empower.name,
			"effect_stacks3": Terms.ACTIVE_EFFECTS.strengthen.name,
		},
		"_is_upgrade": true,
	},
	"% The Whippy-Flippy %": {
		"Type": "Control",
		"Tags": [
			Terms.ACTIVE_EFFECTS.buffer.name, 
			Terms.ACTIVE_EFFECTS.empower.name,
			Terms.ACTIVE_EFFECTS.strengthen.name
		],

		"Abilities": "If every Torment {stress}:\n"\
				+ "{stress} ≤ {beneficial_integer}: Gain {effect_stacks} {buffer}\n"\
				+ "{stress} ≤ {beneficial_integer2}: Gain {effect_stacks2} {empower}\n"\
				+ "{stress} ≤ {beneficial_integer3}: Gain {effect_stacks3} {strengthen}\n",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Rare",
		"_keywords": ["stress"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.empower.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 1,
			"beneficial_integer": 10,
			"effect_stacks2": 1,
			"beneficial_integer2": 5,
			"effect_stacks3": 2,
			"beneficial_integer3": 0,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.buffer.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.empower.name,
			"effect_stacks3": Terms.ACTIVE_EFFECTS.strengthen.name,
		},
		"_is_upgrade": true,
	},
	"= The Whippy-Flippy =": {
		"Type": "Control",
		"Tags": [
			Terms.ACTIVE_EFFECTS.buffer.name, 
			Terms.ACTIVE_EFFECTS.empower.name,
			Terms.ACTIVE_EFFECTS.strengthen.name
		],

		"Abilities": "If every Torment {stress}:\n"\
				+ "{stress} ≤ {beneficial_integer}: Gain {effect_stacks} {buffer}\n"\
				+ "{stress} ≤ {beneficial_integer2}: Gain {effect_stacks2} {empower}\n"\
				+ "{stress} ≤ {beneficial_integer3}: Gain {effect_stacks3} {strengthen}\n",
		"Cost": 1,
		"_illustration": "Maria Thoukydidou",
		"_rarity": "Rare",
		"_keywords": ["stress"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.empower.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 2,
			"beneficial_integer": 13,
			"effect_stacks2": 2,
			"beneficial_integer2": 8,
			"effect_stacks3": 1,
			"beneficial_integer3": 2,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.buffer.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.empower.name,
			"effect_stacks3": Terms.ACTIVE_EFFECTS.strengthen.name,
		},
		"_is_upgrade": true,
	},
	"The Plot Chickens...": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "{damage} for {damage_amount}. "\
				+ "If the target has {confusion}, Gain {effect_stacks} {buffer} and {defence_amount} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 7,
			"defence_amount": 4,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ The Plot Chickens... +",
			"* The Plot Chickens... *",
			"% The Plot Chickens... %",
		],
	},
	"+ The Plot Chickens... +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "{damage} for {damage_amount}. "\
				+ "If the target has {confusion}, Gain {effect_stacks} {buffer} and {defence_amount} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 10,
			"defence_amount": 4,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"* The Plot Chickens... *": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "{damage} for {damage_amount}. "\
				+ "If the target has {confusion}, Gain {effect_stacks} and {defence_amount} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 7,
			"defence_amount": 5,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"% The Plot Chickens... %": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "{damage} for {damage_amount}. "\
				+ "If the target has {confusion}, Gain {defence_amount} {confidence}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 9,
			"defence_amount": 8,
			"effect_stacks": 0,
		},
		"_is_upgrade": true,
	},
	"A Strange Gaida": {
		"Type": "Control",
		"Tags": [
			Terms.ACTIVE_EFFECTS.disempower.name, 
			Terms.ACTIVE_EFFECTS.marked.name,
			Terms.GENERIC_TAGS.slumber.name
		],
		"Abilities": "All Torments gain {effect_stacks} {confusion} and {effect_stacks2} {marked}. {forget}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY,
		},
		"_amounts": {
			"effect_stacks": 3,
			"effect_stacks2": 6,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.disempower.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.marked.name,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* A Strange Gaida *",
			"@ A Strange Gaida @",
		],
	},
	"* A Strange Gaida *": {
		"Type": "Control",
		"Tags": [
			Terms.ACTIVE_EFFECTS.disempower.name, 
			Terms.ACTIVE_EFFECTS.marked.name,
			Terms.GENERIC_TAGS.slumber.name
		],

		"Abilities": "All Torments gain {effect_stacks} {confusion} and {effect_stacks2} {marked}. {forget}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY,
		},
		"_amounts": {
			"effect_stacks": 5,
			"effect_stacks2": 10,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.disempower.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.marked.name,
		},
		"_is_upgrade": true,
	},
	"@ A Strange Gaida @": {
		"Type": "Control",
		"Tags": [
			Terms.ACTIVE_EFFECTS.disempower.name, 
			Terms.ACTIVE_EFFECTS.marked.name,
			Terms.GENERIC_TAGS.slumber.name
		],

		"Abilities": "All Torments gain {effect_stacks} {confusion} and {effect_stacks2} {marked}. {forget}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY,
		},
		"_amounts": {
			"effect_stacks": 2,
			"effect_stacks2": 4,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.disempower.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.marked.name,
		},
		"_is_upgrade": true,
	},
	"One With The Poultry": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "If you have {buffer}, gain {effect_stacks} {armor}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_amounts": {
			"defence_amount": 8,
			"effect_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* One With The Poultry *",
			"+ One With The Poultry +",
			"% One With The Poultry %",
		],
	},
	"* One With The Poultry *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "If you have {buffer}, gain {effect_stacks} {armor}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_amounts": {
			"defence_amount": 8,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"+ One With The Poultry +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "If you have {buffer}, gain {effect_stacks} {armor}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_amounts": {
			"defence_amount": 11,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"% One With The Poultry %": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "If you have {buffer}, gain {effect_stacks} {armor}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_amounts": {
			"defence_amount": 20,
			"effect_stacks": 5,
		},
		"_is_upgrade": true,
	},
	"Sneaky-Beaky": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Whenever you succesfully {damage} a Torment with a card or memory effect, "\
				+ "it gains it {concentration_stacks} {confusion}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation", "Sneaky-Beaky"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
		},
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Sneaky-Beaky @",
			"^ Sneaky-Beaky ^",
		],
	},
	"@ Sneaky-Beaky @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Whenever you succesfully {damage} a Torment with a card or memory effect, "\
				+ "it gains it {concentration_stacks} {confusion}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation", "Sneaky-Beaky"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
		},
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"^ Sneaky-Beaky ^": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Whenever you succesfully {damage} a Torment with a card or memory effect, "\
				+ "it gains it {concentration_stacks} {confusion}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation", "Sneaky-Beaky"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
		},
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Sensuous": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name, Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "Apply {effect_stacks} {confusion} to Target Torment, "\
				+ "then gain {thorns} equal to the target's {confusion}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Sensuous *",
			"Ω Sensuous Ω",
		],
	},
	"* Sensuous *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name, Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "Apply {effect_stacks} {confusion} to Target Torment, "\
				+ "then gain {thorns} equal to the target's {confusion}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"Ω Sensuous Ω": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name, Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Apply {effect_stacks} {confusion} to Target Torment, "\
				+ "then gain {thorns} equal to the target's {confusion}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Massive Eggression": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. Gain {effect_stacks} {confusion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 19,
			"effect_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Massive Eggression +",
			"% Massive Eggression %",
		],
	},
	"+ Massive Eggression +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. Gain {effect_stacks} {confusion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 24,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"% Massive Eggression %": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. Gain {effect_stacks} {confusion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 30,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Impugn": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. "\
				+ "If the target has {poison}, {pierce}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation","pierce"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 9,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Impugn +",
			"Ω Impugn Ω",
		],
	},
	"+ Impugn +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. "\
				+ "If the target has {poison}, {pierce}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation","pierce"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 12,
		},
		"_is_upgrade": true,
	},
	"Ω Impugn Ω": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{damage} for {damage_amount}. "\
				+ "If the target has {poison}, {pierce}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation","pierce"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 11,
		},
		"_is_upgrade": true,
	},
	"Unshakeable": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {defence_amount} {defence}\n{forget}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 30,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Unshakeable +",
			"Confidently Unshakeable",
		],
	},
	"+ Unshakeable +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {defence_amount} {defence}\n{forget}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 40,
		},
		"_is_upgrade": true,
	},
	"Confidently Unshakeable": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Set your {defence_amount} to {defence}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 30,
		},
		"_is_upgrade": true,
	},
	"Tenacity": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the end of each turn, gain {concentration_defence} {defence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Dogged Tenacity",
			"@ Tenacity @",
		],
	},
	"Dogged Tenacity": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the end of each turn, gain {concentration_defence} {defence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 4,
		},
		"_is_upgrade": true,
	},
	"@ Tenacity @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the end of each turn, gain {concentration_defence} {defence}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_defence": 3,
		},
		"_is_upgrade": true,
	},
	"The Finger": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you have {max_requirements_amount} {defence}, gain {effect_stacks} {fortify}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation","confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 8,
			"max_requirements_amount": 0,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ The Finger +",
			"% The Finger %",
		],
	},
	"+ The Finger +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you have {max_requirements_amount} or less {defence}, gain {effect_stacks} {fortify}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation","confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 11,
			"max_requirements_amount": 0,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"% The Finger %": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If you have {max_requirements_amount} or less {defence}, gain {effect_stacks} {fortify}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation","confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 8,
			"max_requirements_amount": 5,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Bring It!": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "{damage} all Torments for {damage_amount}.\n"\
				+ "Give a random Torment {effect_stacks} {advantage}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 8,
			"effect_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Bring It! +",
			"Ω Bring It! Ω",
		],
	},
	"+ Bring It! +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "{damage} all Torments for {damage_amount}.\n"\
				+ "Give a random Torment {effect_stacks} {advantage}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 11,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Ω Bring It! Ω": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "{damage} all Torments for {damage_amount}.\n"\
				+ "Give a random Torment {effect_stacks} {advantage}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 9,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Sanguine": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain X * {defence_amount} {defence}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 7,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Sanguine @",
			"+ Sanguine +",
		],
	},
	"+ Sanguine +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain X * {defence_amount} {defence}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 9,
		},
		"_is_upgrade": true,
	},
	"@ Sanguine @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain (X + 1) * {defence_amount} {defence}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 7,
			"x_modifer": "+1",
		},
		"_is_upgrade": true,
	},
	"Launch": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "Gain X * {effect_stacks} {impervious}\n"\
				+ "If X is at least {x_requirement}, all Torments gain {effect_stacks2} {burn}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY
		},
		"_keywords": [],
		"_amounts": {
			"effect_stacks": 2,
			"effect_stacks2": 2,
			"x_requirement": 1,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.impervious.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.burn.name,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Launch @",
			"* Launch *",
			"% Launch %",
		],
	},
	"@ Launch @": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "Gain X * {effect_stacks} {impervious}\n"\
				+ "If X is at least {x_requirement}, all Torments gain {effect_stacks} {burn}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY
		},
		"_keywords": [],
		"_amounts": {
			"effect_stacks": 3,
			"effect_stacks2": 2,
			"x_requirement": 1,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.impervious.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.burn.name,
		},
		"_is_upgrade": true,
	},
	"* Launch *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "Gain X * {effect_stacks} {impervious}\n"\
				+ "If X is at least {x_requirement}, all Torments gain {effect_stacks2} {burn}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY
		},
		"_keywords": [],
		"_amounts": {
			"effect_stacks": 2,
			"effect_stacks2": 3,
			"x_requirement": 1,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.impervious.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.burn.name,
		},
		"_is_upgrade": true,
	},
	"% Launch %": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "Gain X * {effect_stacks} {impervious}\n"\
				+ "All Torments gain {effect_stacks2} {burn}",
		"Cost": 'X',
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY
		},
		"_keywords": [],
		"_amounts": {
			"effect_stacks": 2,
			"effect_stacks2": 2,
			"x_requirement": 0,
		},
		"_amount_purpose_map": {
			"effect_stacks": Terms.ACTIVE_EFFECTS.impervious.name,
			"effect_stacks2": Terms.ACTIVE_EFFECTS.burn.name,
		},
		"_is_upgrade": true,
	},
	"Swoop": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Remove all {impervious} and repeat the same amount of times",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 6,
			"per_modifier": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Swoop +",
			"% Swoop %",
		],
	},
	"+ Swoop +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Remove all {impervious} and repeat the same amount of times",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 9,
			"per_modifier": 1,
		},
		"_is_upgrade": true,
	},
	"% Swoop %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Remove all {impervious} "\
				+ "and {damage} for {damage_amount} twice as many times",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 7,
			"per_multiplier": 2,
		},
		"_is_upgrade": true,
	},
	"Panicked Takeoff": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "After the first time taking {anxiety} during Torment's turn, gain {concentration_stacks} {impervious}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
		},
		"_keywords": [""],
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Panicked Takeoff @",
			"Wildly Panicked Takeoff",
		],
	},
	"@ Panicked Takeoff @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "After the first time taking {anxiety} during Torment's turn, gain {concentration_stacks} {impervious}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
		},
		"_keywords": [""],
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Wildly Panicked Takeoff": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "After the first time taking {anxiety} during Torment's turn,"\
				+ "gain {concentration_stacks} {impervious} and draw {concentration_cards} card.",
		"Cost": 3,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER,
		},
		"_keywords": [""],
		"_rarity": "Rare",
		"_amounts": {
			"concentration_stacks": 2,
			"concentration_cards": 1,
		},
		"_is_upgrade": true,
	},
	"A Chick of the Light": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}.\n"\
			+ "If no Torment is going to be inflicting more than {max_requirements_amount} {stress}"\
					 + "this turn, gain {effect_stacks} {fortify}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER,
		},
		"_keywords": ["confidence", "stress"],
		"_amounts": {
			"defence_amount": 12,
			"max_requirements_amount": 5,
			"effect_stacks": 1
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ A Chick of the Light +",
			"% A Chick of the Light %",
		],
	},
	"+ A Chick of the Light +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}.\n"\
			+ "If no Torment is going to be inflicting more than {max_requirements_amount} "\
					 + "this turn, gain {effect_stacks} {fortify}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER,
		},
		"_keywords": ["confidence", "stress"],
		"_amounts": {
			"defence_amount": 16,
			"max_requirements_amount": 5,
			"effect_stacks": 1
		},
		"_is_upgrade": true,
	},
	"% A Chick of the Light %": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}.\n"\
			+ "If no Torment is going to be inflicting more than {max_requirements_amount} "\
					 + "this turn, gain {effect_stacks} {fortify}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER,
		},
		"_keywords": ["confidence", "stress"],
		"_amounts": {
			"defence_amount": 13,
			"max_requirements_amount": 8,
			"effect_stacks": 1
		},
		"_is_upgrade": true,
	},
	"Near-ground Flight": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If your {anxiety} is less than {max_requirements_amount}% full, gain {effect_stacks} {buffer}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
		},
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"effect_stacks": 1,
			"defence_amount": 13,
			"max_requirements_amount": 25,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Near-ground Flight +",
			"= Near-ground Flight =",
			"* Near-ground Flight *",
		],
	},
	"+ Near-ground Flight +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If your {anxiety} is less than {max_requirements_amount}% full, gain {effect_stacks} {buffer}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
		},
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"effect_stacks": 1,
			"defence_amount": 17,
			"max_requirements_amount": 25,
		},
		"_is_upgrade": true,
	},
	"= Near-ground Flight =": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If your {anxiety} is less than {max_requirements_amount}% full, gain {effect_stacks} {buffer}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
		},
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"effect_stacks": 1,
			"defence_amount": 15,
			"max_requirements_amount": 35,
		},
		"_is_upgrade": true,
	},
	"* Near-ground Flight *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.buffer.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If your {anxiety} is less than {max_requirements_amount}% full, gain {effect_stacks} {buffer}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER,
		},
		"_keywords": ["confidence", "anxiety"],
		"_amounts": {
			"effect_stacks": 2,
			"defence_amount": 15,
			"max_requirements_amount": 15,
		},
		"_is_upgrade": true,
	},
}


#class_name CoreDefinitions
extends Reference

const SET = "Core Set"
const CARDS := {
	"Gaslighter": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {poison} to a Torment.\n"\
				+ "Remove all {poison} from the dreamer.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_amounts": {
			"effect_stacks": 3,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"* Gaslighter *",
			"Ω Gaslighter Ω",
			"Gaslighter Exposed",
		],
	},
	"* Gaslighter *": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {poison} to a Torment.\n"\
				+ "Remove all {poison} from the dreamer.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_amounts": {
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"Ω Gaslighter Ω": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Apply {effect_stacks} {poison} to a Torment.\n"\
				+ "Remove all {poison} from the dreamer.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Gaslighter Exposed": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply {effect_stacks} {poison} to a Torment.\n"\
				+ "Move all {poison} from the dreamer to that Torment.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Broken Mirror": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "Apply {effect_stacks} {burn} to a Torment.\n"\
				+ "Remove all {envy} from the dreamer.",
		"Cost": 0,
		"_illustration": "Ierenisrt#0318",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY
		},
		"_amounts": {
			"effect_stacks": 4,
		},
		"_upgrade_threshold": 14,
		"_upgrades": [
			"* Broken Mirror *",
			"Ω Broken Mirror Ω",
			"Broken Mirror Exposed",
		],
	},
	"* Broken Mirror *": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "Apply {effect_stacks} {burn} to a Torment.\n"\
				+ "Remove all {burn} from the dreamer.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY
		},
		"_amounts": {
			"effect_stacks": 5,
		},
		"_is_upgrade": true,
	},
	"Ω Broken Mirror Ω": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.burn.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Apply {effect_stacks} {burn} to a Torment.\n"\
				+ "Remove all {burn} from the dreamer.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY
		},
		"_amounts": {
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"Broken Mirror Exposed": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "Apply {effect_stacks} {burn} to a Torment.\n"\
				+ "Move all {burn} from the dreamer to that Torment.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY
		},
		"_amounts": {
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"Fearmonger": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "{forget} a {perturbation} from your deck or discard pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "perturbation"],
		"_amounts": {
			"defence_amount": 4,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"+ Fearmonger +",
			"~ Fearmonger ~",
			"Ω Fearmonger Ω",
			"Fearmonger Exposed",
		],
	},
	"+ Fearmonger +": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "{forget} a {perturbation} from your deck or discard pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "perturbation"],
		"_amounts": {
			"defence_amount": 6,
		},
		"_is_upgrade": true,
	},
	"Ω Fearmonger Ω": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "{forget} a {perturbation} from your deck or discard pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "perturbation"],
		"_amounts": {
			"defence_amount": 4,
		},
		"_is_upgrade": true,
	},
	"~ Fearmonger ~": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "{forget} a {perturbation} from your deck or discard pile.\n{forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "perturbation"],
		"_amounts": {
			"defence_amount": 8,
		},
		"_is_upgrade": true,
	},
	"Fearmonger Exposed": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.spark.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "{shuffle} a random {perturbation} from your hand into your deck.\n"\
				+ "{forget} a {perturbation} from your deck or discard pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "perturbation"],
		"_amounts": {
			"defence_amount": 4,
		},
		"_is_upgrade": true,
	},
	"The Laughing One": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {untouchable}. {forget}",
		"Cost": 1,
		"_illustration": "DioBal",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"@ The Laughing One @",
			"ROFLMAO",
		],
	},
	"@ The Laughing One @": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {untouchable}. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"ROFLMAO": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.GENERIC_TAGS.relax.name],
		"Abilities": "Gain {effect_stacks} {untouchable}.\n"\
				+ "{relax} 1 per {confidence}.\nRemove all {confidence}\n"\
				+ "{forget}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_keywords": ["forget", "confidence", "relax"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"The Critic": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Apply {effect_stacks} {shaken} to a Torment. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 10,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"The Critic Unleashed",
			"^ The Critic ^",
		],
	},
	"^ The Critic ^": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Apply {effect_stacks} {shaken} to a Torment. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 10,
		},
		"_is_upgrade": true,
	},
	"The Critic Unleashed": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Apply {effect_stacks} {shaken} to all Torments. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 7,
		},
		"_is_upgrade": true,
	},
	"Clown": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Apply {effect_stacks} {confusion} to all Torments. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"* Clown *",
			"^ Clown ^",
		],
	},
	"* Clown *": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Apply {effect_stacks} {confusion} to all Torments. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"^ Clown ^": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Apply {effect_stacks} {confusion} to all Torments. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Butterfly": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.strengthen.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {strengthen}. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 1,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"* Butterfly *",
			"^ Butterfly ^",
			"Sustained Butterfly",
		],
	},
	"* Butterfly *": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.strengthen.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {strengthen}. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"^ Butterfly ^": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.strengthen.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Gain {effect_stacks} {strengthen}. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Sustained Butterfly": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.strengthen.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {strengthen}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Unnamed Enemy 1": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {thorns}. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"* Unnamed Enemy 1 *",
			"^ Unnamed Enemy 1 ^",
			"Sustained Unnamed Enemy 1",
		],
	},
	"* Unnamed Enemy 1 *": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {thorns}. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"^ Unnamed Enemy 1 ^": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Gain {effect_stacks} {thorns}. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Sustained Unnamed Enemy 1": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "Gain {effect_stacks} {thorns}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Pialephant": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{damage} for {damage_amount}. {forget}",
		"Cost": 3,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "interpretation"],
		"_amounts": {
			"damage_amount": 35,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"+ Pialephant +",
			"@ Pialephant @",
		],
	},
	"+ Pialephant +": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{damage} for {damage_amount}. {forget}",
		"Cost": 3,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "interpretation"],
		"_amounts": {
			"damage_amount": 50,
		},
		"_is_upgrade": true,
	},
	"@ Pialephant @": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{damage} for {damage_amount}. {forget}",
		"Cost": 2,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "interpretation"],
		"_amounts": {
			"damage_amount": 30,
		},
		"_is_upgrade": true,
	},
	"The Light Calling": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.ACTIVE_EFFECTS.drain.name],
		"Abilities": "Gain {defence_amount} {defence}\nGain {effect_stacks} {drain}\n{forget}",
		"Cost": 0,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.drain.name: Terms.PLAYER
		},
		"_amounts": {
			"defence_amount": 10,
			"effect_stacks": 1
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"+ The Light Calling +",
			"* The Light Calling *",
		],
	},
	"+ The Light Calling +": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.ACTIVE_EFFECTS.drain.name],
		"Abilities": "Gain {defence_amount} {defence}\nGain {effect_stacks} {drain}\n{forget}",
		"Cost": 0,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.drain.name: Terms.PLAYER
		},
		"_amounts": {
			"defence_amount": 14,
			"effect_stacks": 1
		},
		"_is_upgrade": true,
	},
	"* The Light Calling *": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.ACTIVE_EFFECTS.drain.name],
		"Abilities": "Gain {defence_amount} {defence}\nGain {effect_stacks} {drain}\n{forget}",
		"Cost": 0,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.drain.name: Terms.PLAYER
		},
		"_amounts": {
			"defence_amount": 20,
			"effect_stacks": 2
		},
		"_is_upgrade": true,
	},
	"A Squirrel": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}.\n"\
				+ "Gain {defence_amount} {defence}\n"\
				+ "{damage} for {damage_amount}\n{forget}",
		"Cost": 0,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "confidence", "interpretation"],
		"_amounts": {
			"defence_amount": 11,
			"damage_amount": 11,
			"exert_amount": 7
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"+ A Squirrel +",
			"% A Squirrel %",
		],
	},
	"+ A Squirrel +": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}.\n"\
				+ "Gain {defence_amount} {defence}\n"\
				+ "{damage} for {damage_amount}\n{forget}",
		"Cost": 0,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "confidence", "interpretation"],
		"_amounts": {
			"defence_amount": 14,
			"damage_amount": 14,
			"exert_amount": 7
		},
		"_is_upgrade": true,
	},
	"% A Squirrel %": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}.\n"\
				+ "Gain {defence_amount} {defence}\n"\
				+ "{damage} for {damage_amount}\n{forget}",
		"Cost": 0,
		"_illustration": "David Revoy",
		"_rarity": "Received",
		"_keywords": ["forget", "confidence", "interpretation"],
		"_amounts": {
			"defence_amount": 11,
			"damage_amount": 11,
			"exert_amount": 3
		},
		"_is_upgrade": true,
	},
	"Baby": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.advantage.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} delayed {delighted}.\n"\
				+ "Gain {effect_stacks2} {advantage}\n"\
				+ "{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "delayed"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.delighted.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 1,
			"effect_stacks2": 1,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"* Baby *",
			"Ω Baby Ω",
		],
	},
	"* Baby *": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.advantage.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} delayed {delighted}.\n"\
				+ "Gain {effect_stacks2} {advantage}\n"\
				+ "{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "delayed"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.delighted.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 1,
			"effect_stacks2": 2,
		},
		"_is_upgrade": true,
	},
	"Ω Baby Ω": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.advantage.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Gain {effect_stacks} delayed {delighted}.\n"\
				+ "Gain {effect_stacks2} {advantage}\n"\
				+ "{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "delayed"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.advantage.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.delighted.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 1,
			"effect_stacks2": 2,
		},
		"_is_upgrade": true,
	},
	"Traffic Jam": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.pathos.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Gain {repressed_amount} repressed Frustration.\n"\
				+ "Gain {released_amount} released Frustration\n"\
				+ "{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "interpretation"],
		"_amounts": {
			"damage_amount": 10,
			"repressed_amount": 10,
			"released_amount": 10,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"% Traffic Jam %",
			"+ Traffic Jam +",
		],
	},
	"% Traffic Jam %": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.pathos.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Gain {repressed_amount} repressed Frustration.\n"\
				+ "Gain {released_amount} released Frustration\n"\
				+ "{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "interpretation"],
		"_amounts": {
			"damage_amount": 11,
			"repressed_amount": 5,
			"released_amount": 15,
		},
		"_is_upgrade": true,
	},
	"+ Traffic Jam +": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.pathos.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Gain {repressed_amount} repressed Frustration.\n"\
				+ "Gain {released_amount} released Frustration\n"\
				+ "{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "interpretation"],
		"_amounts": {
			"damage_amount": 15,
			"repressed_amount": 10,
			"released_amount": 10,
		},
		"_is_upgrade": true,
	},
	"Stuffed Toy": {
		"Type": "Understanding",
		"Tags": [],
		"Abilities": "After any {stress} on the dreamer,"\
				+ "gain 1 {defence}. "\
				+ "The amount gained increases by 1 after each {stress}.\n"\
				+ "This resets to 0 at the start of the turn.",
		"Cost": 2,
		"_is_concentration": true,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["confidence"],
		"_amounts": {
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"@ Stuffed Toy @",
			"^ Stuffed Toy ^",
		],
	},
	"@ Stuffed Toy @": {
		"Type": "Understanding",
		"Tags": [],
		"Abilities": "After any {stress} on the dreamer,"\
				+ "gain 1 {defence}. "\
				+ "The amount gained increases by 1 after each {stress}.\n"\
				+ "This resets to 0 at the start of the turn.",
		"Cost": 1,
		"_is_concentration": true,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["confidence"],
		"_amounts": {
		},
		"_is_upgrade": true,
	},
	"^ Stuffed Toy ^": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "After any {stress} on the dreamer,"\
				+ "gain 1 {defence}. "\
				+ "The amount gained increases by 1 after each {stress}.\n"\
				+ "This resets to 0 at the start of the turn.",
		"Cost": 2,
		"_is_concentration": true,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["confidence"],
		"_amounts": {
		},
		"_is_upgrade": true,
	},
	"Mouse": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion} per turn.\nLose {effect_stacks2} {focus}\n"\
				+ "Every time you shuffle your deck, lose {effect_stacks} {focus}.",
		"Cost": 3,
		"_is_concentration": true,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["immersion"],
		"_amounts": {
			"immersion_amount": 1,
			"effect_stacks": 1,
			"effect_stacks2": 1,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"@ Mouse @",
			"^ Mouse ^",
		],
	},
	"@ Mouse @": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion} per turn.\nLose {effect_stacks2} {focus}\n"\
				+ "Every time you shuffle your deck, lose {effect_stacks} {focus}.",
		"Cost": 2,
		"_is_concentration": true,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["immersion"],
		"_amounts": {
			"immersion_amount": 1,
			"effect_stacks": 2,
			"effect_stacks2": 1,
		},
		"_is_upgrade": true,
	},
	"^ Mouse ^": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.alpha.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain {immersion_amount} {immersion} per turn.\nLose {effect_stacks2} {focus}\n"\
				+ "Every time you shuffle your deck, lose {effect_stacks} {focus}.",
		"Cost": 3,
		"_is_concentration": true,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["immersion"],
		"_amounts": {
			"immersion_amount": 1,
			"effect_stacks": 2,
			"effect_stacks2": 1,
		},
		"_is_upgrade": true,
	},
	"The Exam": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "Shuffle {card_amount} random forgotten cards into your deck.\n"\
				+ "Every time you play a forgotten card, take {exert_amount} {anxiety}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget"],
		"_amounts": {
			"card_amount": 2,
			"exert_amount": 1,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"! The Exam !",
			"Ω The Exam Ω",
		],
	},
	"! The Exam !": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.spark.name],
		"Abilities": "Shuffle {card_amount} random forgotten cards into your deck.\n"\
				+ "Every time you play a forgotten card, take {exert_amount} {anxiety}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget"],
		"_amounts": {
			"card_amount": 3,
			"exert_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Ω The Exam Ω": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.spark.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Shuffle {card_amount} random forgotten cards into your deck.\n"\
				+ "Every time you play a forgotten card, take {exert_amount} {anxiety}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget"],
		"_amounts": {
			"card_amount": 2,
			"exert_amount": 1,
		},
		"_is_upgrade": true,
	},
	"The Victim": {
		"Type": "Understanding",
		"Tags": [],
		"Abilities": "The first time each turn target torment gets {effect_threshold} {damage} or more "\
				+ "from one source, reduce its {focus} by {effect_stacks} for this turn.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": [],
		"_amounts": {
			"effect_threshold": 9,
			"effect_stacks": 1,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"^ The Victim ^",
			"* The Victim *",
		],
	},
	"^ The Victim ^": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "The first time each turn target torment gets {effect_threshold} {damage} or more "\
				+ "from one source, reduce its {focus} by {effect_stacks} for this turn.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": [],
		"_amounts": {
			"effect_threshold": 9,
			"effect_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"* The Victim *": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "The first time each turn target torment gets {effect_threshold} {damage} or more "\
				+ "from one source, reduce its {focus} by {effect_stacks} for this turn.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": [],
		"_amounts": {
			"effect_threshold": 9,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Hyena": {
		"Type": "Understanding",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. If they have any buffs, steal {steal_amount} stacks from the most stacks.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["intepretation"],
		"_amounts": {
			"damage_amount": 9,
			"steal_amount": 2,
		},
		"_upgrade_threshold": 12,
		"_upgrades": [
			"Ω Wolf Ω",
			"+ Wolf +",
			"* Wolf *",
		],
	},
	"+ Hyena +": {
		"Type": "Understanding",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. If they have any buffs, steal {steal_amount} stacks from the most stacks.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["intepretation"],
		"_amounts": {
			"damage_amount": 12,
			"steal_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Ω Hyena Ω": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{damage} for {damage_amount}. If they have any buffs, steal {steal_amount} stacks from the most stacks.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["intepretation"],
		"_amounts": {
			"damage_amount": 10,
			"steal_amount": 2,
		},
		"_is_upgrade": true,
	},
	"* Hyena *": {
		"Type": "Understanding",
		"Tags": [Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{damage} for {damage_amount}. If they have any buffs, steal {steal_amount} stacks from the most stacks.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["intepretation"],
		"_amounts": {
			"damage_amount": 10,
			"steal_amount": 3,
		},
		"_is_upgrade": true,
	},

}

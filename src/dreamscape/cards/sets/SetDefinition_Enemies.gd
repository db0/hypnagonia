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
		"_illustration": "Nobody",
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
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 1,
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
			"effect_stacks": 1,
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
			"effect_stacks": 1,
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
}

#class_name CoreDefinitions
extends Reference

const SET = "Vindictive"
const CARDS := {
	"Keep in Mind": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.frozen.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{beneficial_integer} random card in your hand becomes {frozen}\n{forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": [],
		"_amounts": {
			"beneficial_integer": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Keep in Mind +",
			"Store in Mind",
		],
	},
	"+ Keep in Mind +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.frozen.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{beneficial_integer} random card in your hand becomes {frozen}\n{forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": [],
		"_amounts": {
			"beneficial_integer": 2,
		},
		"_is_upgrade": true,
	},
	"Store in Mind": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.frozen.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Choose {beneficial_integer} card. It becomes {frozen}\n{forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": [],
		"_amounts": {
			"beneficial_integer": 1,
		},
		"_is_upgrade": true,
	},
	"Memento of Anger": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If {frozen}, {damage} for {damage_amount2}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "frozen"],
		"_amounts": {
			"damage_amount": 8,
			"damage_amount2": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Memento of Anger +",
			"% Memento of Anger %",
		],
	},
	"+ Memento of Anger +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If {frozen}, {damage} for {damage_amount2}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "frozen"],
		"_amounts": {
			"damage_amount": 11,
			"damage_amount2": 3,
		},
		"_is_upgrade": true,
	},
	"% Memento of Anger %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If {frozen}, {damage} for {damage_amount2}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "frozen"],
		"_amounts": {
			"damage_amount": 6,
			"damage_amount2": 10,
		},
		"_is_upgrade": true,
	},
	"Memento of Safety": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If {frozen}, gain {defence_amount} {defence_amount2}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "frozen"],
		"_amounts": {
			"defence_amount": 7,
			"defence_amount2": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Memento of Safety +",
			"% Memento of Safety %",
		],
	},
	"+ Memento of Safety +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If {frozen}, gain {defence_amount} {defence_amount2}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "frozen"],
		"_amounts": {
			"defence_amount": 10,
			"defence_amount2": 3,
		},
		"_is_upgrade": true,
	},
	"% Memento of Safety %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If {frozen}, gain {defence_amount} {defence_amount2}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "frozen"],
		"_amounts": {
			"defence_amount": 5,
			"defence_amount2": 10,
		},
		"_is_upgrade": true,
	},
	"Moving On": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.frozen.name, Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "Draw {draw_amount} cards.\n"\
				+ "Discard {discard_amount} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": [],
		"_avoid_normal_discard": true,
		"_amounts": {
			"draw_amount": 2,
			"discard_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! Moving On !",
			"% Moving On %",
		],
	},
	"! Moving On !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.frozen.name, Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "Draw {draw_amount} cards.\n"\
				+ "Discard {discard_amount} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": [],
		"_avoid_normal_discard": true,
		"_amounts": {
			"draw_amount": 3,
			"discard_amount": 2,
		},
		"_is_upgrade": true,
	},
	"% Moving On %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.frozen.name, Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "Draw {draw_amount} cards.\n"\
				+ "Discard {discard_amount} cards.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_avoid_normal_discard": true,
		"_keywords": ["interpretation"],
		"_amounts": {
			"draw_amount": 6,
			"discard_amount": 3,
		},
		"_is_upgrade": true,
	},
	"Fist of Candies": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount} for each card in hand (including self)",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 3.0,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Fist of Candies +",
			"@ Fist of Candies @",
		],
	},
	"+ Fist of Candies +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount} for each card in hand (including self)",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": [],
		"_amounts": {
			"damage_amount": 4.0,
		},
		"_upgrade_threshold_modifier": 0,
		"_is_upgrade": true,
	},
	"@ Fist of Candies @": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount} for each card in hand (including self)",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 2.5,
		},
		"_upgrade_threshold_modifier": 0,
		"_is_upgrade": true,
	},
	"Hand of Grudge": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {thorns} for each card in hand (including self)",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 1.0,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Hand of Grudge *",
			"% Hand of Grudge %",
		],
	},
	"* Hand of Grudge *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {thorns} for each card in hand (including self)\n{forget}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 1.5,
		},
		"_is_upgrade": true,
	},
	"% Hand of Grudge %": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {thorns} for each card in hand (including self)\n{forget}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_amounts": {
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Vestige of Warmth": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "At the end of the turn, gain {defence_amount} {defence} for each card in hand.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_effect": 1.0,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Vestige of Warmth @",
			"Last Vestige of Warmth",
		],
	},
	"@ Vestige of Warmth @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "At the end of the turn, gain {defence_amount} {defence} for each card in hand.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_effect": 1.0,
		},
		"_is_upgrade": true,
	},
	"Last Vestige of Warmth": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "At the end of the turn, gain {defence_amount} {defence} for each card in hand.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_effect": 1.3,
		},
		"_is_upgrade": true,
	},
	"The Cold Dish": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Every turn this card starts in your hand, reduce its cost by {beneficial_integer} until you play it.",
		"Cost": 4,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 20,
			"beneficial_integer": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ The Cold Dish +",
			"% The Cold Dish %",
		],
	},
	"+ The Cold Dish +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Every turn this card starts in your hand, reduce its cost by {beneficial_integer} until you play it.",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 25,
			"beneficial_integer": 1,
		},
		"_is_upgrade": true,
	},
	"% The Cold Dish %": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "Every turn this card starts in your hand, reduce its cost by {beneficial_integer} until you play it.",
		"Cost": 6,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 50,
			"beneficial_integer": 1,
		},
		"_is_upgrade": true,
	},
	"Nothing Forgotten": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of the turn, {concentration_stacks}random card in your hand becomes {frozen}.",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["frozen"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_cards": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Nothing Forgotten @",
			"^ Nothing Forgotten ^",
		],
	},
	"@ Nothing Forgotten @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of the turn, {concentration_stacks}random card in your hand becomes {frozen}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["frozen"],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"^ Nothing Forgotten ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "At the start of the turn, {concentration_stacks}random card in your hand becomes {frozen}.",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["frozen"],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
}


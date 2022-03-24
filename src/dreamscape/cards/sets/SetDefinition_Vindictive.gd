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
		"Abilities": "Gain {defence_amount} {defence_amount}.\n"\
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
		"Abilities": "Gain {defence_amount} {defence_amount}.\n"\
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
		"Abilities": "Gain {defence_amount} {defence_amount}.\n"\
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
		"Tags": [Terms.GENERIC_TAGS.frozen.name],
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
		"Tags": [Terms.GENERIC_TAGS.frozen.name],
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
		"Tags": [Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "Draw {draw_amount} cards.\n"\
				+ "Discard {discard_amount} cards.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_avoid_normal_discard": true,
		"_keywords": [],
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
		"_keywords": [],
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
		"_keywords": [],
		"_amounts": {
			"damage_amount": 2.5,
		},
		"_upgrade_threshold_modifier": 0,
		"_is_upgrade": true,
	},

}


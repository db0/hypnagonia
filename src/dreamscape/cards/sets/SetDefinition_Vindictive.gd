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
		"_keywords": ["interpretation"],
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
		"_keywords": ["interpretation"],
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
		"_keywords": ["interpretation"],
		"_amounts": {
			"beneficial_integer": 1,
		},
		"_is_upgrade": true,
	},
	"Memento of Anger": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name, Terms.GENERIC_TAGS.end_turn.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If {frozen}, {damage} for {damage_amount2}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
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
		"_rarity": "Common",
		"_keywords": ["interpretation"],
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
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
			"damage_amount2": 10,
		},
		"_is_upgrade": true,
	},
}


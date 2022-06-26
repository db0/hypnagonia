#class_name CoreDefinitions
extends Reference

const SET = "Overworked"
const CARDS := {
	"Exhaustion": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.end_turn.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "The next {concentration_stacks} played card which goes in the discard pile "\
				+ "is played again, then is {forgotten}.\n{end_turn}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["forget"],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Exhaustion *",
			"@ Exhaustion @",
			"- Exhaustion -",
			"Minor Exhaustion",
		],
	},
	"* Exhaustion *": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.end_turn.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "The next {concentration_stacks} played cards which go in the discard pile "\
				+ "is played again, then is {forgotten}.\n{end_turn}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["forget"],
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"@ Exhaustion @": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.end_turn.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "The next {concentration_stacks} played card which goes in the discard pile "\
				+ "is played again, then is {forgotten}.\n{end_turn}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["forget"],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"- Exhaustion -": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "The next {concentration_stacks} played cards which go in the discard pile "\
				+ "is played again, then is {forgotten}.\n{end_turn}. {release}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["forget", "release"],
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Minor Exhaustion": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "The next {concentration_stacks} played card which goes in the discard pile "\
				+ "is played again, then is {forgotten}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["forget"],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Keep 'em Coming": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Whenever a card is {forgotten}, draw {concentration_stacks} card.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_keywords": ["forget"],
		"_rarity": "Uncommon",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Keep 'em Coming @",
			"^ Keep 'em Coming ^",
		],
	},
	"@ Keep 'em Coming @": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Whenever a card is {forgotten}, draw {concentration_stacks} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["forget"],
		"_rarity": "Uncommon",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"^ Keep 'em Coming ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Whenever a card is {forgotten}, draw {concentration_stacks} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["forget"],
		"_rarity": "Uncommon",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Know Your Limits": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "Whenever a card is {forgotten}, gain {concentration_stacks} {armor}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["forget"],
		"_rarity": "Uncommon",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Know Your Limits *",
			"^ Know Your Limits ^",
		],
	},
	"* Know Your Limits *": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "Whenever a card is {forgotten}, gain {concentration_stacks} {armor}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["forget"],
		"_rarity": "Uncommon",
		"_amounts": {
			"concentration_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_is_upgrade": true,
	},
	"^ Know Your Limits ^": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Whenever a card is {forgotten}, gain {concentration_stacks} {armor}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["forget"],
		"_rarity": "Uncommon",
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_is_upgrade": true,
	},
}


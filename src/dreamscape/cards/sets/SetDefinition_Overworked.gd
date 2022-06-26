#class_name CoreDefinitions
extends Reference

const SET = "Overworked"
const CARDS := {
	"Keep 'em Coming": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Whenever a card is {release}d, draw {concentration_stacks} card.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_keywords": ["Release"],
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
		"Abilities": "Whenever a card is {release}d, draw {concentration_stacks} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["Release"],
		"_rarity": "Uncommon",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"^ Keep 'em Coming ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Whenever a card is {release}d, draw {concentration_stacks} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_keywords": ["Release"],
		"_rarity": "Uncommon",
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
}


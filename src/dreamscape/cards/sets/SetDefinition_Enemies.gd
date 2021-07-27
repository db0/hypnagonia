#class_name CoreDefinitions
extends Reference

const SET = "Core Set"
const CARDS := {
	"Gaslighter": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply 2 {doubt} to a Torment.\n"\
				+ "Move all {doubt} from the dreamer to that Torment as well",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
	},
	"Fearmonger": {
		"Type": "Understanding",
		"Tags": [],
		"Abilities": "Gain 4 {confidence}\n"\
				+ "{forget} a {perturbation} from your deck or discard pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_keywords": ["forget", "perturbation"]
	},
	"The Laughing One": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain 1 {untouchable}. {forget}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_keywords": ["forget"]
	},
	"The Critic": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Apply 10 {shaken} to a Torment. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_keywords": ["forget"]
	},
	"Clown": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Apply 3 {confusion} to all Torments. {forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_keywords": ["forget"]
	},
}

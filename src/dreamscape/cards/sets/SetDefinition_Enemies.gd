#class_name CoreDefinitions
extends Reference

const SET = "Core Set"
const CARDS := {
	"Gaslighter": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Add 2 Doubt to a Torment. "\
				+ "Move all doubt from the dreamer to that torment as well",
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
		"Abilities": "Forget a Perturbation from your deck or discard pile."\
				+ "Gain 4 Confidence",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
	},
	"The Laughing One": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name, Terms.GENERIC_TAGS.fleeting.name],
		"Abilities": "Gain 1 Untouchable. Forget",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
	},
	"The Critic": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.vulnerable.name],
		"Abilities": "Add 10 Shaken to a Torment. Forget",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
	},
	"Clown": {
		"Type": "Understanding",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Add 3 Confusion to all Torments. Forget",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Received",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
	},
}

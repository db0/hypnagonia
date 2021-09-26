#class_name CoreDefinitions
extends Reference

const SET = "Core Set"
const CARDS := {
	"Dread": {
		"Type": "Perturbation",
		"Tags": [],
		"Abilities": "{release}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Perturbation",
		"_keywords": ["release"]
	},
	"Terror": {
		"Type": "Perturbation",
		"Tags": [],
		"Abilities": "{release}",
		"Cost": 3,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Perturbation",
		"_keywords": ["release"]
	},
	"Unease": {
		"Type": "Perturbation",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "If this card is in your hand at the end of the turn, gain {effect_stacks} {poison}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_amounts": {
			"effect_stacks": 1
		},
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.PLAYER
		},
	},
	"Discombobulation": {
		"Type": "Perturbation",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "If this card is in your hand at the end of the turn, gain {effect_stacks} {disempower}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_amounts": {
			"effect_stacks": 1
		},
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.PLAYER
		},
	},
	"Lacuna": {
		"Type": "Perturbation",
		"Tags": [],
		"Abilities": "{unplayable}",
		"Cost": 'U',
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_keywords": [],
		"_is_unplayable": true,
	},
	"Prejudice": {
		"Type": "Perturbation",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "If this card is in your hand at the end of the turn, gain {effect_stacks} {burn}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_amounts": {
			"effect_stacks": 2
		},
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.PLAYER
		},
	},
	"Alertness": {
		"Type": "Perturbation",
		"Tags": [Terms.GENERIC_TAGS.fading.name],
		"Abilities": "Whenever your draw this card, lose 1 {immersion}\n{unplayable}",
		"Cost": 'U',
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_keywords": ["fading"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.PLAYER
		},
		"_amounts": {
			"immersion_amount": -1,
		},
		"_is_unplayable": true,
	},
	"Apathy": {
		"Type": "Perturbation",
		"Tags": [],
		"Abilities": "Whenever the deck is reshuffled, put this card on top, if it's in it.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_keywords": [],
	},
}

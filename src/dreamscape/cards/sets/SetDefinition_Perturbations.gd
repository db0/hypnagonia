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
		"Cost": 4,
		"_illustration": "DioBal",
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
		"_illustration": "DioBal",
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
		"_illustration": "Maria Thoukydidou",
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
	"Dubious Painkillers": {
		"Type": "Perturbation",
		"Tags": [Terms.GENERIC_TAGS.exert.name],
		"Abilities": "Take {exert_amount} {anxiety}\nGain {health_amount} max {anxiety} threshold.\n{forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_keywords": [],
		"_amounts": {
			"exert_amount": 12,
			"health_amount": 3
		},
	},
	"Scattered Dreams": {
		"Type": "Perturbation",
		"Tags": [Terms.ACTIVE_EFFECTS.drain.name],
		"Abilities": "If this card is in your hand at the end of the turn, gain {effect_stacks} {drain}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_amounts": {
			"effect_stacks": 1
		},
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.drain.name: Terms.PLAYER
		},
	},
	"Cringeworthy Memory": {
		"Type": "Perturbation",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {exert_amount} {anxiety}\n{forget}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_amounts": {
			"exert_amount": 1
		},
		"_keywords": ["forget"]
	},
	"Dream Fragment": {
		"Type": "Perturbation",
		"Tags": [Terms.GENERIC_TAGS.exert.name],
		"Abilities": "{release}\nTake {exert_amount} {anxiety}.\nDraw {draw_amount} card.\nPut 1 Dream Fragment to your hand.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_amounts": {
			"exert_amount": 1,
			"draw_amount": 1
		},
		"_keywords": ["release"]
	},
	"Distracted": {
		"Type": "Perturbation",
		"Tags": [],
		"Abilities": "While in hand, you cannot play cards that cost {immersion_cost} or more {immersion}",
		"Cost": "U",
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_amounts": {
			"immersion_cost": 2
		},
		"_keywords": [],
	},
	"Painful Vision": {
		"Type": "Perturbation",
		"Tags": [Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "While in hand, at the end of the turn, take {exert_amount} {anxiety}\nPlay: {forget}.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Perturbation",
		"_amounts": {
			"exert_amount": 3
		},
		"_keywords": ["forget"]
	},
}

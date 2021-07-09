#class_name CoreDefinitions
extends Reference

const SET = "Core Set"
const CARDS := {
	"Confidence": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain 5 Confidence.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Starting",
	},
	"Interpretation": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Interpret target Torment for 6.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Starting",
	},
	"Out of Reach": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Gain 1 Untouchable.",
		"Cost": 3,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
	},
	"Dive-in": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.risky.name],
		"Abilities": "Gain 2 Shaken. Your next interpretation is doubled.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.PLAYER
		},
	},
	"Safety of Air": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "Relax for 4. Forget",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"Nothing to Fear": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.risky.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 1 Immersion at the start of each turn."\
			+ " Increase all anxiety taken from Torment intents by 2.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"Confounding Movements": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Gain 6 confidence. Apply 1 Confusion to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"Noisy Whip": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Interpret target Torment for 5 and apply Confusion.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"Inner Justice": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 4 Immersion",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Starting",
	},
	"Whirlwind": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Interpret target Torment for 3. Repeat 3 times",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
	},
	"Overview": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Remove all Perplexity from target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"War Paint": { #TODO
		"Type": "Control",
		"Tags": [],
		"Abilities": "All interpretation is increased by 1 this turn.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"Rubber Eggs": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the start of your turn, interpret a random Confused Torment for 6.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
	},
	"The Joke": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.disempower.name],
		"Abilities": "Target a Torment. If it's not confused. Apply 3 Confusion."\
			+ " If it is confused, interpret it for 10.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
	},
	"Nunclucks": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Increase your interpretation by 1, for each stack of Confusion on the Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Rare",
	},
	"Gummiraptor": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Interpret Torment for 10."\
			+ "Repeat this if Torments are not going to be inflicting any anxiety this turn.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
	},
	"Cocky Retort": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Gain 8 confidence. Draw a card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"Rapid Encriclement": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Apply 2 Shaken to all Torments.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"Barrel Through": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.risky.name, Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Interpret a Torment for 8. If the Torment is Shaken, interpet all other Torments for 12.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.vulnerable.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
	},
	"Intimidate": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Apply 2 Doubt to all Torments",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"Cheeky Approach": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Gain 10 Confidence, Apply 3 Doubt to target Torment.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
	},
	"Laugh at Danger": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "After a Torment inflicts anxiety, it gains 1 Doubt.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Rare",
	},
	"Towering Presence": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Interpret a Torment equal to your current Confidence",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"Unassailable": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply Doubt, gain 1 Confidence.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Rare",
	},
	"Audacity": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain 8 Confidence. Apply 1 Courage.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Common",
	},
	"Boast": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fleeting.name],
		"Abilities": "Double your Confidence. Remove all Courage. Forget.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Rare",
	},
	"Solid Understanding": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Gain 5 Confidence. Interpret Torment for 5.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"No Second Thoughts": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain 2 Courage",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
	},
	"High Morale": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Interpret Torment for 6. Draw a Courage card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
	},
	"Confident Slap": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Apply 5 Doubt to target Torment.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"Swoop": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Interpret for 8. If Untouchable, interpret for 12 instead.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
	},
	"Drag and Drop": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.impervious.name],
		"Abilities": "Interpret Torment for 10. If Torment is Overcome, gain 1 Untouchable.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
	},
	"Running Start": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Interpret for 5. Draw 1 Untouchable card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Common",
	},
	"Master of Skies": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Whenever you gain Untouchable. Gain 1 Immersion.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Rare",
	},
	"Zen of Flight": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.relax.name],
		"Abilities": "At the end of each turn, Relax 1. If Untouchable, Relax 1 extra.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.impervious.name: Terms.PLAYER
		},
		"_rarity": "Rare",
	},
	"Loop de loop": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 7 Confidence. Gain 1 Fascination.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Common",
	},
	"Headless": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "Gain 4 Fascination.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.buffer.name: Terms.PLAYER
		},
		"_rarity": "Common",
	},
	"Utterly Ridiculous": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Can only be played if there's a total of 6 Confusion or more among Torments\n"\
				+ "Interpret all Torments for 20",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
	},
	"Ventriloquism": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "Interpret a Torment for 8. Draw a Confusion card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Common",
	},
	"unnamed_card_1": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fleeting.name],
		"Abilities": "Shuffle your discard pile into your deck. Play a Random card from your deck. Forget.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"unnamed_card_2": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.poison.name],
		"Abilities": "Each Torment is applied Doubt equals to its Confusion x2",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY,
			Terms.ACTIVE_EFFECTS.poison.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
	},
	"unnamed_card_3": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Interpret all Torments for 8",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
	},
	"Absurdity Unleashed": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Whenever you apply Confusion to a Torment, Interpret it for 4",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.disempower.name: Terms.ENEMY
		},
		"_rarity": "Uncommon",
	},
	"Dread": {
		"Type": "Perturbation",
		"Tags": [],
		"Abilities": "Release",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Temporary",
	},
}

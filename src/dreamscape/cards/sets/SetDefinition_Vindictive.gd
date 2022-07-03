#class_name CoreDefinitions
extends Reference

const SET = "Vindictive"
const CARDS := {
	"Keep in Mind": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.frozen.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{beneficial_integer} random card in your hand becomes {frozen}\n{forget}.",
		"Cost": 0,
		"_illustration": "axilirate",
		"_rarity": "Basic",
		"_keywords": ['forget'],
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
		"_illustration": "axilirate",
		"_rarity": "Basic",
		"_keywords": ['forget'],
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
		"_illustration": "axilirate",
		"_rarity": "Basic",
		"_keywords": ['forget'],
		"_amounts": {
			"beneficial_integer": 1,
		},
		"_is_upgrade": true,
	},
	"Memento of Anger": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If {frozen}, also apply {effect_stacks} {burn}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "frozen"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 8,
			"effect_stacks": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Memento of Anger +",
			"* Memento of Anger *",
		],
	},
	"+ Memento of Anger +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If {frozen}, also apply {effect_stacks} {burn}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "frozen"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 11,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"* Memento of Anger *": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.burn.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If {frozen}, also apply {effect_stacks} {burn}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "frozen"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.burn.name: Terms.ENEMY,
		},
		"_amounts": {
			"damage_amount": 8,
			"effect_stacks": 4,
		},
		"_is_upgrade": true,
	},
	"Memento of Safety": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If {frozen}, gain {defence_amount2} {defence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "frozen"],
		"_amounts": {
			"defence_amount": 8,
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
				+ "If {frozen}, gain {defence_amount2} {defence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "frozen"],
		"_amounts": {
			"defence_amount": 11,
			"defence_amount2": 3,
		},
		"_is_upgrade": true,
	},
	"% Memento of Safety %": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If {frozen}, gain {defence_amount2} {defence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "frozen"],
		"_amounts": {
			"defence_amount": 6,
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
		"_amounts": {
			"draw_amount": 3,
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
		"_amounts": {
			"draw_amount": 4,
			"discard_amount": 1,
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
		"_keywords": ["interpretation"],
		"_amounts": {
			"draw_amount": 7,
			"discard_amount": 2,
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
		"_is_upgrade": true,
	},
	"Hand of Grudge": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
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
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "Gain {effect_stacks} {thorns} for each card in hand (including self)",
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
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "Gain {effect_stacks} {thorns} for each card in hand (including self)",
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
		"Tags": [],
		"Abilities": "At the end of the turn, gain {concentration_effect} {defence} for each card in hand.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_effect": 2.0,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Vestige of Warmth @",
			"Last Vestige of Warmth",
		],
	},
	"@ Vestige of Warmth @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the end of the turn, gain {concentration_effect} {defence} for each card in hand.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_effect": 2.0,
		},
		"_is_upgrade": true,
	},
	"Last Vestige of Warmth": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the end of the turn, gain {concentration_effect} {defence} for each card in hand.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_effect": 2.5,
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
		"Abilities": "At the start of the turn, {concentration_stacks} random card in your hand becomes {frozen}.",
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
		"Abilities": "At the start of the turn, {concentration_stacks} random card in your hand becomes {frozen}.",
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
		"Abilities": "At the start of the turn, {concentration_stacks} random card in your hand becomes {frozen}.",
		"Cost": 3,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["frozen"],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"Stewing": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {defence}."\
				+ "Every turn this card starts in your hand, increase this amount by {increase_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"increase_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"^ Stewing ^",
			"+ Stewing +",
		],
	},
	"^ Stewing ^": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Gain {defence_amount} {defence}."\
				+ "Every turn this card starts in your hand, increase this amount by {increase_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"increase_amount": 1,
		},
		"_is_upgrade": true,
	},
	"+ Stewing +": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {defence}."\
				+ "Every turn this card starts in your hand, increase this amount by {increase_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 11,
			"increase_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Reactionary": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If the Torment intends to {stress} for {min_requirements_amount} or more, gain {effect_stacks} {thorns}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 3,
			"effect_stacks": 2,
			"min_requirements_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Reactionary *",
			"+ Reactionary +",
		],
	},
	"* Reactionary *": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If the Torment intends to {stress} for {min_requirements_amount} or more, gain {effect_stacks} {thorns}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 3,
			"effect_stacks": 4,
			"min_requirements_amount": 1,
		},
		"_is_upgrade": true,
	},
	"+ Reactionary +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "If the Torment intends to {stress} for {min_requirements_amount} or more, gain {effect_stacks} {thorns}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"damage_amount": 6,
			"effect_stacks": 2,
			"min_requirements_amount": 1,
		},
		"_is_upgrade": true,
	},
	"That's Going in the Book": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "Gain {effect_stacks} {thorns}",
		"Cost": 1,
		"_illustration": "Db0 via midjourney.com",
		"_rarity": "Common",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 4,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* That's Going in the Book *",
			"~ That's Going in the Book ~",
		],
	},
	"* That's Going in the Book *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "Gain {effect_stacks} {thorns}",
		"Cost": 1,
		"_illustration": "Db0 via midjourney.com",
		"_rarity": "Common",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 5,
		},
		"_is_upgrade": true,
	},
	"~ That's Going in the Book ~": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Gain {effect_stacks} {thorns}\n{forget}",
		"Cost": 1,
		"_illustration": "Db0 via midjourney.com",
		"_rarity": "Common",
		"_keywords": ['forget'],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"effect_stacks": 8,
		},
		"_is_upgrade": true,
	},
	"Note-Taking": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "At the start of each turn, gain {concentration_stacks} {thorns}",
		"Cost": 1,
		"_illustration": "Db0 via midjourney.com",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Note-Taking *",
			"@ Note-Taking @",
		],
	},
	"* Note-Taking *": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "At the start of each turn, gain {concentration_stacks} {thorns}",
		"Cost": 1,
		"_illustration": "Db0 via midjourney.com",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"concentration_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"@ Note-Taking @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "At the start of each turn, gain {concentration_stacks} {thorns}",
		"Cost": 0,
		"_illustration": "Db0 via midjourney.com",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Vengeance": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for as much as your {thorns} stacks + {beneficial_integer}. This bypasses {defence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"beneficial_integer": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Vengeance +",
			"Unstoppable Vengeance",
		],
	},
	"+ Vengeance +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for as much as your {thorns} stacks + {beneficial_integer}. This bypasses {defence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"beneficial_integer": 5
		},
		"_is_upgrade": true,
	},
	"Unstoppable Vengeance": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name],
		"Abilities": "Gain {effect_stacks} {thorns}. {damage} for as much as your {thorns} stacks + {beneficial_integer}. This bypasses {defence}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"beneficial_integer": 2,
			"effect_stacks": 1
		},
		"_is_upgrade": true,
	},
	"Planning": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {thorns} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"draw_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Planning +",
			"! Planning !",
		],
	},
	"+ Planning +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {thorns} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 11,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"! Planning !": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "{damage} for {damage_amount}.\nDraw {draw_amount} {thorns} card.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER
		},
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9,
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Saved for Later": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.empower.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If you have {thorns}, gain {effect_stacks} {empower}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.empower.name: Terms.PLAYER,
		},
		"_amounts": {
			"defence_amount": 8,
			"effect_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Saved for Later +",
			"* Saved for Later *",
		],
	},
	"+ Saved for Later +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.empower.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If you have {thorns}, gain {effect_stacks} {empower}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.empower.name: Terms.PLAYER,
		},
		"_amounts": {
			"defence_amount": 11,
			"effect_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"* Saved for Later *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.empower.name],
		"Abilities": "Gain {defence_amount} {defence}.\n"\
				+ "If you have {thorns}, gain {effect_stacks} {empower}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
			Terms.ACTIVE_EFFECTS.empower.name: Terms.PLAYER,
		},
		"_amounts": {
			"defence_amount": 8,
			"effect_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Schadenfreude": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "At the start of each turn, gain {concentration_stacks} {armor} "\
		 		+ "for every {concentration_divider} {enemy_health} all Torments received during their own turn.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ['enemy_health'],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_divider": 5.0,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"Bitter Schadenfreude",
			"@ Schadenfreude @",
		],
	},
	"@ Schadenfreude @": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "At the start of each turn, gain {concentration_stacks} {armor} "\
		 		+ "for every {concentration_divider} {enemy_health} all Torments received during their own turn.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ['enemy_health'],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_divider": 5,
		},
		"_is_upgrade": true,
	},
	"Bitter Schadenfreude": {
		"Type": "Concentration",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name],
		"Abilities": "At the start of each turn, gain {concentration_stacks} {armor} "\
		 		+ "for every {concentration_divider} {enemy_health} all Torments received during their own turn.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ['enemy_health'],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER,
		},
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_divider": 4,
		},
		"_is_upgrade": true,
	},
	"Reckoning Time": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments as much as your {thorns} stacks * {multiplier_amount}.\n"\
		 		+ "Decrease your {thorns} stacks by {detrimental_percentage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"multiplier_amount": 2.0,
			"detrimental_percentage": 0.3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Reckoning Time +",
			"* Reckoning Time *",
		],
	},
	"+ Reckoning Time +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments as much as your {thorns} stacks * {multiplier_amount}.\n"\
		 		+ "Decrease your {thorns} stacks by {detrimental_percentage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"multiplier_amount": 2.0,
			"detrimental_percentage": 0.3,
		},
		"_is_upgrade": true,
	},
	"* Reckoning Time *": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all Torments as much as your {thorns} stacks * {multiplier_amount}.\n"\
		 		+ "Decrease your {thorns} stacks by {detrimental_percentage}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": [],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"multiplier_amount": 2.5,
			"detrimental_percentage": 0.2,
		},
		"_is_upgrade": true,
	},
	"Prepared": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.fading.name,
			Terms.GENERIC_TAGS.slumber.name,
		],
		"Abilities": "Gain {defence_amount} {confidence}\n{forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "forget"],
		"_amounts": {
			"defence_amount": 11
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Prepared +",
			"^ Prepared ^",
		],
	},
	"+ Prepared +": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.fading.name,
			Terms.GENERIC_TAGS.slumber.name,
		],
		"Abilities": "Gain {defence_amount} {confidence}\n{forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "forget"],
		"_amounts": {
			"defence_amount": 15
		},
		"_is_upgrade": true,
	},
	"^ Prepared ^": {
		"Type": "Control",
		"Tags": [
			Terms.GENERIC_TAGS.fading.name,
			Terms.GENERIC_TAGS.slumber.name,
			Terms.GENERIC_TAGS.alpha.name,
		],
		"Abilities": "Gain {defence_amount} {confidence}\n{forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_avoid_normal_discard": true,
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "forget"],
		"_amounts": {
			"defence_amount": 11
		},
		"_is_upgrade": true,
	},
	"The Last Straw": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Take {anxiety} equal to your {thorns}/{beneficial_float}.\nIncrease your {thorns} by {beneficial_percentage}\n{forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ['forget'],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"beneficial_percentage": 2.0,
			"beneficial_float": 2.0,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* The Last Straw *",
			"% The Last Straw %",
		],
	},
	"* The Last Straw *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Take {anxiety} equal to your {thorns}/{beneficial_float}.\nIncrease your {thorns} by {beneficial_percentage}\n{forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ['forget'],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"beneficial_percentage": 2.5,
			"beneficial_float": 2.0,
		},
		"_is_upgrade": true,
	},
	"% The Last Straw %": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.thorns.name, Terms.GENERIC_TAGS.exert.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Take {anxiety} equal to your {thorns}/{beneficial_float}.\nIncrease your {thorns} by {beneficial_percentage}\n{forget}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ['forget'],
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.thorns.name: Terms.PLAYER,
		},
		"_amounts": {
			"beneficial_percentage": 2.0,
			"beneficial_float": 3.0,
		},
		"_is_upgrade": true,
	},
}


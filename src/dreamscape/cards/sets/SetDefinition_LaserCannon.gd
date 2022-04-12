#class_name CoreDefinitions
extends Reference

const SET = "Laser Cannon"
const CARDS := {
	"Cannon": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.marked.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> HiCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 8,
			"effect_stacks": 1,
			"fuse_amount": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Cannon +",
			"* Cannon *",
			"Ω Cannon Ω",
		],
		"_fuses_into": "HiCannon"
	},
	"+ Cannon +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.marked.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> HiCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 10,
			"effect_stacks": 1,
			"fuse_amount": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_is_upgrade": true,
		"_fuses_into": "HiCannon"
	},
	"* Cannon *": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.marked.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> HiCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 8,
			"effect_stacks": 2,
			"fuse_amount": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_is_upgrade": true,
		"_fuses_into": "HiCannon"
	},
	"Ω Cannon Ω": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.marked.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> HiCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 9,
			"effect_stacks": 1,
			"fuse_amount": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_is_upgrade": true,
		"_fuses_into": "HiCannon"
	},
	"HiCannon": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.marked.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> MegaCannon",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 16,
			"effect_stacks": 2,
			"fuse_amount": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_upgrades": [
			"+ HiCannon +",
		],
		"_fuses_into": "MegaCannon",
	},
	"+ HiCannon +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.marked.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> MegaCannon",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 20,
			"effect_stacks": 2,
			"fuse_amount": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_is_upgrade": true,
		"_fuses_into": "MegaCannon",
	},
	"MegaCannon": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.marked.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 21,
			"effect_stacks": 4,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_upgrades": [
			"+ MegaCannon +",
		],
	},
	"+ MegaCannon +": {
		"Type": "Action",
		"Tags": [Terms.ACTIVE_EFFECTS.marked.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 26,
			"effect_stacks": 4,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_is_upgrade": true,
	},
	"Vulcan": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan2",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 4,
			"chain_amount": 2,
			"fuse_amount": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Vulcan +",
			"@ Vulcan @",
			"% Vulcan %",
		],
		"_fuses_into": "Vulcan2"
	},
	"+ Vulcan +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan2",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 5,
			"chain_amount": 2,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Vulcan2"
	},
	"@ Vulcan @": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan2",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 3,
			"chain_amount": 2,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Vulcan2"
	},
	"% Vulcan %": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan2",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 2,
			"chain_amount": 5,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Vulcan2"
	},
	"Vulcan2": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan3",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 4,
			"chain_amount": 3,
			"fuse_amount": 2,
		},
		"_upgrades": [
			"+ Vulcan2 +",
		],
		"_fuses_into": "Vulcan2"
	},
	"+ Vulcan2 +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan3",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["interpretation", "fuse"],
		"_amounts": {
			"damage_amount": 4,
			"chain_amount": 4,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Vulcan2"
	},
	"Vulcan3": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"chain_amount": 3,
			"fuse_amount": 2,
		},
		"_upgrades": [
			"+ Vulcan2 +",
		],
	},
	"+ Vulcan3 +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.chain.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan3",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"chain_amount": 4,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Photon Shield": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Fuse {fuse_amount} -> Lumen Shield",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"defence_amount": 7,
			"fuse_amount": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Photon Shield +",
			"@ Photon Shield @",
			"Ω Photon Shield Ω",
		],
		"_fuses_into": "Lumen Shield"
	},
	"+ Photon Shield +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Fuse {fuse_amount} -> Lumen Shield",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"defence_amount": 10,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Lumen Shield"
	},
	"@ Photon Shield @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Fuse {fuse_amount} -> Lumen Shield",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"defence_amount": 5,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Lumen Shield"
	},
	"Ω Photon Shield Ω": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Fuse {fuse_amount} -> Lumen Shield",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"defence_amount": 8,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Lumen Shield"
	},
	"Lumen Shield": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fortify}\n"\
				+ "Fuse {fuse_amount} -> Plasma Shield",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"defence_amount": 15,
			"effect_stacks": 1,
			"fuse_amount": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Lumen Shield +",
		],
		"_fuses_into": "Plasma Shield"
	},
	"+ Lumen Shield +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fortify}\n"\
				+ "Fuse {fuse_amount} -> Plasma Shield",
		"Cost": 2,
		"_illustration": "Nobody",
			"_rarity": "Special",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"defence_amount": 18,
			"effect_stacks": 1,
			"fuse_amount": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_is_upgrade": true,
		"_fuses_into": "Plasma Shield"
	},
	"Plasma Shield": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fortify}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 22,
			"effect_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Plasma Shield +",
		],
	},
	"+ Plasma Shield +": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fortify}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 27,
			"effect_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_is_upgrade": true,
	},
	"Photon Blade": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "The next {discount_uses} {control} card you play "\
				+ "costs -{discount_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 11,
			"discount_amount": 1,
			"discount_uses": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Photon Blade +",
			"% Photon Blade %",
			"= Photon Blade =",
		],
	},
	"+ Photon Blade +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "The next {discount_uses} {control} cards you play "\
				+ "costs -{discount_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 15,
			"discount_amount": 1,
			"discount_uses": 1,
		},
		"_is_upgrade": true,
	},
	"% Photon Blade %": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "The next {discount_uses} {control} cards you play "\
				+ "costs -{discount_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 11,
			"discount_amount": 3,
			"discount_uses": 1,
		},
		"_is_upgrade": true,
	},
	"= Photon Blade =": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "The next {discount_uses} {control} cards you play "\
				+ "costs -{discount_amount} {immersion}",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 9,
			"discount_amount": 1,
			"discount_uses": 2,
		},
		"_is_upgrade": true,
	},
	"Charged Shot": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "While in your hand, increase {interpretation} by {increase_amount} "\
				+ "every time another card is played.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"increase_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Charged Shot +",
			"^ Charged Shot ^",
			"% Charged Shot %",
		],
	},
	"+ Charged Shot +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "While in your hand, increase {interpretation} by {increase_amount} "\
				+ "every time another card is played.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"increase_amount": 1,
		},
		"_is_upgrade": true,
	},
	"^ Charged Shot ^": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "While in your hand, increase {interpretation} by {increase_amount} "\
				+ "every time another card is played.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"increase_amount": 1,
		},
		"_is_upgrade": true,
	},
	"% Charged Shot %": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "While in your hand, increase {interpretation} by {increase_amount} "\
				+ "every time another card is played.",
		"Cost": 2,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 2,
			"increase_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Blinding Flash": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name, Terms.GENERIC_TAGS.startup.name],
		"Abilities": "{forget}\n{startup}: Gain {effect_stacks} {armor}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER
		},
		"_upgrade_threshold_modifier": -2,
		"_upgrades": [
			"* Blinding Flash *",
			"Ω Blinding Flash Ω",
			"Searing Flash",
		],
	},
	"* Blinding Flash *": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name, Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{forget}\n{startup}: Gain {effect_stacks} {armor}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 4,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER
		},
		"_is_upgrade": true,
	},
	"Ω Blinding Flash Ω": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name, Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{forget}\n{startup}: Gain {effect_stacks} {armor}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER
		},
		"_is_upgrade": true,
	},
	"Searing Flash": {
		"Type": "Control",
		"Tags": [Terms.ACTIVE_EFFECTS.armor.name, Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "Draw {draw_amount} cards. {forget}\n{startup}: Gain {effect_stacks} {armor}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 1,
			"effect_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.armor.name: Terms.PLAYER
		},
		"_is_upgrade": true,
	},
	"Dark Recovery": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.relax.name],
		"Abilities": "{forget}\n{startup}: {relax} for {healing_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 3
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Dark Recovery +",
			"Ghost Recovery",
			"Ω Dark Recovery Ω",
		],
	},
	"+ Dark Recovery +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.relax.name],
		"Abilities": "{forget}\n{startup}: {relax} for {healing_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 5
		},
		"_is_upgrade": true,
	},
	"Ω Dark Recovery Ω": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.relax.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{forget}\n{startup}: {relax} for {healing_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 3
		},
		"_is_upgrade": true,
	},
	"Ghost Recovery": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name,Terms.GENERIC_TAGS.relax.name],
		"Abilities": "Draw {draw_amount} cards. {forget}\n{startup}: {relax} for {healing_amount}.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"healing_amount": 3,
			"draw_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Dark Approach": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "{forget}\n{startup}: Draw {draw_amount} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 2,
		},
		"_upgrade_threshold_modifier": -3,
		"_upgrades": [
			"! Dark Approach !",
			"Ghost Approach",
			"Ω Dark Approach Ω",
		],
	},
	"! Dark Approach !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "{forget}\n{startup}: Draw {draw_amount} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 3,
		},
		"_is_upgrade": true,
	},
	"Ω Dark Approach Ω": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{forget}\n{startup}: Draw {draw_amount} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Ghost Approach": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Draw {draw_amount2} cards. {forget}\n{startup}: Draw {draw_amount} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 2,
			"draw_amount2": 1,
		},
		"_is_upgrade": true,
	},
	"Widebeam": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{forget} the bottom {forget_amount} card of your draw pile. "\
				+ "{damage} for {damage_amount}.\n",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "forget"],
		"_amounts": {
			"damage_amount": 9,
			"forget_amount": 1,
		},
		"_upgrade_threshold_modifier": -2,
		"_upgrades": [
			"+ Widebeam +",
			"~ Widebeam ~",
			"^ Widebeam ^",
		],
	},
	"+ Widebeam +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{forget} the last {forget_amount} card of your draw pile. "\
				+ "{damage} for {damage_amount}.\n",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "forget"],
		"_amounts": {
			"damage_amount": 11,
			"forget_amount": 1,
		},
		"_is_upgrade": true,
	},
	"^ Widebeam ^": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "{forget} the last {forget_amount} card of your draw pile. "\
				+ "{damage} for {damage_amount}.\n",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "forget"],
		"_amounts": {
			"damage_amount": 9,
			"forget_amount": 1,
		},
		"_is_upgrade": true,
	},
	"~ Widebeam ~": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.slumber.name],
		"Abilities": "{forget} the last {forget_amount} card of your draw pile. "\
				+ "{damage} for {damage_amount}.\n{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation", "forget"],
		"_amounts": {
			"damage_amount": 18,
			"forget_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Precision": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.ACTIVE_EFFECTS.strengthen.name],
		"Abilities": "{forget}\n{startup}: Gain {effect_stacks} {strengthen}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Precision *",
			"Ω Precision Ω",
			"@ Precision @",
		],
	},
	"* Precision *": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.ACTIVE_EFFECTS.strengthen.name],
		"Abilities": "{forget}\n{startup}: Gain {effect_stacks} {strengthen}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER
		},
		"_is_upgrade": true,
	},
	"Ω Precision Ω": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.ACTIVE_EFFECTS.strengthen.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{forget}\n{startup}: Gain {effect_stacks} {strengthen}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER
		},
		"_is_upgrade": true,
	},
	"@ Precision @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name],
		"Abilities": "{forget}\n{startup}: Gain {effect_stacks} {strengthen}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["forget"],
		"_amounts": {
			"effect_stacks": 2,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.strengthen.name: Terms.PLAYER
		},
		"_is_upgrade": true,
	},
	"Nano-Machines": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "{damage} for {damage_amount}. Draw {draw_amount} cards."\
				+ "Discard all drawn cards without {fusion}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"draw_amount": 4,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! Nano-Machines !",
			"+ Nano-Machines +",
		],
	},
	"+ Nano-Machines +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "{damage} for {damage_amount}. Draw {draw_amount} cards."\
				+ "Discard all drawn cards without {fusion}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 8,
			"draw_amount": 4,
		},
		"_is_upgrade": true,
	},
	"! Nano-Machines !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.insomnia.name],
		"Abilities": "{damage} for {damage_amount}. Draw {draw_amount} cards."\
				+ "Discard all drawn cards without {fusion}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 4,
			"draw_amount": 6,
		},
		"_is_upgrade": true,
	},
	"Spare Lens": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the end of the turn. add {concentration_stacks} random common {fusion} card "\
				+ " to the top of the draw pile,",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": [],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_upgrade_threshold_modifier": -2,
		"_upgrades": [
			"@ Spare Lens @",
			"^ Spare Lens ^",
			"! Spare Lens !",
		],
	},
	"@ Spare Lens @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the end of the turn. add {concentration_stacks} random common {fusion} card "\
				+ " to the top of the draw pile,",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": [],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"^ Spare Lens ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "At the end of the turn. add {concentration_stacks} random common {fusion} card "\
				+ " to the top of the draw pile,",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": [],
		"_amounts": {
			"concentration_stacks": 1,
		},
		"_is_upgrade": true,
	},
	"! Spare Lens !": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "At the end of the turn. add {concentration_stacks} random common {fusion} card "\
				+ " to the top of the draw pile,",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": [],
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"Heat Venting": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Gain {concentration_defence} {defence} whenever you fuse {fusion} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_defence": 7,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Heat Venting @",
			"^ Heat Venting ^",
			"High Heat Venting",
		],
	},
	"@ Heat Venting @": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Gain {concentration_defence} {defence} whenever you fuse {fusion} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_defence": 7,
		},
		"_is_upgrade": true,
	},
	"^ Heat Venting ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Gain {concentration_defence} {defence} whenever you fuse {fusion} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_defence": 7,
		},
		"_is_upgrade": true,
	},
	"High Heat Venting": {
		"Type": "Concentration",
		"Tags": [],
		"Abilities": "Gain {concentration_defence} {defence} whenever you fuse {fusion} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence", "fuse"],
		"_amounts": {
			"concentration_stacks": 1,
			"concentration_defence": 10,
		},
		"_is_upgrade": true,
	},
	"Streamlining": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Draw {concentration_stacks} cards whenever you fuse {fusion} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["fuse"],
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"@ Streamlining @",
			"^ Streamlining ^",
			"! Streamlining !",
		],
	},
	"@ Streamlining @": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Draw {concentration_stacks} cards whenever you fuse {fusion} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["fuse"],
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"^ Streamlining ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "Draw {concentration_stacks} cards whenever you fuse {fusion} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["fuse"],
		"_amounts": {
			"concentration_stacks": 2,
		},
		"_is_upgrade": true,
	},
	"! Streamlining !": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.swift.name],
		"Abilities": "Draw {concentration_stacks} cards whenever you fuse {fusion} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["fuse"],
		"_amounts": {
			"concentration_stacks": 3,
		},
		"_is_upgrade": true,
	},
	"Brooding": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "{forget} {forget_amount} card. Draw {draw_amount} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 2,
			"forget_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! Brooding !",
			"= Brooding =",
			"@ Brooding @",
		],
	},
	"! Brooding !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.swift.name],
		"Abilities": "{forget} {forget_amount} card. Draw {draw_amount} cardss.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 3,
			"forget_amount": 1,
		},
		"_is_upgrade": true,
	},
	"= Brooding =": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "{forget} {forget_amount} card. Draw {draw_amount} cards.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 2,
			"forget_amount": 1,
		},
		"_is_upgrade": true,
	},
	"@ Brooding @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "{forget} {forget_amount} card. Draw {draw_amount} card.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"draw_amount": 2,
			"forget_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Recycling": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {defence}. Gain {defence_amount2} {defence},"\
				+ " for each {fusion} fusion you've achieved this ordeal.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
			"defence_amount2": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Recycling +",
			"% Recycling %",
		],
	},
	"+ Recycling +": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {defence}. Gain {defence_amount2} {defence},"\
				+ " for each {fusion} fusion you've achieved this ordeal.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 11,
			"defence_amount2": 3,
		},
		"_is_upgrade": true,
	},
	"% Recycling %": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {defence}. Gain {defence_amount2} {defence},"\
				+ " for each {fusion} fusion you've achieved this ordeal.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 6,
			"defence_amount2": 6,
		},
		"_is_upgrade": true,
	},
	"Universal Component": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "This card will fuse with any other available {fusion} card.\n"\
				+ "Whenever this card fuses, draw {draw_amount} card and gain {immersion_amount} {immersion}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["fuse"],
		"_amounts": {
			"draw_amount": 1,
			"immersion_amount": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! Universal Component !",
			"@ Universal Component @",
		],
		"_fuses_into": "Fusion Grenade"
	},
	"! Universal Component !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "This card will fuse with any other available {fusion} card.\n"\
				+ "Whenever this card fuses, draw {draw_amount} card and gain {immersion_amount} {immersion}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["fuse"],
		"_amounts": {
			"draw_amount": 3,
			"immersion_amount": 1,
		},
		"_is_upgrade": true,
		"_fuses_into": "Fusion Grenade"
	},
	"@ Universal Component @": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.purpose.name],
		"Abilities": "This card will fuse with any other available {fusion} card.\n"\
				+ "Whenever this card fuses, draw {draw_amount} card and gain {immersion_amount} {immersion}.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["fuse"],
		"_amounts": {
			"draw_amount": 1,
			"immersion_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Fusion Grenade"
	},
	"Fusion Grenade": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all torments for {damage_amount}\n{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["fuse"],
		"_amounts": {
			"damage_amount": 30,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Fusion Grenade +",
		],
	},
	"+ Fusion Grenade +": {
		"Type": "Action",
		"Tags": [],
		"Abilities": "{damage} all torments for {damage_amount}\n{forget}",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Special",
		"_keywords": ["fuse"],
		"_amounts": {
			"damage_amount": 40,
		},
		"_is_upgrade": true,
	},
	"Light Jump": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Put {discard_amount} cards to the bottom of the draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 7,
			"discard_amount": 1,
		},
		"_upgrade_threshold_modifier": 3,
		"_upgrades": [
			"+ Light Jump +",
			"@ Light Jump @",
		],
	},
	"+ Light Jump +": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Put {discard_amount} cards to the bottom of the draw pile.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 10,
			"discard_amount": 1,
		},
		"_is_upgrade": true,
	},
	"@ Light Jump @": {
		"Type": "Control",
		"Tags": [],
		"Abilities": "Gain {defence_amount} {confidence}\n"\
				+ "Put {discard_amount} cards to the bottom of the draw pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Basic",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 4,
			"discard_amount": 1,
		},
		"_is_upgrade": true,
	},
	"Focus Calibration": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "At the start of the next {concentration_stacks} turns gain {concentration_immersion} {immersion}\n"\
				+ "and {forget} the bottom {concentration_forget} cards of your draw pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"concentration_stacks": 4,
			"concentration_immersion": 1,
			"concentration_forget": 1,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"^ Focus Calibration ^",
			"+ Focus Calibration +",
		],
	},
	"^ Focus Calibration ^": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.frozen.name, Terms.GENERIC_TAGS.alpha.name],
		"Abilities": "At the start of the next {concentration_stacks} turns gain {concentration_immersion} {immersion}\n"\
				+ "and {forget} the bottom {concentration_forget} cards of your draw pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"concentration_stacks": 4,
			"concentration_immersion": 1,
			"concentration_forget": 1,
		},
		"_is_upgrade": true,
	},
	"+ Focus Calibration +": {
		"Type": "Concentration",
		"Tags": [Terms.GENERIC_TAGS.slumber.name, Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "At the start of the next {concentration_stacks} turns gain {concentration_immersion} {immersion}\n"\
				+ "and {forget} the bottom {concentration_forget} cards of your draw pile.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["forget"],
		"_amounts": {
			"concentration_stacks": 7,
			"concentration_immersion": 1,
			"concentration_forget": 1,
		},
		"_is_upgrade": true,
	},
	"Quick Dash": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.scry.name],
		"Abilities": "{scry} {scry_amount}. Select any number to put to the bottom. "\
				+ "Draw {draw_amount} card.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": [],
		"_amounts": {
			"draw_amount": 1,
			"scry_amount": 3,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"! Quick Dash !",
			"+ Quick Dash +",
		],
	},
	"! Quick Dash !": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.scry.name, Terms.GENERIC_TAGS.init.name],
		"Abilities": "{scry} {scry_amount}. Select any number to put to the bottom. "\
				+ "Draw {draw_amount} cards.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": [],
		"_amounts": {
			"draw_amount": 3,
			"scry_amount": 2,
		},
		"_is_upgrade": true,
	},
	"+ Quick Dash +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.swift.name, Terms.GENERIC_TAGS.scry.name],
		"Abilities": "{scry} {scry_amount}. Select any number to put to the bottom. "\
				+ "Draw {draw_amount} card.",
		"Cost": 0,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": [],
		"_amounts": {
			"draw_amount": 1,
			"scry_amount": 6,
		},
		"_is_upgrade": true,
	},
}


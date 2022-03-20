#class_name CoreDefinitions
extends Reference

const SET = "Laser Cannon"
const CARDS := {
	"Cannon": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> HiCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
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
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> HiCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
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
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> HiCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
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
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> HiCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
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
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> MegaCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 14,
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
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}\n"\
				+ "Fuse {fuse_amount} -> MegaCannon",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 17,
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
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 24,
			"effect_stacks": 3,
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
		"Tags": [],
		"Abilities": "{damage} for {damage_amount}. Apply {effect_stacks} {marked}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 29,
			"effect_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.marked.name: Terms.ENEMY
		},
		"_is_upgrade": true,
	},
	"Vulcan": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan2",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 4,
			"chain_amount": 2,
			"fuse_amount": 2,
		},
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"+ Vulcan +",
			"@ Vulcan @",
			"Ω Vulcan Ω",
		],
		"_fuses_into": "Vulcan2"
	},
	"+ Vulcan +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan2",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
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
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan2",
		"Cost": 9,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 3,
			"chain_amount": 2,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Vulcan2"
	},
	"Ω Vulcan Ω": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.GENERIC_TAGS.omega.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan2",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 4,
			"chain_amount": 2,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Vulcan2"
	},
	"Vulcan2": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan3",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 3,
			"chain_amount": 5,
			"fuse_amount": 2,
		},
		"_upgrades": [
			"+ Vulcan2 +",
		],
		"_fuses_into": "Vulcan2"
	},
	"+ Vulcan2 +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan3",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 4,
			"chain_amount": 5,
			"fuse_amount": 2,
		},
		"_is_upgrade": true,
		"_fuses_into": "Vulcan2"
	},
	"Vulcan3": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"chain_amount": 5,
			"fuse_amount": 2,
		},
		"_upgrades": [
			"+ Vulcan2 +",
		],
	},
	"+ Vulcan3 +": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.fusion.name],
		"Abilities": "{damage} for {damage_amount}. Repeat {chain_amount} times.\n"\
				+ "Fuse {fuse_amount} -> Vulcan3",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 6,
			"chain_amount": 5,
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
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 8,
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
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 11,
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
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 6,
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
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 9,
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
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 14,
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
		"Cost": 1,
		"_illustration": "Nobody",
			"_rarity": "Uncommon",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 17,
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
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fortify}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 20,
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
		"Tags": [Terms.GENERIC_TAGS.fusion.name, Terms.ACTIVE_EFFECTS.fortify.name],
		"Abilities": "Gain {defence_amount} {confidence}\nGain {effect_stacks} {fortify}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Rare",
		"_keywords": ["confidence"],
		"_amounts": {
			"defence_amount": 23,
			"effect_stacks": 3,
		},
		"_effects_info": {
			Terms.ACTIVE_EFFECTS.fortify.name: Terms.PLAYER
		},
		"_is_upgrade": true,
	},
	"Photon Blade": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "The next {discount_uses} {control} cards you play this turn"\
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
		"Tags": [Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "The next {discount_uses} {control} cards you play this turn"\
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
		"Tags": [Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "The next {discount_uses} {control} cards you play this turn"\
				+ "costs -{discount_amount} {immersion}",
		"Cost": 1,
		"_illustration": "Nobody",
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 11,
			"discount_amount": 2,
			"discount_uses": 1,
		},
		"_is_upgrade": true,
	},
	"= Photon Blade =": {
		"Type": "Action",
		"Tags": [Terms.GENERIC_TAGS.frozen.name],
		"Abilities": "{damage} for {damage_amount}.\n"\
				+ "The next {discount_uses} {control} cards you play this turn"\
				+ "costs -{discount_amount} {immersion}",
		"Cost": 1,
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
		"_rarity": "Common",
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
		"_rarity": "Common",
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
		"_rarity": "Common",
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
		"_rarity": "Common",
		"_keywords": ["interpretation"],
		"_amounts": {
			"damage_amount": 5,
			"increase_amount": 2,
		},
		"_is_upgrade": true,
	},
	"Blinding Flash": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name],
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
		"_upgrade_threshold_modifier": 0,
		"_upgrades": [
			"* Blinding Flash *",
			"Ω Blinding Flash Ω",
			"Searing Flash",
		],
	},
	"* Blinding Flash *": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.slumber.name],
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
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.omega.name],
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
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.slumber.name],
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
		"Tags": [Terms.GENERIC_TAGS.startup.name,Terms.GENERIC_TAGS.relax.name],
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
			"Ω Dark Recoveryr Ω",
		],
	},
	"+ Dark Recovery +": {
		"Type": "Control",
		"Tags": [Terms.GENERIC_TAGS.startup.name,Terms.GENERIC_TAGS.relax.name],
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
		"Tags": [Terms.GENERIC_TAGS.startup.name,Terms.GENERIC_TAGS.omega.name],
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
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.omega.name],
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
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.omega.name],
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
		"Tags": [Terms.GENERIC_TAGS.startup.name, Terms.GENERIC_TAGS.omega.name],
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
}


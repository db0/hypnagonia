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
		"Tags": [],
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
		"Tags": [],
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
		"Tags": [],
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
		"Tags": [],
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
}


extends CoreScripts

const Cannon = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.marked.name,
				"subject": "previous",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			}
		],
	},
}
const HiCannon = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.marked.name,
				"subject": "previous",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			}
		],
	},
}
const MegaCannon = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.marked.name,
				"subject": "previous",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			}
		],
	},
}
const Vulcan = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"repeat": {
					"lookup_property": "_amounts",
					"value_key": "chain_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const Vulcan2 = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"repeat": {
					"lookup_property": "_amounts",
					"value_key": "chain_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const Vulcan3 = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"repeat": {
					"lookup_property": "_amounts",
					"value_key": "chain_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const PhotonShield = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "defence_amount"
				},
			},
		],
	},
}
const LumenShield = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "defence_amount"
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	}
}
const PlasmaShield = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "defence_amount"
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.fortify.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	},
}
const PhotonBlade = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "set_discount",
				"tags": ["Card"],
				"discount_uses": {
					"lookup_property": "_amounts",
					"value_key": "discount_uses"
				},
				"discount_amount": {
					"lookup_property": "_amounts",
					"value_key": "discount_amount",
					"is_inverted": true,
				},
				"discount_filters": [
					{"property": "Type", "value": "Control"},
					{"property": "Cost", "value": 1, "comparison": "ge"},
				],
			}
		],
	},
}
const ChargedShot = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
	"card_played": {
		"hand": [
			{
				"name": "modify_amount",
				"tags": ["Card"],
				"amount_key": "damage_amount",
				"amount_value": {
					"lookup_property": "_amounts",
					"value_key": "increase_amount",
					"convert_to_string": true,
				},
				"subject": "self",
			},
		],
		"trigger": "another",
	},
}
const BlindingFlash = {
	"battle_begun": {
		"all": [
			{
				"name": "apply_effect",
				"tags": ["Card", "Delayed"],
				"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	},
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
}
const SearingFlash = {
	"battle_begun": {
		"all": [
			{
				"name": "apply_effect",
				"tags": ["Card", "Delayed"],
				"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	},
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
		],
	},
}
const DarkRecovery = {
	"battle_begun": {
		"all": [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "healing_amount",
					"default": 0,
					"is_inverted": true,
				},
				"tags": ["Healing", "Card"],
			},
		],
	},
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
}
const GhostRecovery = {
	"battle_begun": {
		"all": [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "healing_amount",
					"default": 0,
					"is_inverted": true,
				},
				"tags": ["Healing", "Card"],
			},
		],
	},
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
		],
	},
}
const DarkApproach = {
	"battle_begun": {
		"all": [
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
		],
	},
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
}
const GhostApproach = {
	"battle_begun": {
		"all": [
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
		],
	},
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount2"
				},
			},
		],
	},
}
const Widebeam = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"src_container": "deck",
				"dest_container": "forgotten",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "forget_amount"
				},
				"subject": "index",
				"subject_index": "bottom",
			},
		],
	},
}
const Precision = {
	"battle_begun": {
		"all": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
			},
		],
	},
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
}
const NanoMachines = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"src_container": "hand",
				"dest_container": "discard",
				"subject": "previous",
				"filter_each_previous_subject": true,
				"filter_state_subject": [{
					"filter_cardfilters": [
						{
							"property": "Tags",
							"value": Terms.GENERIC_TAGS.fusion.name,
							"comparison": 'ne'
						}
					],
				},],
			},
		],
	},
}
const SpareLens = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.spare_lens.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	},
}
const HeatVenting = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.heat_venting.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	},
}
const HighHeatVenting = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.heat_venting.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
				"upgrade_name": "high",
			},
		],
	},
}
const Streamlining = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.heat_venting.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
				"upgrade_name": "high",
			},
		],
	},
}
const Brooding = {
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"dest_container": "discard",
				"subject": "self",
				"tags": ["Played", "Card"],
			},
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"is_cost": false,
				"subject": "index",
				"subject_count": "all",
				"subject_index": "top",
				SP.KEY_NEEDS_SELECTION: true,
				SP.KEY_SELECTION_COUNT: {
					"lookup_property": "_amounts",
					"value_key": "forget_amount"
				},
				SP.KEY_SELECTION_TYPE: "equal",
				SP.KEY_SELECTION_OPTIONAL: false,
				SP.KEY_SELECTION_IGNORE_SELF: true,
				"src_container": "hand",
				"dest_container": "forgotten",
			},
			{
				"name": "draw_cards",
				"tags": ["Card"],
				"card_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
			},
		],
	},
}


# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String, get_modified = true) -> Dictionary:
	# This format allows me to trace which script failed during load
	var scripts := {
		"Cannon": Cannon,
		"HiCannon": HiCannon,
		"MegaCannon": MegaCannon,
		"Vulcan": Vulcan,
		"Vulcan2": Vulcan2,
		"Vulcan3": Vulcan3,
		"Photon Shield": PhotonShield,
		"Lumen Shield": LumenShield,
		"Plasma Shield": PlasmaShield,
		"Photon Blade": PhotonBlade,
		"Charged Shot": ChargedShot,
		"Blinding Flash": BlindingFlash,
		"Searing Flash": SearingFlash,
		"Dark Recovery": DarkRecovery,
		"Ghost Recovery": GhostRecovery,
		"Dark Approach": DarkApproach,
		"Ghost Approach": GhostApproach,
		"Widebeam": Widebeam,
		"Precision": Precision,
		"Nano-Machines": NanoMachines,
		"Heat Venting": HeatVenting,
		"High Heat Venting": HighHeatVenting,
		"Streamlining": Streamlining,
		"Brooding": Brooding,
		"Spare Lens": SpareLens,
	}
	return(_prepare_scripts(scripts, card_name, get_modified))

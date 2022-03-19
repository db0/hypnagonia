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
	}
	return(_prepare_scripts(scripts, card_name, get_modified))

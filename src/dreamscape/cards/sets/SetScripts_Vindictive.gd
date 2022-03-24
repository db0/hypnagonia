extends CoreScripts

const AngerMemento = {
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
				"name": "modify_damage",
				"subject": "previous",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount2"
				},
				"tags": ["Attack", "Card"],
				"filter_state_self": [{
					"filter_cardfilters": [
						{
							"property": "Tags",
							"value": Terms.GENERIC_TAGS.frozen.name,
						}
					],
				}],
			},
		],
	},
}
const KeepInMind = {
	"manual": {
		"hand": [
			{
				"name": "modify_properties",
				"tags": ["Card"],
				"set_properties": {"Tags": Terms.GENERIC_TAGS.frozen.name},
				"needs_subject": true,
				"subject": "tutor",
				"filter_state_tutor": [{
					"filter_cardfilters": [
						{
							"property": "Tags",
							"value": Terms.GENERIC_TAGS.frozen.name,
							"comparison": "ne",
						}
					],
				}],
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "beneficial_integer"
				},
				"sort_by": "random",
				"src_container": "hand",
			},
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
}
const StoreInMind = {
	"manual": {
		"hand": [
			{
				"name": "modify_properties",
				"tags": ["Card"],
				"set_properties": {"Tags": Terms.GENERIC_TAGS.frozen.name},
				"needs_subject": true,
				"subject": "tutor",
				"filter_state_tutor": [{
					"filter_cardfilters": [
						{
							"property": "Tags",
							"value": Terms.GENERIC_TAGS.frozen.name,
							"comparison": "ne",
						}
					],
				}],
				"subject_count": "all",
				SP.KEY_NEEDS_SELECTION: true,
				SP.KEY_SELECTION_COUNT: {
					"lookup_property": "_amounts",
					"value_key": "beneficial_integer"
				},
				SP.KEY_SELECTION_TYPE: "equal",
				SP.KEY_SELECTION_OPTIONAL: false,
				SP.KEY_SELECTION_IGNORE_SELF: true,
				"src_container": "hand",
			},
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
}
const MementoOfSafety = {
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
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "defence_amount2"
				},
				"filter_state_self": [{
					"filter_cardfilters": [
						{
							"property": "Tags",
							"value": Terms.GENERIC_TAGS.frozen.name,
						}
					],
				}],
			},
		],
	},
}
const MovingOn = {
	"manual": {
		"hand": [
			{
				"name": "move_card_to_container",
				"dest_container": "discard",
				"subject": "self",
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
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"subject": "index",
				"subject_count": "all",
				"subject_index": "top",
				SP.KEY_NEEDS_SELECTION: true,
				SP.KEY_SELECTION_COUNT: {
					"lookup_property": "_amounts",
					"value_key": "discard_amount"
				},
				SP.KEY_SELECTION_TYPE: "equal",
				SP.KEY_SELECTION_OPTIONAL: false,
				SP.KEY_SELECTION_IGNORE_SELF: true,
				"src_container": "hand",
				"dest_container": "discard",
			},
		],
	},
}
const FistOfCandies = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": 'per_tutor',
				"per_tutor": {
					"src_container": "hand",
					"subject": "tutor",
					"subject_count": "all",
					"multiplier": {
						"lookup_property": "_amounts",
						"value_key": "damage_amount"
					},
				},
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
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
		"Memento of Anger": AngerMemento,
		"Memento of Safety": MementoOfSafety,
		"Keep in Mind": KeepInMind,
		"Store in Mind": StoreInMind,
		"Moving On": MovingOn,
		"Fist of Candies": FistOfCandies,
	}
	return(_prepare_scripts(scripts, card_name, get_modified))

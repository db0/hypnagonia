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
			{
				"name": "end_turn",
			}
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

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String, get_modified = true) -> Dictionary:
	# This format allows me to trace which script failed during load
	var scripts := {
		"Anger Memento": AngerMemento,
		"Keep in Mind": KeepInMind,
		"Store in Mind": StoreInMind,
	}
	return(_prepare_scripts(scripts, card_name, get_modified))

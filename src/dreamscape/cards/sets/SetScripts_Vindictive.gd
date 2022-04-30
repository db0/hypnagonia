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
				"name": "apply_effect",
				"tags": ["Card"],
				"subject": "previous",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
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
				"subject_index": "bottom",
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
					"modifier": 1,
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
const HandofGrudge = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"subject": "dreamer",
				"modification": 'per_tutor',
				"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
				"per_tutor": {
					"src_container": "hand",
					"subject": "tutor",
					"subject_count": "all",
					"modifier": 1,
					"multiplier": {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks"
					},
				},
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
const VestigeOfWarmth = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.vestige_of_warmth.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	}
}
const LastVestigeOfWarmth = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.vestige_of_warmth.name,
				"upgrade_name": "last",
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	},
}
const TheColdDish = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Card"],
				"subject": "target",
				"needs_subject": true,
				"amount": {
					"lookup_property": "_amounts",
					"value_key": "damage_amount"
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
	"player_turn_started": {
		"hand": [
			{
				"name": "modify_properties",
				"tags": ["Card"],
				"set_properties": {
					"Cost": {
						"lookup_property": "_amounts",
						"value_key": "beneficial_integer",
						"convert_to_string": true,
						"is_inverted": true,
					}
				},
				"subject": "self",
			},
			{
				"name": "enable_rider",
				"tags": ["Card"],
				"rider": "reset_cost_after_play",
				"subject": "self",
			},
		],
	},
}
const NothingForgotten = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.nothing_forgotten.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	},
}
const Stewing = {
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
	"player_turn_started": {
		"hand": [
			{
				"name": "modify_amount",
				"tags": ["Card"],
				"amount_key": "defence_amount",
				"amount_value": {
					"lookup_property": "_amounts",
					"value_key": "increase_amount",
					"convert_to_string": true,
				},
				"subject": "self",
			},
		],
	},
}
const Reactionary = {
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
				"name": "nested_script",
				"nested_tasks": [
					{
						"name": "apply_effect",
						"tags": ["Card"],
						"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
						"subject": "dreamer",
						"modification": {
							"lookup_property": "_amounts",
							"value_key": "effect_stacks"
						},
					},
				],
				# This trick allows me to trigger parts of the script only
				# if the previous target matches a filter
				"subject": "previous",
				"filter_state_subject": [{
					"filter_intent_stress": {
						"amount": {
							"lookup_property": "_amounts",
							"value_key": "min_requirements_amount"
						},
						"comparison": 'ge',
					},
				},],
			}
		],
	},
}
const ThatsGoingInTheBook = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
			},
		],
	},
}
const NoteTaking = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.note_taking.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	},
}
const Vengeance = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"tags": ["Attack", "Card", "Unblockable"],
				"subject": "target",
				"needs_subject": true,
				"amount": "per_effect_stacks",
				"per_effect_stacks": {
					"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
					"subject": "dreamer",
					"modifier": {
						"lookup_property": "_amounts",
						"value_key": "beneficial_integer",
					},
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const UnstoppableVengeance = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "effect_stacks"
				},
				"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
			},
			{
				"name": "modify_damage",
				"tags": ["Attack", "Card", "Unblockable"],
				"subject": "target",
				"needs_subject": true,
				"amount": "per_effect_stacks",
				"per_effect_stacks": {
					"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
					"subject": "dreamer",
					"modifier": {
						"lookup_property": "_amounts",
						"value_key": "beneficial_integer",
					},
				},
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
			},
		],
	},
}
const Planning = {
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
				"subject": "tutor",
				"subject_count": {
					"lookup_property": "_amounts",
					"value_key": "draw_amount"
				},
				"src_container":  "deck",
				"dest_container":  "hand",
				"filter_state_tutor": [
					{
						"filter_properties": {
							"Tags": Terms.ACTIVE_EFFECTS.thorns.name
						},
					},
				],
			},
		],
	},
}
const SavedforLater  = {
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
				"name": "nested_script",
				"nested_tasks": [
					{
						"name": "apply_effect",
						"tags": ["Card"],
						"effect_name": Terms.ACTIVE_EFFECTS.empower.name,
						"subject": "dreamer",
						"modification": {
							"lookup_property": "_amounts",
							"value_key": "effect_stacks"
						},
					},
				],
				# This trick allows me to trigger parts of the script only
				# if the previous target matches a filter
				"subject": "dreamer",
				"filter_state_subject": [{
					"filter_effects": [
						{
							"filter_effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
						},
					]
				},],
			}
		],
	},
}
const Schadenfreude = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.schadenfreude.name,
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	}
}
const BitterSchadenfreude = {
	"manual": {
		"hand": [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.schadenfreude.name,
				"upgrade_name": "bitter",
				"subject": "dreamer",
				"modification": {
					"lookup_property": "_amounts",
					"value_key": "concentration_stacks"
				},
			},
		],
	},
}
const ReckoningTime = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"subject_count": "all",
				"amount": "per_effect_stacks",
				"tags": ["Attack", "Card"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
				"per_effect_stacks": {
					"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
					"subject": "dreamer",
					"multiplier": {
						"lookup_property": "_amounts",
						"value_key": "multiplier_amount",
					},
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
				"subject": "dreamer",
				"modification": "per_effect_stacks",
				"skip_sceng_snapshot": true,
				"per_effect_stacks": {
					"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
					"subject": "dreamer",
					"multiplier": {
						"lookup_property": "_amounts",
						"value_key": "detrimental_percentage",
						"is_inverted": true,
					},
				},
			},
		],
	},
}
const Prepared = {
	"manual": {
		"hand": [
			{
				"name": "assign_defence",
				"tags": ["Card"],
				"subject": "dreamer",
				"amount": 11,
			},
			{
				"name": "move_card_to_container",
				"subject": "self",
				"dest_container": "forgotten",
				"tags": ["Played", "Card"],
			},
		],
	},
	"on_player_turn_ended": {
		"hand": [
			{
				"name": "move_card_to_container",
				"tags": ["Card"],
				"subject": "self",
				"dest_container": "forgotten",
			},
		],
	},
}
const TheLastStraw = {
	"manual": {
		"hand": [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": "per_effect_stacks",
				"tags": ["Exert", "Card"],
				"per_effect_stacks": {
					"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
					"subject": "dreamer",
					"divider": {
						"lookup_property": "_amounts",
						"value_key": "beneficial_float",
					},
				},
			},
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
				"subject": "dreamer",
				"modification": "per_effect_stacks",
				"skip_sceng_snapshot": true,
				"per_effect_stacks": {
					"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
					"subject": "dreamer",
					"multiplier": {
						"lookup_property": "_amounts",
						"value_key": "beneficial_percentage",
					},
				},
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
		"Memento of Anger": AngerMemento,
		"Memento of Safety": MementoOfSafety,
		"Keep in Mind": KeepInMind,
		"Store in Mind": StoreInMind,
		"Moving On": MovingOn,
		"Fist of Candies": FistOfCandies,
		"Hand of Grudge": HandofGrudge,
		"Vestige of Warmth": VestigeOfWarmth,
		"Last Vestige of Warmth": LastVestigeOfWarmth,
		"The Cold Dish": TheColdDish,
		"Nothing Forgotten": NothingForgotten,
		"Stewing": Stewing,
		"Reactionary": Reactionary,
		"That's Going in the Book": ThatsGoingInTheBook,
		"Note-Taking": NoteTaking,
		"Vengeance": Vengeance,
		"Unstoppable Vengeance": UnstoppableVengeance,
		"Planning": Planning,
		"Saved for Later": SavedforLater,
		"Schadenfreude": Schadenfreude,
		"Bitter Schadenfreude": BitterSchadenfreude,
		"Reckoning Time": ReckoningTime,
		"Prepared": Prepared,
		"The Last Straw": TheLastStraw,
	}
	return(_prepare_scripts(scripts, card_name, get_modified))

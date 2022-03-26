# Determines what kind of modifications are applicable for the provided card properties
# Some modifications are listed twice, to give them bigger probability to be chosen
# This is because I want more chance to modify attack/defence than to add new tags
class_name CardModifications
extends Reference

# We only use this if none of the others exist, as it's very destabilizing
const LAST_RESORT_SCAR := {
		"property": "Cost",
		"value": "+1",
	}
	
# We only use this if none of the others exist, as it's very destabilizing
const LAST_RESORT_ENHANCEMENT := {
		"property": "Cost",
		"value": "-1",
	}

# Duplicates to increase chances
const BENEFICIAL_INTEGERS := [
	"beneficial_integer",
	"beneficial_integer2",
	"beneficial_integer3",
	"chain_amount",
	"draw_amount",
	"draw_amount2",
	"scry_amount",
	"effect_stacks",
	"effect_stacks2",
	"effect_stacks3",
	"steal_amount",
	"increase_amount",
	"turns_amount",
	"multiplier_amount",
	"immersion_amount",
	"max_requirements_amount",
]

const DETRIMENTAL_INTEGERS := [
	"detrimental_integer",
	"detrimental_integer2",
	"detrimental_integer3",
	"forget_amount",
	"discard_amount",
	"perturb_amount",
	"detriment_stacks",
	"exert_amount",
	"min_requirements_amount",
]

# This doesn't mean that these amounts are float, but rather that they're multiplied by floats
# This allows us more percentage-based increases.
# For example increasing a value from 4 to 5 is significant, but from 30 to 31 is not
# however by increasing it by 1.1 and rounding up, we make the change significant in both cases.
# Duplicates to increase chances
const BENEFICIAL_FLOATS := [
	"beneficial_float",
	"beneficial_float2",
	"beneficial_float3",
	"damage_amount",
	"damage_amount",
	"damage_amount2",
	"defence_amount",
	"defence_amount",
	"defence_amount2",
	"healing_amount",
]
const DETRIMENTAL_FLOATS := [
	"detrimental_float",
	"detrimental_float2",
	"detrimental_float3",
]
const BENEFICIAL_TAGS := [
	Terms.GENERIC_TAGS.alpha.name,
	Terms.GENERIC_TAGS.frozen.name,
]
const DETRIMENTAL_TAGS := [
	Terms.GENERIC_TAGS.omega.name,
	Terms.GENERIC_TAGS.end_turn.name,
	Terms.GENERIC_TAGS.init.name,
]
const SPECIAL_MODS := {
	"scar": [
		Terms.GENERIC_TAGS.slumber.name,
	],
	"enhancement": [
	]
}
const ALL_NUMERICALS =\
		BENEFICIAL_INTEGERS +\
		DETRIMENTAL_INTEGERS +\
		BENEFICIAL_FLOATS +\
		DETRIMENTAL_FLOATS

const ALL_MODIFIERS =\
		BENEFICIAL_INTEGERS +\
		DETRIMENTAL_INTEGERS +\
		BENEFICIAL_FLOATS +\
		DETRIMENTAL_FLOATS +\
		BENEFICIAL_TAGS +\
		DETRIMENTAL_TAGS

# These tags should never be applied at the same time
const OPPOSITE_TAGS := {
	Terms.GENERIC_TAGS.alpha.name: Terms.GENERIC_TAGS.omega.name,
	Terms.GENERIC_TAGS.omega.name: Terms.GENERIC_TAGS.alpha.name,
	Terms.GENERIC_TAGS.init.name: Terms.GENERIC_TAGS.end_turn.name,
	Terms.GENERIC_TAGS.end_turn.name: Terms.GENERIC_TAGS.init.name,
}

static func check_mod_applicability(card_properties: Dictionary, type := 'scar') -> Array:
	var applicable_mods := []
	var mods: Array
	var last_resort_mod : Dictionary
	var filters: Array
	for mod in ALL_MODIFIERS + SPECIAL_MODS[type]:
		if type == 'scar':
			filters = _get_scar_filters(mod)
			last_resort_mod = LAST_RESORT_SCAR
		else:
			filters = _get_enhancement_filters(mod)
			last_resort_mod = LAST_RESORT_ENHANCEMENT
		var filters_passed := true

		for filter in filters:
			if not filter.check_card(card_properties):
				filters_passed = false
		if filters_passed:
			applicable_mods.append(_get_mod_value(mod, type))
	if applicable_mods.size() > 0:
		CFUtils.shuffle_array(applicable_mods)
	else:
		applicable_mods.append(last_resort_mod)
	return(applicable_mods)

static func _get_enhancement_filters(modification: String) -> Array:
	var filters: Array
	if modification in ALL_NUMERICALS:
		filters.append(CardFilter.new('_amounts', modification, 'eq'))
	# If it's not a numerical, it's a tag
	elif modification in BENEFICIAL_TAGS:
		filters.append(CardFilter.new('Tags', modification, 'ne'))
		filters.append(CardFilter.new('Tags', 4, 'lt'))
		if OPPOSITE_TAGS.has(modification):
			filters.append(CardFilter.new('Tags', OPPOSITE_TAGS[modification], 'ne'))
	elif modification in DETRIMENTAL_TAGS:
		filters.append(CardFilter.new('Tags', modification, 'eq'))
	return(filters)

static func _get_scar_filters(modification: String) -> Array:
	var filters: Array
	if modification in ALL_NUMERICALS:
		filters.append(CardFilter.new('_amounts', modification, 'eq'))
	# If it's not a numerical, it's a tag
	elif modification in BENEFICIAL_TAGS:
		filters.append(CardFilter.new('Tags', modification, 'eq'))
	elif modification in DETRIMENTAL_TAGS:
		filters.append(CardFilter.new('Tags', modification, 'ne'))
		filters.append(CardFilter.new('Tags', 4, 'lt'))
		if OPPOSITE_TAGS.has(modification):
			filters.append(CardFilter.new('Tags', OPPOSITE_TAGS[modification], 'ne'))
	elif modification == Terms.GENERIC_TAGS.slumber.name:
		filters = [
			CardFilter.new('Tags', Terms.GENERIC_TAGS.slumber.name, 'ne'),
			CardFilter.new('Tags', 4, 'lt'),
			CardFilter.new('Type', "Concentration", 'ne'),
			CardFilter.new('_is_concentration', false),
		]
	return(filters)

static func _get_mod_value(modification: String, type := 'scar') -> Dictionary:
	# The expected dictionary is based on numerical amounts
	# for tags we'll also change the 'property' value
	# and the value will be just the tag name
	var value_dict := {
		"property": "_amounts",
		"value": {
			"amount_key": modification,
			"amount_value": "",
		},
	}
	if modification in BENEFICIAL_INTEGERS:
		if type == 'scar':
			value_dict["value"]["amount_value"] = "-1"
		else:
			value_dict["value"]["amount_value"] = "+1"
	if modification in DETRIMENTAL_INTEGERS:
		if type == 'scar':
			value_dict["value"]["amount_value"] = "+1"
		else:
			value_dict["value"]["amount_value"] = "-1"
	if modification in BENEFICIAL_FLOATS:
		if type == 'scar':
			value_dict["value"]["amount_value"] = "*0.9"
		else:
			value_dict["value"]["amount_value"] = "*1.1"
	if modification in DETRIMENTAL_FLOATS:
		if type == 'scar':
			value_dict["value"]["amount_value"] = "*1.1"
		else:
			value_dict["value"]["amount_value"] = "*0.9"
	if modification in BENEFICIAL_TAGS:
		value_dict["property"] = "Tags"
		if type == 'scar':
			value_dict["value"] = "-" + modification
		else:
			value_dict["value"] = modification
	if modification in DETRIMENTAL_TAGS:
		value_dict["property"] = "Tags"
		if type == 'scar':
			value_dict["value"] = modification
		else:
			value_dict["value"] = "-" + modification
	return(value_dict)

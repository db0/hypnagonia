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

static func check_mod_applicability(card_properties: Dictionary, type := 'scar') -> Array:
	var applicable_mods := []
	var mods: Array
	var last_resort_mod : Dictionary
	var filters: Array
	for mod in HConst.ALL_MODIFIERS + HConst.SPECIAL_MODS[type]:
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
	if modification in HConst.ALL_NUMERICALS:
		filters.append(DreamCardFilter.new('_amounts', modification, 'eq'))
	# If it's not a numerical, it's a tag
	elif modification in HConst.BENEFICIAL_TAGS:
		filters.append(DreamCardFilter.new('Tags', modification, 'ne'))
		filters.append(DreamCardFilter.new('Tags', 4, 'lt'))
		if HConst.OPPOSITE_TAGS.has(modification):
			filters.append(DreamCardFilter.new('Tags', HConst.OPPOSITE_TAGS[modification], 'ne'))
	elif modification in HConst.DETRIMENTAL_TAGS:
		filters.append(DreamCardFilter.new('Tags', modification, 'eq'))
	if modification == 'exert_amount':
		filters.append(DreamCardFilter.new('exert_amount', 1, 'gt', false, "compare_amounts"))
	return(filters)

static func _get_scar_filters(modification: String) -> Array:
	var filters: Array
	if modification in HConst.ALL_NUMERICALS:
		filters.append(DreamCardFilter.new('_amounts', modification, 'eq'))
	# If it's not a numerical, it's a tag
	elif modification in HConst.BENEFICIAL_TAGS:
		filters.append(DreamCardFilter.new('Tags', modification, 'eq'))
	elif modification in HConst.DETRIMENTAL_TAGS:
		filters.append(DreamCardFilter.new('Tags', modification, 'ne'))
		filters.append(DreamCardFilter.new('Tags', 4, 'lt'))
		if HConst.OPPOSITE_TAGS.has(modification):
			filters.append(DreamCardFilter.new('Tags', HConst.OPPOSITE_TAGS[modification], 'ne'))
	elif modification == Terms.GENERIC_TAGS.slumber.name:
		filters = [
			DreamCardFilter.new('Tags', Terms.GENERIC_TAGS.slumber.name, 'ne'),
			DreamCardFilter.new('Tags', 4, 'lt'),
			DreamCardFilter.new('Type', "Concentration", 'ne'),
			DreamCardFilter.new('_is_concentration', false),
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
	if modification in HConst.BENEFICIAL_INTEGERS:
		if type == 'scar':
			value_dict["value"]["amount_value"] = "-1"
		else:
			value_dict["value"]["amount_value"] = "+1"
	if modification in HConst.DETRIMENTAL_INTEGERS:
		if type == 'scar':
			value_dict["value"]["amount_value"] = "+1"
		else:
			value_dict["value"]["amount_value"] = "-1"
	if modification in HConst.BENEFICIAL_FLOATS:
		if type == 'scar':
			value_dict["value"]["amount_value"] = "*0.9"
		else:
			value_dict["value"]["amount_value"] = "*1.1"
	if modification in HConst.DETRIMENTAL_FLOATS:
		if type == 'scar':
			value_dict["value"]["amount_value"] = "*1.1"
		else:
			value_dict["value"]["amount_value"] = "*0.9"
	if modification in HConst.BENEFICIAL_TAGS:
		value_dict["property"] = "Tags"
		if type == 'scar':
			value_dict["value"] = "-" + modification
		else:
			value_dict["value"] = modification
	if modification in HConst.DETRIMENTAL_TAGS:
		value_dict["property"] = "Tags"
		if type == 'scar':
			value_dict["value"] = modification
		else:
			value_dict["value"] = "-" + modification
	return(value_dict)

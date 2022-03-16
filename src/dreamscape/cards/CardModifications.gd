class_name CardModifications
extends Reference

# We only use this if none of the others exist, as it's very nerfing
const LAST_RESORT_SCAR := {
		"property": "Cost",
		"value": "+1",
	}# We only use this if none of the others exist, as it's very nerfing
const LAST_RESORT_BLESSING := {
		"property": "Cost",
		"value": "-1",
	}

static func get_scars() -> Dictionary:
	var scars := {
		[CardFilter.new('_amounts', "damage_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "damage_amount",
				"amount_value": "*0.9",
			},
		},
		[CardFilter.new('_amounts', "damage_amount2", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "damage_amount",
				"amount_value": "*0.9",
			},
		},
		[CardFilter.new('_amounts', "defence_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "defence_amount",
				"amount_value": "*0.9",
			},
		},
		[CardFilter.new('_amounts', "defence_amount2", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "defence_amount",
				"amount_value": "*0.9",
			},
		},
		[CardFilter.new('_amounts', "healing_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "healing_amount",
				"amount_value": "*0.9",
			},
		},
		[CardFilter.new('_amounts', "chain_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "chain_amount",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "draw_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "draw_amount",
				"amount_value": "-1",
			},
		},
		# Used when the player has to forget cards as cost
		# So increasing this amount makes the card worse
		[CardFilter.new('_amounts', "forget_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "forget_amount",
				"amount_value": "+1",
			},
		},
		# Used when the player has to discard cards as cost
		# So increasing this amount makes the card worse
		[CardFilter.new('_amounts', "discard_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "discard_amount",
				"amount_value": "+1",
			},
		},
		# Used when the player gains this amount of perturbations as the effect
		# So increasing this amount makes the card worse
		[CardFilter.new('_amounts', "perturb_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "perturb_amount",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "turns_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "turns_amount",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "multiplier_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "multiplier_amount",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "effect_stacks", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "effect_stacks",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "effect_stacks2", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "effect_stacks2",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "effect_stacks3", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "effect_stacks3",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "detriment_stacks", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "detriment_stacks",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "steal_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "steal_amount",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "increase_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "increase_amount",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "immersion_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "immersion_amount",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "exert_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "exert_amount",
				"amount_value": "+1",
			},
		},
		# Used when the player has to have this or higher amount of something
		# So increasing this amount makes the card worse
		[CardFilter.new('_amounts', "min_requirements_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "min_requirements_amount",
				"amount_value": "+1",
			},
		},
		# Used when the player has to have this or lower amount of something
		# So decreasing this amount makes the card worse
		[CardFilter.new('_amounts', "max_requirements_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "max_requirements_amount",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('Tags', Terms.GENERIC_TAGS.alpha.name, 'eq')]: {
			"property": "Tags",
			"value": "-" + Terms.GENERIC_TAGS.alpha.name,
		},
		[CardFilter.new('Tags', Terms.GENERIC_TAGS.frozen.name, 'eq')]: {
			"property": "Tags",
			"value": "-" + Terms.GENERIC_TAGS.frozen.name,
		},
		[
			CardFilter.new('Tags', Terms.GENERIC_TAGS.slumber.name, 'ne'),
			CardFilter.new('Tags', 2, 'lt'),
			CardFilter.new('Type', "Concentration", 'ne'),
			CardFilter.new('_is_concentration', false),
		]: {
			"property": "Tags",
			"value": Terms.GENERIC_TAGS.slumber.name,
		},
	}
	return(scars)

static func get_blessings() -> Dictionary:
	var blessings := {
		[CardFilter.new('_amounts', "damage_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "damage_amount",
				"amount_value": "*1.1",
			},
		},
		[CardFilter.new('_amounts', "damage_amount2", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "damage_amount2",
				"amount_value": "*1.1",
			},
		},
		[CardFilter.new('_amounts', "defence_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "defence_amount",
				"amount_value": "*1.1",
			},
		},
		[CardFilter.new('_amounts', "defence_amount2", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "defence_amount2",
				"amount_value": "*1.1",
			},
		},
		[CardFilter.new('_amounts', "healing_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "healing_amount",
				"amount_value": "*1.1",
			},
		},
		[CardFilter.new('_amounts', "chain_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "chain_amount",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "draw_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "draw_amount",
				"amount_value": "+1",
			},
		},
		# Used when the player has to forget cards as cost
		# So decreasing this amount makes the card better
		[CardFilter.new('_amounts', "forget_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "forget_amount",
				"amount_value": "-1",
			},
		},
		# Used when the player has to discard cards as cost
		# So decreasing this amount makes the card better
		[CardFilter.new('_amounts', "discard_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "discard_amount",
				"amount_value": "-1",
			},
		},
		# Used when the player gains this amount of perturbations as the effect
		# So decreasing this amount makes the card better
		[CardFilter.new('_amounts', "perturb_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "perturb_amount",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "turns_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "turns_amount",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "multiplier_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "multiplier_amount",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "effect_stacks", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "effect_stacks",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "effect_stacks2", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "effect_stacks2",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "effect_stacks3", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "effect_stacks3",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "detriment_stacks", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "detriment_stacks",
				"amount_value": "-1",
			},
		},
		[CardFilter.new('_amounts', "steal_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "steal_amount",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "increase_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "increase_amount",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "immersion_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "immersion_amount",
				"amount_value": "+1",
			},
		},
		[CardFilter.new('_amounts', "exert_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "exert_amount",
				"amount_value": "-1",
			},
		},
		# Used when the player has to have this or higher amount of something
		# So decreasing this amount makes the card better
		[CardFilter.new('_amounts', "min_requirements_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "min_requirements_amount",
				"amount_value": "-1",
			},
		},
		# Used when the player has to have this or lower amount of something
		# So increasing this amount makes the card better
		[CardFilter.new('_amounts', "max_requirements_amount", 'eq')]: {
			"property": "_amounts",
			"value": {
				"amount_key": "max_requirements_amount",
				"amount_value": "+1",
			},
		},
		[
			CardFilter.new('Tags', Terms.GENERIC_TAGS.alpha.name, 'ne'),
			CardFilter.new('Tags', 2, 'lt'),
		]: {
			"property": "Tags",
			"value": Terms.GENERIC_TAGS.alpha.name,
		},
		[
			CardFilter.new('Tags', Terms.GENERIC_TAGS.frozen.name, 'ne'),
			CardFilter.new('Tags', 2, 'lt'),
		]: {
			"property": "Tags",
			"value": Terms.GENERIC_TAGS.frozen.name,
		},
		[CardFilter.new('Tags', Terms.GENERIC_TAGS.slumber.name, 'eq')]: {
			"property": "Tags",
			"value": '-' + Terms.GENERIC_TAGS.slumber.name,
		},
	}
	return(blessings)

static func check_mod_applicability(card_properties: Dictionary, type := 'scar') -> Array:
	var applicable_mods := []
	var mods: Dictionary
	var last_resort_mod : Dictionary
	if type == 'scar':
		mods = get_scars()
		last_resort_mod = LAST_RESORT_SCAR
	else:
		mods = get_blessings()
		last_resort_mod = LAST_RESORT_BLESSING
	for filters in mods:
		var filters_passed := true
		for filter in filters:
			if not filter.check_card(card_properties):
				filters_passed = false
		if filters_passed:
			applicable_mods.append(mods[filters])
	if applicable_mods.size() > 0:
		CFUtils.shuffle_array(applicable_mods)
	else:
		applicable_mods.append(last_resort_mod)
	return(applicable_mods)

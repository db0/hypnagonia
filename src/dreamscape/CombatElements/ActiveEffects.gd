class_name ActiveEffects
extends GridContainer

const EFFECT_TEMPLATE := preload("res://src/dreamscape/CombatElements/CombatEffects/CombatEffectTemplate.tscn")

# When a stack of an effect is added and its opposite exists, before adding a stack
# we remove the same amount of its opposite from the amount.
const OPPOSITES := {
	Terms.ACTIVE_EFFECTS.empower.name: Terms.ACTIVE_EFFECTS.disempower.name,
	Terms.ACTIVE_EFFECTS.disempower.name: Terms.ACTIVE_EFFECTS.empower.name,
	Terms.ACTIVE_EFFECTS.buffer.name: Terms.ACTIVE_EFFECTS.drain.name,
	Terms.ACTIVE_EFFECTS.drain.name: Terms.ACTIVE_EFFECTS.buffer.name,
}

var all_effects: Dictionary
# The enemy entity owning these effects
var combat_entity
var sceng_snapshot_modifiers := {}

# Adds a combat effect to the entity
#
# If the effect of that name doesn't exist, it creates it according to the config.
#
# If the amount of existing effects of that type drops to 0 or lower,
# the effect node is also removed.
func mod_effect(
			effect_name : String,
			mod := 1,
			set_to_mod := false,
			check := false,
			tags := ["Manual"],
			upgrade_string := '') -> int:
	var retcode : int
	# This way avoids unnecessary errors in console compared to trying to load directly and checking
	# if the load variable has anything
	var script_path := "res://src/dreamscape/CombatElements/CombatEffects/%s.gd" % [Terms.get_effect_key(effect_name)]
	if not ResourceLoader.exists(script_path) and not Terms.get_effect_entry(effect_name).has("noscript"):
#	if not EFFECTS.get(effect_name, null):
		retcode = CFConst.ReturnCode.FAILED
	else:
		var effect_script: GDScript
		if ResourceLoader.exists(script_path):
			effect_script = load(script_path)
		retcode = CFConst.ReturnCode.CHANGED
		# We use this to name the node, in order not to conflict
		# With upgraded effects of the same type.
		var combined_effect_name :=  effect_name
		if upgrade_string != '':
			combined_effect_name = upgrade_string.capitalize() + ' ' + effect_name
		var effect : CombatEffect = get_all_effects().get(combined_effect_name, null)
		if mod < 0:
			pass
		if not effect and mod <= 0 and not Terms.get_effect_entry(effect_name).get("can_go_negative"):
			retcode = CFConst.ReturnCode.OK
		elif effect and set_to_mod and effect.stacks == mod:
			retcode = CFConst.ReturnCode.OK
		elif not check:
			if not effect:
				var opposite_name = OPPOSITES.get(effect_name)
				if opposite_name:
					var opposite : CombatEffect = get_all_effects().get(OPPOSITES[effect_name], null)
					if opposite:
						if set_to_mod:
							opposite.set_stacks(0, tags)
						elif opposite.stacks - mod > 0:
							opposite.set_stacks(opposite.stacks - mod, tags)
							mod = 0
						elif opposite.stacks - mod == 0:
							opposite.set_stacks(0, tags)
							mod = 0
						else:
							opposite.set_stacks(0, tags)
							mod -= opposite.stacks
				effect = EFFECT_TEMPLATE.instance()
				if not Terms.get_effect_entry(effect_name).has("noscript"):
					# We need to store the existing default variables set in the parent class
					# because replacing the script, sets them to null
					# then we need to reset them, after changing the script.
					var ict = effect.icon_container_texture
					var iect = effect.icon_extra_container_texture
					effect.set_script(effect_script)
					effect.icon_container_texture = ict
					effect.icon_extra_container_texture = iect
				effect.name = combined_effect_name
				effect.owning_entity = combat_entity
				effect.upgrade = upgrade_string
				add_child(effect)
				var effect_details := Terms.get_effect_entry(effect_name)
				var setup_dict := {
					"entity_type": combat_entity.entity_type,
					"icon": effect_details.icon,
					"amount": 0,
				}
				effect.effect_definition = effect_details
				effect.setup(setup_dict, effect_name)
			cfc.flush_cache()
			if set_to_mod:
				effect.set_stacks(mod, tags, Terms.get_effect_entry(effect_name).get("can_go_negative", false))
			else:
				effect.set_stacks(effect.stacks + mod, tags, Terms.get_effect_entry(effect_name).get("can_go_negative", false))
			if Terms.get_effect_entry(effect_name).get("is_invisible"):
				effect.visible = false
	return(retcode)


func get_all_effects() -> Dictionary:
	var found_effects := {}
	for effect in get_children():
		found_effects[effect.get_effect_name()] = effect
	return(found_effects)


func get_all_effects_nodes() -> Array:
	return(get_children())


func get_ordered_effects(ordered_effects: Dictionary) -> Dictionary:
	for effect in get_children():
		match effect.priority:
			Terms.ALTERANT_PRIORITY.ADD:
				# We do not want the same exact instance of an effect
				# to be calculated twice coming from the subject AND source.
				# For example quicken has always the same subject
				# and source.
				if not effect in ordered_effects.adders:
					ordered_effects.adders.append(effect)
			Terms.ALTERANT_PRIORITY.MULTIPLY:
				if not effect in ordered_effects.multipliers:
					ordered_effects.multipliers.append(effect)
			Terms.ALTERANT_PRIORITY.SET:
				if not effect in ordered_effects.setters:
					ordered_effects.setters.append(effect)
	return(ordered_effects)


# Returns the token node of the provided name or null if not found.
func get_effect(effect_name: String) -> CombatEffect:
	return(get_all_effects().get(effect_name,null))


# Returns only the stacks if the effect exists.
# Else it returns 0
func get_effect_stacks(effect_name: String) -> int:
	var effect: CombatEffect = get_effect(effect_name)
	if effect_name in sceng_snapshot_modifiers:
		return(sceng_snapshot_modifiers[effect_name])
	elif not effect:
		return(0)
	else:
		return(effect.stacks)


# Returns the effect with the most stacks (tiebreaker is node index)
# Returns null if no effect is found
func get_effect_with_most_stacks(effect_type := ''):
	var highest_effect = null
	var highest_stacks := 0
	for effect in get_children():
		if effect.stacks > highest_stacks:
			if effect_type and not effect.canonical_name in Terms.get_all_effect_types(effect_type):
				continue
			highest_effect = effect.canonical_name
			highest_stacks = effect.stacks
	# Effects of type "Versatile" can be considered buffs or debuffs, depending on if they're positive
	# or negative
	if effect_type == 'Buff' or effect_type == 'Debuff':
		for effect in get_children():
			if effect_type == 'Buff' and effect.stacks > 0 and effect.stacks > highest_stacks:
				if not effect.canonical_name in Terms.get_all_effect_types('Versatile'):
					continue
				highest_effect = effect.canonical_name
				highest_stacks = effect.stacks
			if effect_type == 'Debuff' and effect.stacks < 0 and abs(effect.stacks) > highest_stacks:
				if not effect.canonical_name in Terms.get_all_effect_types('Versatile'):
					continue
				highest_effect = effect.get_effect_name()
				# warning-ignore:narrowing_conversion
				highest_stacks = abs(effect.stacks)
	return(highest_effect)


# Returns the effect with the least stacks (tiebreaker is node index)
# Returns null if no effect is found
func get_effect_with_least_stacks(effect_type := ''):
	var lowest_effect = null
	var lowest_stacks := -1
	for effect in get_children():
		if lowest_stacks < 0 or effect.stacks < lowest_stacks:
			if effect_type and not effect.canonical_name in Terms.get_all_effect_types(effect_type):
				continue
			lowest_effect = effect.canonical_name
			lowest_stacks = effect.stacks
	if effect_type == 'Buff' or effect_type == 'Debuff':
		for effect in get_children():
			if effect_type == 'Buff' and effect.stacks > 0 and (effect.stacks < lowest_stacks or lowest_stacks < 0):
				if not effect.canonical_name in Terms.get_all_effect_types('Versatile'):
					continue
				lowest_effect = effect.canonical_name
				lowest_stacks = effect.stacks
			if effect_type == 'Debuff' and effect.stacks < 0 and (abs(effect.stacks) < lowest_stacks or lowest_stacks < 0):
				if not effect.canonical_name in Terms.get_all_effect_types('Versatile'):
					continue
				lowest_effect = effect.get_effect_name()
				# warning-ignore:narrowing_conversion
				lowest_stacks = abs(effect.stacks)
	return(lowest_effect)


func get_random_effect(effect_type := ''):
	var rng_effects := get_children()
	var random_effect = null
	CFUtils.shuffle_array(rng_effects)
	for effect in rng_effects:
		if effect_type and effect.canonical_name in Terms.get_all_effect_types(effect_type):
			random_effect = effect
			break
	if random_effect:
		return(random_effect.get_effect_name())

func snapshot_effect(
			effect_name : String,
			mod := 1,
			set_to_mod := false,
			tags := ["Manual"],
			upgrade_string := ''):
	var combined_effect_name :=  effect_name
	if upgrade_string != '':
		combined_effect_name = upgrade_string.capitalize() + ' ' + effect_name
	var effect : CombatEffect = get_all_effects().get(combined_effect_name, null)
	if not effect:
		var opposite_name = OPPOSITES.get(effect_name)
		if opposite_name:
			var opposite : CombatEffect = get_all_effects().get(OPPOSITES[effect_name], null)
			if opposite:
				if set_to_mod:
					sceng_snapshot_modifiers[opposite_name] = 0
				elif opposite.stacks - mod > 0:
					sceng_snapshot_modifiers[opposite_name] = opposite.stacks - mod
					mod = 0
				elif opposite.stacks - mod == 0:
					sceng_snapshot_modifiers[opposite_name] = 0
					mod = 0
				else:
					sceng_snapshot_modifiers[opposite_name] = 0
					mod -= opposite.stacks
	if set_to_mod:
		sceng_snapshot_modifiers[combined_effect_name] = mod
	else:
		if not effect:
			sceng_snapshot_modifiers[combined_effect_name] = mod
		else:
			sceng_snapshot_modifiers[combined_effect_name] = effect.stacks + mod

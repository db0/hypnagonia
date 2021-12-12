class_name ActiveEffects
extends GridContainer

const EFFECT_TEMPLATE := preload("res://src/dreamscape/CombatElements/CombatEffects/CombatEffectTemplate.tscn")

# When a stack of an effect is added and its opposite exists, before adding a stack
# we remove the same amount of its opposite from the amount.
const OPPOSITES := {
	Terms.ACTIVE_EFFECTS.empower: Terms.ACTIVE_EFFECTS.disempower,
	Terms.ACTIVE_EFFECTS.disempower: Terms.ACTIVE_EFFECTS.empower,
	Terms.ACTIVE_EFFECTS.buffer: Terms.ACTIVE_EFFECTS.drain,
	Terms.ACTIVE_EFFECTS.drain: Terms.ACTIVE_EFFECTS.buffer,
}

var all_effects: Dictionary
# The enemy entity owning these effects
var combat_entity


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
	var effect_script = load("res://src/dreamscape/CombatElements/CombatEffects/%s.gd" % [Terms.get_effect_key(effect_name)])
	if not effect_script and not Terms.get_effect_entry(effect_name).has("noscript"):
#	if not EFFECTS.get(effect_name, null):
		retcode = CFConst.ReturnCode.FAILED
	else:
		retcode = CFConst.ReturnCode.CHANGED
		# We use this to name the node, in order not to conflict
		# With upgraded effects of the same type.
		var combined_effect_name :=  effect_name
		if upgrade_string != '':
			combined_effect_name = upgrade_string.capitalize() + ' ' + effect_name
		var effect : CombatEffect = get_all_effects().get(combined_effect_name, null)
		if not effect and mod <= 0:
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
				effect.setup(setup_dict, effect_name)
			cfc.flush_cache()
			if set_to_mod:
				effect.set_stacks(mod, tags)
			else:
				effect.set_stacks(effect.stacks + mod, tags)
	return(retcode)

func get_all_effects() -> Dictionary:
	var found_effects := {}
	for effect in get_children():
		found_effects[effect.get_effect_name()] = effect
	return(found_effects)

func get_ordered_effects(ordered_effects: Dictionary) -> Dictionary:
	for effect in get_children():
		match effect.priority:
			CombatEffect.PRIORITY.ADD:
				# We do not want the same exact instance of an effect
				# to be calculated twice coming from the subject AND source.
				# For example quicken has always the same subject
				# and source. 
				if not effect in ordered_effects.adders:
					ordered_effects.adders.append(effect)
			CombatEffect.PRIORITY.MULTIPLY:
				if not effect in ordered_effects.multipliers:
					ordered_effects.multipliers.append(effect)
			CombatEffect.PRIORITY.SET:
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
	if not effect:
		return(0)
	else:
		return(effect.stacks)

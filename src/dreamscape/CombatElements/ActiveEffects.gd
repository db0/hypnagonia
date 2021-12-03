class_name ActiveEffects
extends GridContainer

const EFFECTS := {
	Terms.ACTIVE_EFFECTS.disempower.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Disempower.tscn"),
	Terms.ACTIVE_EFFECTS.empower.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Empower.tscn"),
	Terms.ACTIVE_EFFECTS.poison.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Poison.tscn"),
	Terms.ACTIVE_EFFECTS.burn.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Burn.tscn"),
	Terms.ACTIVE_EFFECTS.vulnerable.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Vulnerable.tscn"),
	Terms.ACTIVE_EFFECTS.marked.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Marked.tscn"),
	Terms.ACTIVE_EFFECTS.advantage.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Advantage.tscn"),
	Terms.ACTIVE_EFFECTS.impervious.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Impervious.tscn"),
	Terms.ACTIVE_EFFECTS.fortify.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Fortify.tscn"),
	Terms.ACTIVE_EFFECTS.buffer.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Buffer.tscn"),
	Terms.ACTIVE_EFFECTS.drain.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Drain.tscn"),
	Terms.ACTIVE_EFFECTS.outrage.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Outrage.tscn"),
	Terms.ACTIVE_EFFECTS.enraged.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Enraged.tscn"),
	Terms.ACTIVE_EFFECTS.strengthen.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Strengthen.tscn"),
	Terms.ACTIVE_EFFECTS.quicken.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Quicken.tscn"),
	Terms.ACTIVE_EFFECTS.thorns.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Thorns.tscn"),
	Terms.ACTIVE_EFFECTS.armor.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Armor.tscn"),
	Terms.ACTIVE_EFFECTS.creative_block.name: preload("res://src/dreamscape/CombatElements/CombatEffects/CreativeBlock.tscn"),
	# Concentation Effects
	Terms.ACTIVE_EFFECTS.laugh_at_danger.name: preload("res://src/dreamscape/CombatElements/CombatEffects/LaughAtDanger.tscn"),
	Terms.ACTIVE_EFFECTS.nothing_to_fear.name: preload("res://src/dreamscape/CombatElements/CombatEffects/NothingToFear.tscn"),
	Terms.ACTIVE_EFFECTS.rubber_eggs.name: preload("res://src/dreamscape/CombatElements/CombatEffects/RubberEggs.tscn"),
	Terms.ACTIVE_EFFECTS.nunclucks.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Nunclucks.tscn"),
	Terms.ACTIVE_EFFECTS.unassailable.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Unassailable.tscn"),
	Terms.ACTIVE_EFFECTS.master_of_skies.name: preload("res://src/dreamscape/CombatElements/CombatEffects/MasterOfSkies.tscn"),
	Terms.ACTIVE_EFFECTS.zen_of_flight.name: preload("res://src/dreamscape/CombatElements/CombatEffects/ZenOfFlight.tscn"),
	Terms.ACTIVE_EFFECTS.absurdity_unleashed.name: preload("res://src/dreamscape/CombatElements/CombatEffects/AbsurdityUnleashed.tscn"),
	Terms.ACTIVE_EFFECTS.brilliance.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Brilliance.tscn"),
	Terms.ACTIVE_EFFECTS.recall.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Recall.tscn"),
	Terms.ACTIVE_EFFECTS.eureka.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Eureka.tscn"),
	Terms.ACTIVE_EFFECTS.introspection.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Introspection.tscn"),
	Terms.ACTIVE_EFFECTS.the_happy_place.name: preload("res://src/dreamscape/CombatElements/CombatEffects/TheHappyPlace.tscn"),
	Terms.ACTIVE_EFFECTS.lash_out.name: preload("res://src/dreamscape/CombatElements/CombatEffects/LashOut.tscn"),
	Terms.ACTIVE_EFFECTS.excuses.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Excuses.tscn"),
	Terms.ACTIVE_EFFECTS.tolerance.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Tolerance.tscn"),
	Terms.ACTIVE_EFFECTS.unconventional.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Unconventional.tscn"),
	Terms.ACTIVE_EFFECTS.sneaky_beaky.name: preload("res://src/dreamscape/CombatElements/CombatEffects/SneakyBeaky.tscn"),
	Terms.ACTIVE_EFFECTS.tenacity.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Tenacity.tscn"),
	Terms.ACTIVE_EFFECTS.panicked_takeoff.name: preload("res://src/dreamscape/CombatElements/CombatEffects/PanickedTakeoff.tscn"),
}

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
	if not EFFECTS.get(effect_name, null):
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
				effect = EFFECTS[effect_name].instance()
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

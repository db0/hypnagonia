class_name ActiveEffects
extends GridContainer

const EFFECTS := {
	Terms.ACTIVE_EFFECTS.disempower.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Disempower.tscn"),
	Terms.ACTIVE_EFFECTS.empower.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Empower.tscn"),
	Terms.ACTIVE_EFFECTS.poison.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Poison.tscn"),
	Terms.ACTIVE_EFFECTS.vulnerable.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Vulnerable.tscn"),
	Terms.ACTIVE_EFFECTS.advantage.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Advantage.tscn"),
	Terms.ACTIVE_EFFECTS.impervious.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Impervious.tscn"),
	Terms.ACTIVE_EFFECTS.fortify.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Fortify.tscn"),
	Terms.ACTIVE_EFFECTS.buffer.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Buffer.tscn"),
	Terms.ACTIVE_EFFECTS.outrage.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Outrage.tscn"),
	Terms.ACTIVE_EFFECTS.strengthen.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Strengthen.tscn"),
	Terms.ACTIVE_EFFECTS.thorns.name: preload("res://src/dreamscape/CombatElements/CombatEffects/Thorns.tscn"),
	
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
}

# When a stack of an effect is added and its opposite exists, before adding a stack
# we remove the same amount of its opposite from the amount.
const OPPOSITES := {
	Terms.ACTIVE_EFFECTS.empower: Terms.ACTIVE_EFFECTS.disempower,
	Terms.ACTIVE_EFFECTS.disempower: Terms.ACTIVE_EFFECTS.empower,
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
			tags := ["Manual"]) -> int:
	var retcode : int
	if not EFFECTS.get(effect_name, null):
		retcode = CFConst.ReturnCode.FAILED
	else:
		retcode = CFConst.ReturnCode.CHANGED
		var effect : CombatEffect = get_all_effects().get(effect_name, null)
		if not effect and mod <= 0:
			pass
		elif not check:
			if not effect:
				var opposite_name = OPPOSITES.get(effect_name)
				if opposite_name:
					var opposite : CombatEffect = get_all_effects().get(OPPOSITES[effect_name], null)
					if opposite:
						var prev_op_value = opposite.stacks
						var new_op_value = 0
						if set_to_mod:
							opposite.stacks = 0
						elif opposite.stacks - mod > 0:
							opposite.stacks -= mod
							new_op_value = opposite.stacks
							mod = 0
						elif opposite.stacks - mod == 0:
							opposite.stacks = 0
							mod = 0
						else:
							opposite.stacks = 0
							mod -= opposite.stacks
						combat_entity.emit_signal(
								"effect_modified",
								combat_entity,
								"effect_modified",
								{"effect_name": opposite_name,
								SP.TRIGGER_PREV_COUNT: prev_op_value,
								SP.TRIGGER_NEW_COUNT: new_op_value,
								"tags": tags})
				effect = EFFECTS[effect_name].instance()
				effect.name = effect_name
				effect.owning_entity = combat_entity
				add_child(effect)
				var effect_details := Terms.get_effect_entry(effect_name)
				var setup_dict := {
					"entity_type": combat_entity.entity_type,
					"icon": effect_details.icon,
					"amount": 0,
				}
				effect.setup(setup_dict, effect_name)
			cfc.flush_cache()
			var prev_value := effect.stacks
			var new_value := 0
			if set_to_mod:
				effect.stacks = mod
				new_value = mod
			else:
				new_value = effect.stacks + mod
				if new_value < 0: new_value = 0
				effect.stacks += mod
			combat_entity.emit_signal(
					"effect_modified",
					combat_entity,
					"effect_modified",
					{"effect_name": effect_name,
					SP.TRIGGER_PREV_COUNT: prev_value,
					SP.TRIGGER_NEW_COUNT: new_value,
					"tags": tags})
	return(retcode)

func get_all_effects() -> Dictionary:
	var found_effects := {}
	for effect in get_children():
		found_effects[effect.get_effect_name()] = effect
	return(found_effects)

func get_ordered_effects() -> Array:
	var adders := []
	var multipliers := []
	var setters := []
	for effect in get_children():
		match effect.priority:
			CombatEffect.PRIORITY.ADD:
				adders.append(effect)
			CombatEffect.PRIORITY.MULTIPLY:
				multipliers.append(effect)
			CombatEffect.PRIORITY.SET:
				setters.append(effect)
	return(adders + multipliers + setters)


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

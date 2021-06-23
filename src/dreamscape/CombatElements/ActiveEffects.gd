class_name ActiveEffects
extends GridContainer

const EFFECTS_MAP = {
	"weaken": preload("res://src/dreamscape/CombatElements/CombatEffects/Weaken.tscn"),
	"advantage": preload("res://src/dreamscape/CombatElements/CombatEffects/Advantage.tscn"),
	"doubt": preload("res://src/dreamscape/CombatElements/CombatEffects/Doubt.tscn"),
}

var all_effects: Dictionary
# The enemy entity owning these effects
var combat_entity


# Adds a token to the card
#
# If the token of that name doesn't exist, it creates it according to the config.
#
# If the amount of existing tokens of that type drops to 0 or lower,
# the token node is also removed.
func mod_effect(
			effect_name : String,
			mod := 1,
			set_to_mod := false,
			check := false,
			tags := ["Manual"]) -> int:
	var retcode : int
	if not EFFECTS_MAP.get(effect_name, null):
		retcode = CFConst.ReturnCode.FAILED
	else:
		retcode = CFConst.ReturnCode.CHANGED
		var effect : CombatEffect = get_all_effects().get(effect_name, null)
		print_debug(get_all_effects())
		if not effect and mod <= 0:
			pass
		elif not check:
			if not effect:
				effect = EFFECTS_MAP[effect_name].instance()
				effect.entity_type = combat_entity.entity_type
				add_child(effect)
				effect.stacks = 0
			cfc.flush_cache()
			var prev_value = effect.stacks
			if set_to_mod:
				effect.stacks = mod
			else:
				effect.stacks += mod
			var new_value = effect.stacks
			if effect.stacks == 0:
				effect.queue_free()
			combat_entity.emit_signal(
					"effect_modified",
					combat_entity,
					"effect_modified",
					{"effect_name": effect.get_effect_name(),
					SP.TRIGGER_PREV_COUNT: prev_value,
					SP.TRIGGER_NEW_COUNT: new_value,
					"tags": tags})
	return(retcode)

func get_all_effects() -> Dictionary:
	var found_effects := {}
	for effect in get_children():
		found_effects[effect.get_effect_name()] = effect
	return found_effects

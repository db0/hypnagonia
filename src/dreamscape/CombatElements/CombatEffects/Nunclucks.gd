extends CombatEffect

const _description_string := "{effect_name}: Increase your {damage} by 1, for each stack of Confusion on the {enemy}."

func _ready() -> void:
	description_string = _description_string


func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		subject: Node = null) -> int:
	if not script.script_name == 'modify_health'\
			or not "Damage" in script.get_property(SP.KEY_TAGS)\
			or not is_source:
		return(0)
	var new_value = value + subject.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower)
	var alteration = new_value - value
#	print_debug("Advantage ({value} * 2) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	# This is the only way to reduce the stack only when all effects in the same card are resolved
	return(alteration)

extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	if not script.script_name == 'assign_defence' or is_source:
		return(0)
	var new_value = round(value * 0.75)
	var alteration = new_value - value
#	print_debug("Vulnerability ({value} * 0.7) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	return(alteration)

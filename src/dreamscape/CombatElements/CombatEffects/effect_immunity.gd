extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		subject: Node = null) -> int:
	if script.script_name != 'apply_effect'\
			or script.get_property("effect_name") != upgrade\
			or subject != owning_entity:
		return(0)
	var new_value = 0
	var alteration = new_value - value
	return(alteration)

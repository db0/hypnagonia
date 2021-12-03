extends CombatEffect

# To override. This is called by the scripting engine
# Is source is telling this script that the owning combat_entity is the one owning
# this alteration
func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	if not script.script_name == 'assign_defence'\
			or not is_source:
		return(0)
	var new_value = value + stacks
	var alteration = new_value - value
	return(alteration)

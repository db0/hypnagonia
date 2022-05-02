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
		subject: Node = null) -> int:
	if not script.script_name == 'assign_defence':
		return(0)
	if not is_source:
		return(0)
	if subject != owning_entity:
		return(0)
	if is_delayed:
		return(0)
	var new_value = value + stacks
	var alteration = new_value - value
	return(alteration)

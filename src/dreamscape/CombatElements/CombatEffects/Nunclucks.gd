extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		subject: Node = null) -> int:
	if not script.script_name == 'modify_damage'\
			or not "Attack" in script.get_property(SP.KEY_TAGS)\
			or not is_source:
		return(0)
	var multiplier := 1
	if upgrade == "massive":
		multiplier = 2
	var disempower_stacks = subject.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower.name)
	var new_value = value + (disempower_stacks * multiplier)
	var alteration = new_value - value
#	print_debug("Advantage ({value} * 2) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	# This is the only way to reduce the stack only when all effects in the same card are resolved
	return(alteration)

extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		is_source := false, 
		dry_run := true,
		_subject: Node = null) -> int:
	if not script.script_name == 'modify_damage'\
			or not "Attack" in script.get_property(SP.KEY_TAGS)\
			or not is_source:
		return(0)
	var new_value: int
	if upgrade == 'powerful':
		new_value = value * 3
	else:
		new_value = value * 2
	var alteration = new_value - value
#	print_debug("Advantage ({value} * 2) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	# This is the only way to reduce the stack only when all effects in the same card are resolved
	if not dry_run:
		sceng.connect("tasks_completed", self, "_on_all_sceng_tasks_completed")
	return(alteration)

func _on_all_sceng_tasks_completed() -> void:
	set_stacks(stacks - 1)
	

extends CombatEffect

const _description_string := "{effect_name}: The next {amount} actions doing {damage} by this {entity} are doubled."

func _ready() -> void:
	description_string = _description_string

func get_effect_alteration(script: ScriptTask, value: int, sceng, is_source := false, dry_run := true) -> int:
	if not script.script_name == 'modify_health'\
			or not "Damage" in script.get_property(SP.KEY_TAGS)\
			or not is_source:
		return(0)
	var new_value = value * 2
	var alteration = new_value - value
#	print_debug("Advantage ({value} * 2) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	# This is the only way to reduce the stack only when all effects in the same card are resolved
	if not dry_run:
		sceng.connect("tasks_completed", self, "_on_all_sceng_tasks_completed")
	return(alteration)

func _on_all_sceng_tasks_completed() -> void:
	set_stacks(stacks - 1)
	

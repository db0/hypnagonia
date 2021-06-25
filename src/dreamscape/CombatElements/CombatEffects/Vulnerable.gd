extends CombatEffect

const _description_string := "{effect_name}: {defence} added to this {entity} is reduced by 25%.\n" \
		+ "Reduce these stacks by 1 at the end of the turn."

func _ready() -> void:
	description_string = _description_string


func get_effect_alteration(script: ScriptTask, value: int, sceng, is_source := false, dry_run := true) -> int:
	if not script.script_name == 'assign_defence' or is_source:
		return(0)
	var new_value = round(value * 0.75)
	var alteration = new_value - value
#	print_debug("Vulnerability ({value} * 0.7) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	return(alteration)

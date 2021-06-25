extends CombatEffect

const _description_string := "{effect_name}: Add {amount} {energy} at the start of the turn.\n"\
		+ "All {health} taken is increased by {double_amount}\n."

func _ready() -> void:
	description_string = _description_string


func get_effect_alteration(script: ScriptTask, value: int, sceng, is_source := false, dry_run := true) -> int:
	if not script.script_name == 'modify_health'\
			or not "Damage" in script.get_property(SP.KEY_TAGS)\
			or is_source:
		return(0)
	var new_value = value + (2 * stacks)
	var alteration = new_value - value
#	print_debug("Vulnerability ({value} * 0.7) = {new_value} (alteration = {alteration})".format({"value": value, "new_value": new_value, "alteration": alteration }))
	return(alteration)

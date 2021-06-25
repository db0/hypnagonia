extends CombatEffect

const _description_string := "{effect_name}: No {health} is taken this turn.\n" \
		+ "Reduce these stacks by 1 at the start of the turn."

func _ready() -> void:
	description_string = _description_string


func get_effect_alteration(script: ScriptTask, value: int, sceng, is_source := false, dry_run := true) -> int:
	if not script.script_name == 'modify_health'\
			or not "Damage" in script.get_property(SP.KEY_TAGS)\
			or is_source:
		return(0)
	var new_value = 0
	var alteration = new_value - value
	return(alteration)

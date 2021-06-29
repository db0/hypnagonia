extends CombatEffect

const _description_string := "{effect_name}: No {health} is taken this turn.\n" \
		+ "Reduce these stacks by 1 at the start of the turn."

func _ready() -> void:
	description_string = _description_string


func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	if not script.script_name == 'modify_damage'\
			or not "Damage" in script.get_property(SP.KEY_TAGS)\
			or is_source:
		return(0)
	var new_value = 0
	var alteration = new_value - value
	return(alteration)

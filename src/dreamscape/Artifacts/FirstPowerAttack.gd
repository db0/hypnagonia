extends Artifact

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	if not script.script_name == 'modify_damage'\
			or not "Attack" in script.get_property(SP.KEY_TAGS)\
			or not is_source\
			or not is_active:
		return(0)
	var new_value = value + 8
	var alteration = new_value - value
	# This effect triggers only once per battle
	if not _dry_run:
		is_active = false
	return(alteration)

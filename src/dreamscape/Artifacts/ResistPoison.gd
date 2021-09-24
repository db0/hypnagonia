extends Artifact

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	if script.script_name != 'apply_effect'\
			or script.get_property("effect_name") != Terms.ACTIVE_EFFECTS.poison.name\
			or is_source\
			or not is_active:
		return(0)
	var new_value = value - ArtifactDefinitions.ResistPoison.amounts.alteration_amount
	var alteration = new_value - value
	return(alteration)

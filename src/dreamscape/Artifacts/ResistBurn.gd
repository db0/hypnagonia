extends Artifact

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		_sceng, 
		is_source := false, 
		dry_run := true,
		_subject: Node = null) -> int:
	if script.script_name != 'apply_effect':
		return(0)
	if script.get_property("effect_name") != Terms.ACTIVE_EFFECTS.burn.name:
		return(0)
	if not is_active:
		return(0)
	if script.subjects[0] != cfc.NMAP.board.dreamer:
		return(0)
	var new_value = value - ArtifactDefinitions.ResistBurn.amounts.alteration_amount
	var alteration = new_value - value
	if not dry_run:
		_send_trigger_signal()
	return(alteration)

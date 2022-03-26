extends Artifact

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	var is_currently_active = snapshot_is_active.get(sceng.snapshot_id, is_active)
	if not script.script_name == 'modify_damage'\
			or not "Attack" in script.get_property(SP.KEY_TAGS)\
			or not is_source\
			or not is_currently_active:
		return(0)
	var new_value = value + ArtifactDefinitions.FirstPowerAttack.amounts.effect_amount
	var alteration = new_value - value
	# This effect triggers only once per battle
	if sceng.snapshot_id > 0:
		snapshot_is_active[sceng.snapshot_id] = false
	elif not _dry_run:
		is_active = false
		_send_trigger_signal()
	return(alteration)

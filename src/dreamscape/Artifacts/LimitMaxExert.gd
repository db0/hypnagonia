extends Artifact

func get_effect_alteration(
		script: ScriptTask,
		value: int,
		_sceng,
		is_source := false,
		dry_run := true,
		_subject: Node = null) -> int:
	if script.script_name != 'modify_damage':
		return(0)
	if not script.get_property(SP.KEY_TAGS).has('Exert'):
		return(0)
	if not cfc.NMAP.board.turn.encounter_event_count.get("player_total_damage_own_turn",0) < ArtifactDefinitions.LimitMaxExert.amounts.exert_amount:
		return(0)
	if script.subjects[0] != cfc.NMAP.board.dreamer:
		return(0)
	var new_value = 0
	var alteration = new_value - value
	if not dry_run:
		_send_trigger_signal()
	return(alteration)

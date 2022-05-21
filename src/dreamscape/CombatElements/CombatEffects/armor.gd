extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		is_source := false, 
		dry_run := true,
		_subject: Node = null) -> int:
	var stacks_amount = snapshot_stacks.get(sceng.snapshot_id, stacks)
	if stacks_amount == 0:
		return(0)
	if not script.script_name == 'modify_damage':
		return(0)
	if not "Attack" in script.get_property(SP.KEY_TAGS):
		return(0)
	if is_source:
		return(0)
	var new_value = value - stacks_amount
	if new_value < 0:
		new_value = 0
	if dry_run and sceng.snapshot_id > 0:
		# This can only happen if this effect was spawned as part of playing the card
		# but it was not yet there when taking the snapshot.
		# So we're using this as a failsafe
		if not snapshot_stacks.has(sceng.snapshot_id):
			snapshot_stacks[sceng.snapshot_id] = stacks
		snapshot_stacks[sceng.snapshot_id] -= 1
	elif value > 0:
		set_stacks(stacks - 1, ["Triggered"])
	var alteration = new_value - value
	return(alteration)

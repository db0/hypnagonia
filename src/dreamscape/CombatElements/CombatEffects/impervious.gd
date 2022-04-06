extends CombatEffect

func get_effect_alteration(
		script: ScriptTask,
		value: int,
		sceng,
		is_source := false,
		_dry_run := true,
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
	var reduction : float
	if sceng.snapshot_id > 0:
		# This can only happen if this effect was spawned as part of playing the card
		# but it was not yet there when taking the snapshot.
		# So we're using this as a failsafe
		if not snapshot_stacks.has(sceng.snapshot_id):
			snapshot_stacks[sceng.snapshot_id] = stacks
		reduction = 1 - (snapshot_stacks[sceng.snapshot_id] * 0.25)
		if reduction < 0.25:
			reduction = 0.25
		snapshot_stacks[sceng.snapshot_id] -= 1
		if snapshot_stacks[sceng.snapshot_id] < 0:
			snapshot_stacks[sceng.snapshot_id] = 0
	else:
		reduction = 1 - (stacks * 0.25)
		if reduction < 0.25:
			reduction = 0.25
		set_stacks(stacks - 1, ["Triggered"])
	var new_value = round(value * reduction)
	var alteration = new_value - value
	return(alteration)

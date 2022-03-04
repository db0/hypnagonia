extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	var stacks_amount = snapshot_stacks.get(sceng.snapshot_id, stacks)
	if stacks_amount == 0\
			or not script.script_name == 'modify_damage'\
			or value < 1\
			or is_source:
		return(0)
	if sceng.snapshot_id > 0:
		# This can only happen if this effect was spawned as part of playing the card
		# but it was not yet there when taking the snapshot.
		# So we're using this as a failsafe
		if not snapshot_stacks.has(sceng.snapshot_id):
			snapshot_stacks[sceng.snapshot_id] = stacks
	var new_value = 1
	var alteration = new_value - value
	return(alteration)


func _decrease_stacks() -> void:
	if stacks == 1:
		owning_entity.die()
	else:
		set_stacks(stacks - 1, ["Turn Decrease"])


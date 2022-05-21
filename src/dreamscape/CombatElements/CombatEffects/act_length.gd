extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		is_source := false, 
		dry_run := true,
		subject: Node = null) -> int:
	var stacks_amount = snapshot_stacks.get(sceng.snapshot_id, stacks)
	if stacks_amount == 0:
		return(0)
	if not script.script_name == 'modify_damage':
		return(0)
	if value < 1:
		return(0)
	if subject != owning_entity:
		return(0)
	if dry_run and sceng.snapshot_id > 0:
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


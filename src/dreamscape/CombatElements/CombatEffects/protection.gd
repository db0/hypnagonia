extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		is_source := false, 
		_dry_run := true,
		subject: Node = null) -> int:
	var stacks_amount = snapshot_stacks.get(sceng.snapshot_id, stacks)
	if stacks_amount == 0\
			or script.script_name != 'apply_effect'\
			or not (
				script.get_property("effect_name") in Terms.get_all_effect_types("Debuff", true)\
				or (
					script.get_property("effect_name") in Terms.get_all_effect_types("Versatile", true) and value < 0
				)
			)\
			or subject != owning_entity:
		return(0)
	if sceng.snapshot_id > 0:
		# This can only happen if this effect was spawned as part of playing the card
		# but it was not yet there when taking the snapshot.
		# So we're using this as a failsafe
		if not snapshot_stacks.has(sceng.snapshot_id):
			snapshot_stacks[sceng.snapshot_id] = stacks
		snapshot_stacks[sceng.snapshot_id] -= 1
	else:
		set_stacks(stacks - 1, ["Triggered"])
	var new_value = 0
	var alteration = new_value - value
	return(alteration)

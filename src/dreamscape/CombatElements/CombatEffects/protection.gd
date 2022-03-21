extends CombatEffect

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		is_source := false, 
		_dry_run := true,
		subject: Node = null) -> int:
	var stacks_amount = snapshot_stacks.get(sceng.snapshot_id, stacks)
	if stacks_amount == 0:
		return(0)
	if script.script_name != 'apply_effect':
		return(0)
	if subject != owning_entity:
		return(0)
	var exclude_dreamer_debuffs : bool = owning_entity.entity_type == Terms.ENEMY
	print_debug([owning_entity.canonical_name, exclude_dreamer_debuffs,script.get_property("effect_name"), value])
	print_debug([not script.get_property("effect_name") in Terms.get_all_effect_types("Debuff", exclude_dreamer_debuffs), not (script.get_property("effect_name") in Terms.get_all_effect_types("Versatile", exclude_dreamer_debuffs) and value >= 0)])
	if not script.get_property("effect_name") in Terms.get_all_effect_types("Debuff", exclude_dreamer_debuffs)\
			and not (script.get_property("effect_name") in Terms.get_all_effect_types("Versatile", exclude_dreamer_debuffs) 
				and value < 0):
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

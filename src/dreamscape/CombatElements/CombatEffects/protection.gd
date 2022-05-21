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
	if script.script_name != 'apply_effect':
		return(0)
	if subject != owning_entity:
		return(0)
	var exclude_dreamer_debuffs : bool = owning_entity.entity_type == Terms.ENEMY
	var effect_entry = Terms.get_term_entry(script.get_property("effect_name"), '')
	# Why not just add the effect as debuff directly and we're using "blocked_by_protection"? 
	# becasuse we do not want scripts which add random debuffs to have
	# a chance to add special debuffs in the mix
	if not script.get_property("effect_name") in Terms.get_all_effect_types("Debuff", exclude_dreamer_debuffs)\
			and not effect_entry.get("blocked_by_protection", false)\
			and not (script.get_property("effect_name") in Terms.get_all_effect_types("Versatile", exclude_dreamer_debuffs) 
				and value < 0):
		return(0)
	if dry_run and sceng.snapshot_id > 0:
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

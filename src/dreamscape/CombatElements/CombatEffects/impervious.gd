extends CombatEffect

const PCT_DECREASE := 0.25

func get_effect_alteration(
		script: ScriptTask,
		value: int,
		sceng,
		is_source := false,
		_dry_run := true,
		subject: Node = null) -> int:
	var pct_decrease := PCT_DECREASE
	var stacks_amount = snapshot_stacks.get(sceng.snapshot_id, stacks)
	if stacks_amount == 0:
		return(0)
	if not script.script_name == 'modify_damage':
		return(0)
	if not "Attack" in script.get_property(SP.KEY_TAGS):
		return(0)
	if is_source:
		return(0)
	if subject.entity_type == Terms.PLAYER and globals.player.find_artifact(ArtifactDefinitions.ImproveImpervious.canonical_name):
		pct_decrease += ArtifactDefinitions.ImproveImpervious.amounts.per_stack_modifier
	var reduction : float
	if sceng.snapshot_id > 0:
		# This can only happen if this effect was spawned as part of playing the card
		# but it was not yet there when taking the snapshot.
		# So we're using this as a failsafe
		if not snapshot_stacks.has(sceng.snapshot_id):
			snapshot_stacks[sceng.snapshot_id] = stacks
		reduction = snapshot_stacks[sceng.snapshot_id] * pct_decrease
		if reduction > pct_decrease * 3:
			reduction = pct_decrease * 3
		snapshot_stacks[sceng.snapshot_id] -= 1
		if snapshot_stacks[sceng.snapshot_id] < 0:
			snapshot_stacks[sceng.snapshot_id] = 0
	else:
		reduction = stacks * pct_decrease
		if reduction > pct_decrease * 3:
			reduction = pct_decrease * 3
		set_stacks(stacks - 1, ["Triggered"])
	var new_value = round(value * (1 - reduction))
	var alteration = new_value - value
	return(alteration)

extends CombatEffect

var pct_increase := 0.25

# To override. This is called by the scripting engine
# Is source is telling this script that the owning combat_entity is the one owning
# this alteration
func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	if not script.script_name == 'modify_damage':
		return(0)
	if not "Attack" in script.get_property(SP.KEY_TAGS):
		return(0)
	if is_source:
		return(0)
	if is_delayed:
		return(0)
	var increase : float
	if sceng.snapshot_id > 0:
		# This can only happen if this effect was spawned as part of playing the card
		# but it was not yet there when taking the snapshot.
		# So we're using this as a failsafe
		if not snapshot_stacks.has(sceng.snapshot_id):
			snapshot_stacks[sceng.snapshot_id] = stacks
		increase = snapshot_stacks[sceng.snapshot_id] * pct_increase
		if increase > pct_increase * 3:
			increase = pct_increase * 3
		snapshot_stacks[sceng.snapshot_id] -= 1
		if snapshot_stacks[sceng.snapshot_id] < 0:
			snapshot_stacks[sceng.snapshot_id] = 0
	else:
		increase = stacks * pct_increase
		if increase > pct_increase * 3:
			increase = pct_increase * 3
		set_stacks(stacks - 1, ["Triggered"])
	var new_value = round(value * (1 + increase))
	var alteration = new_value - value
	return(alteration)

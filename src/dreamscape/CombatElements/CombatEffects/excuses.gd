extends CombatEffect

# Stores how many times excuses have been used this turn
var uses := 0
var snapshot_uses: Dictionary

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		_is_source := false, 
		dry_run := true,
		subject: Node = null) -> int:
	var stacks_amount = stacks
	if stacks_amount == 0:
		return(0)
	if not script.script_name == 'modify_damage':
		return(0)
	if cfc.NMAP.board.turn.current_turn != cfc.NMAP.board.turn.Turns.PLAYER_TURN:
		return(0)
	if "Intent" in script.get_property("tags"):
		return(0)
	if subject != owning_entity:
		return(0)
	var new_value := value
	var multiplier = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_threshold")
	var available_uses = stacks * multiplier
	if dry_run and sceng.snapshot_id > 0:
		if not snapshot_uses.has(sceng.snapshot_id):
			snapshot_uses[sceng.snapshot_id] = uses
		if value > 1 and snapshot_uses[sceng.snapshot_id] < available_uses:
			new_value = 1
			snapshot_uses[sceng.snapshot_id] += 1
	elif value > 1 and uses < available_uses:
		new_value = 1
		uses += 1

	# I darken the effect to show it's been used for this turn
	if uses >= available_uses and not dry_run: 
		modulate = Color(0.3,0.3,0.3)
	var alteration = new_value - value
	return(alteration)

func _on_player_turn_started(_turn) -> void:
	uses = 0
	modulate = Color(1,1,1)

func take_snapshot(snapshot_id: float) -> void:
	.take_snapshot(snapshot_id)
	snapshot_uses[snapshot_id] = uses

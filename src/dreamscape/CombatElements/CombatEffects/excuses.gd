extends CombatEffect

# Stores how many times excuses have been used this turn
var uses := 0

func get_effect_alteration(
		script: ScriptTask, 
		value: int, 
		sceng, 
		_is_source := false, 
		_dry_run := true,
		_subject: Node = null) -> int:
	var stacks_amount = stacks
	if stacks_amount == 0\
			or not script.script_name == 'modify_damage'\
			or sceng.snapshot_id > 0\
			or cfc.NMAP.board.turn.current_turn != cfc.NMAP.board.turn.Turns.PLAYER_TURN:
		return(0)
	var new_value := value
	var available_uses = stacks
	if upgrade == "endless":
		available_uses = stacks * 2
	if value > 1 and uses < available_uses:
		new_value = 1
		if not _dry_run:
			uses += 1
	# I darken the effect to show it's been used for this turn
	if uses >= available_uses and not _dry_run: 
		modulate = Color(0.3,0.3,0.3)
	var alteration = new_value - value
	return(alteration)

func _on_player_turn_started(_turn) -> void:
	uses = 0
	modulate = Color(1,1,1)

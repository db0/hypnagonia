extends CombatEffect



func _on_player_turn_started(turn: Turn) -> void:
	._on_player_turn_started(turn)
	if is_delayed:
		return
	cfc.NMAP.board.counters.mod_counter("immersion", stacks, false, false, self, ["Effect"])
	set_stacks(0, ["Turn Decrease"])
	

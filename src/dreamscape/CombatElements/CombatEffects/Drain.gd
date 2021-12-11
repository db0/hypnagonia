extends CombatEffect

func _on_player_turn_started(turn: Turn) -> void:
	if not is_delayed:
		cfc.NMAP.board.counters.mod_counter("immersion", -stacks, false, false, self, ["New Turn"])
		set_stacks(0, ["Turn Decrease"])
	._on_player_turn_started(turn)
	

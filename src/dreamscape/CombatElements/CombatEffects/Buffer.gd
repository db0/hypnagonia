extends CombatEffect



func _on_player_turn_started(turn: Turn) -> void:
	._on_player_turn_started(turn)
	cfc.NMAP.board.counters.mod_counter("immersion", stacks, false, false, self, ["New Turn"])
	set_stacks(0)
	

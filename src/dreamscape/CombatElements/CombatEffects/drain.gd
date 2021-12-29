extends CombatEffect

# We do not use the typical turn_started reduction to avoid it being reduced 
# before we adjust the immersion
func _on_player_turn_started(turn: Turn) -> void:
	if not is_delayed:
		cfc.NMAP.board.counters.mod_counter(
			"immersion", -stacks,
			false, false, self,
			["New Turn", "Combat Effect", "Debuff"])
		set_stacks(0, ["Turn Decrease"])
	._on_player_turn_started(turn)
	

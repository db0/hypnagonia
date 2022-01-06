extends CombatEffect


func _decrease_stacks() -> void:
	cfc.NMAP.board.counters.mod_counter(
		"immersion", -stacks,
		false, false, self,
		["New Turn", "Combat Effect", "Debuff", "Drain"])
#	cfc.NMAP.board.counters.mod_counter("immersion", stacks, false, false, self, ["Combat Effect", "Buff"])
	._decrease_stacks()

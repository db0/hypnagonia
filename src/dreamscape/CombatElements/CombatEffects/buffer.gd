extends CombatEffect


func _decrease_stacks() -> void:
	cfc.NMAP.board.counters.mod_counter(
		"immersion", stacks,
		false, false, self,
		# We send the effect name in the tags, as it's used in the turn to record
		# an event. This is used in cards like Hyperfocus
		["New Turn", "Combat Effect", "Buff", "Buffer"])
#	cfc.NMAP.board.counters.mod_counter("immersion", stacks, false, false, self, ["Combat Effect", "Buff"])
	._decrease_stacks()

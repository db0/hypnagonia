extends CombatEffect


func _ready() -> void:
	connect("stacks_modified", self, "_on_stacks_modified")

func _on_stacks_modified(value) -> void:
	cfc.NMAP.hand.refill_amount = 5 - value
	if value >= 3:
		cfc.NMAP.hand.discard_at_turn_end = false
	else:
		cfc.NMAP.hand.discard_at_turn_end = true

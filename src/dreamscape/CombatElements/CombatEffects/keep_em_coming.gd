extends CombatEffect

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")

func _on_cfc_signal_received(trigger_card, trigger, details) -> void:
	if trigger != "card_moved_to_pile":
		return
	if details.destination.to_lower() != "forgotten":
		return
	var script = [{
		"name": "draw_cards",
		"tags": ["Card"],
		"card_count": stacks
	},]
	execute_script(script,trigger_card)

extends CombatEffect

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")


func _on_cfc_signal_received(_trigger_card, trigger, _details) -> void:
	if not trigger == "cards_fused":
		return
	var script = [{
		"name": "draw_cards",
		"tags": ["Card"],
		"card_count": stacks
	},]
	execute_script(script)

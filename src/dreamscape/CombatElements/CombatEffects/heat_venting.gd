extends CombatEffect

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")


func _on_cfc_signal_received(_trigger_card, trigger, _details) -> void:
	if not trigger == "cards_fused":
		return
	var multiplier = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_defence", 7)
	var script = [{
				"name": "assign_defence",
				"subject": "dreamer",
				"amount": stacks * multiplier,
				"tags": ["Combat Effect", "Concentration"],
			}]
	execute_script(script)

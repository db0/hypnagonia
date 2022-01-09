extends CombatEffect

func _ready():
	# warning-ignore:return_value_discarded
	cfc.signal_propagator.connect("signal_received", self, "_on_signal_received")


func _on_signal_received(trigger_card, trigger, details) -> void:
	if trigger == "card_moved_to_pile" and details.destination.to_lower() == "forgotten":
		var multiplier = cfc.card_definitions['The Exam']\
				.get("_amounts",{}).get("concentration_amount", 1)
		var script = [{
			"name": "modify_damage",
			"subject": "dreamer",
			"amount": stacks * multiplier,
			"tags": ["Exert", "Combat Effect", "Concentration"],
		}]
		execute_script(script)

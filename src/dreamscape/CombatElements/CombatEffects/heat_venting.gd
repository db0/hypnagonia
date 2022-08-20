extends CombatEffect

func _ready() -> void:
	scripting_bus.connect("scripting_event_triggered", self, "_on_scripting_event_triggered")


func _on_scripting_event_triggered(_trigger_card, trigger, _details) -> void:
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

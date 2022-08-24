extends CombatEffect

func _ready() -> void:
	scripting_bus.connect("scripting_event_triggered", self, "_on_scripting_event_triggered")


func _on_scripting_event_triggered(_trigger_card, trigger, _details) -> void:
	if not trigger == "cards_fused":
		return
	var script = [{
		"name": "draw_cards",
		"tags": ["Card"],
		"card_count": stacks
	},]
	execute_script(script)

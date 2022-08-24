extends CombatEffect

func _ready() -> void:
	scripting_bus.connect("scripting_event_triggered", self, "_on_scripting_event_triggered")

func _on_scripting_event_triggered(trigger_card, trigger, details) -> void:
	if trigger != "card_moved_to_pile":
		return
	if details.destination.to_lower() != "forgotten":
		return
	var script = [{
		"name": "apply_effect",
		"tags": ["Combat Effect", "Concentration"],
		"effect_name": Terms.ACTIVE_EFFECTS.armor.name,
		"subject": "dreamer",
		"modification": stacks,
	}]
	execute_script(script)

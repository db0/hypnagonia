extends CombatEffect

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")

func _on_cfc_signal_received(trigger_card, trigger, details) -> void:
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

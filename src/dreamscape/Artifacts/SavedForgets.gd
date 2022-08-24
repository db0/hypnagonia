extends Artifact


func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		scripting_bus.connect("scripting_event_triggered", self, "_on_signal_received")


func _on_signal_received(trigger_card, trigger, details) -> void:
	if trigger != "card_moved_to_pile":
		return
	if details.destination.to_lower() != "forgotten":
		return
	# warning-ignore:return_value_discarded
	_activate()
	scripting_bus.disconnect("scripting_event_triggered", self, "_on_signal_received")
	var script = [{
		"name": "move_card_to_container",
		"subject": "trigger",
		"dest_container": "discard",
		"tags": ["Curio", "Card"],
	},]
	execute_script(script,trigger_card)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

extends Artifact


func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.signal_propagator.connect("signal_received", self, "_on_signal_received")


func _on_signal_received(trigger_card, trigger, details) -> void:
	if trigger != "card_moved_to_pile":
		return
	if details.destination.to_lower() != "forgotten":
		return
	# warning-ignore:return_value_discarded
	_activate()
	cfc.signal_propagator.disconnect("signal_received", self, "_on_signal_received")
	var script = [{
		"name": "move_card_to_container",
		"subject": "trigger",
		"dest_container": "discard",
		"tags": ["Curio", "Card"],
	},]
	execute_script(script,trigger_card)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

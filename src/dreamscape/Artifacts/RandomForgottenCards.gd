extends Artifact


func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		cfc.signal_propagator.connect("signal_received", self, "_on_signal_received")


func _on_signal_received(trigger_card, trigger, details) -> void:
	if trigger != "card_moved_to_pile":
		return
	if details.destination.to_lower() != "forgotten":
		return
	if "Spawned" in details.tags:
		return
	var script = [
		{
			"name": "spawn_card_to_container",
			"card_filters": [
				{
					'property': '_is_upgrade',
					'value': false,
				}
			],
			"dest_container": "hand",
			"object_count": ArtifactDefinitions.RandomForgottenCards.amounts.card_amount,
			"tags": ["Curio"],
		},
	]

	execute_script(script,trigger_card)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

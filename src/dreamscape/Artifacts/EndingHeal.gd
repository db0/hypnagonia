extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		# warning-ignore:return_value_discarded
		EventBus.connect("battle_ended", self, "_on_battle_ended")

func _on_battle_ended() -> void:
	globals.player.damage -= 6
	_send_trigger_signal()

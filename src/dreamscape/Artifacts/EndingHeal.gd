extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		EventBus.connect("battle_ended", self, "_on_battle_ended")

func _on_battle_ended() -> void:
	globals.player.damage -= 6
	_send_trigger_signal()

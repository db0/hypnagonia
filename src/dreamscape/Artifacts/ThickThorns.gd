extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		EventBus.connect("battle_begun", self, "_on_battle_start")


func _on_player_turn_started(_turn: Turn = null) -> void:
	if _is_activated:
		return
	var script = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
			"subject": "dreamer",
			"modification": ArtifactDefinitions.ThickThorns.amounts.effect_stacks,
			"tags": ["Curio"],
		},
	]
	execute_script(script)


# Connecting the signal here ensures the artifact will not be disabled at the start of combat
func _on_battle_start() -> void:
	cfc.NMAP.deck.connect("shuffle_completed", self, "_on_reshuffle")


func _on_reshuffle(_pile: Pile) -> void:
	var script = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
			"subject": "dreamer",
			"modification": -ArtifactDefinitions.ThickThorns.amounts.detrimental_integer,
			"tags": ["Curio"],
		},
	]
	execute_script(script)
	_send_trigger_signal()

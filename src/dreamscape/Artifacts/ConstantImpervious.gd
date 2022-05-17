extends Artifact

func _on_player_turn_started(_turn: Turn = null) -> void:
	var script = [{
		"name": "apply_effect",
		"tags": ["Curio"],
		"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
		"subject": "dreamer",
		"modification": ArtifactDefinitions.ConstantImpervious.amounts.effect_stacks,
	}]
	execute_script(script)

func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

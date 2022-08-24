extends Artifact


func _on_player_turn_started(_turn: Turn) -> void:
	var script = [
		{
			"name": "apply_effect",
			"tags": ["Card"],
			"effect_name": Terms.ACTIVE_EFFECTS.marked.name,
			"subject": "boardseek",
			"sort_by": "random",
			"modification": ArtifactDefinitions.ConstantMark.amounts.effect_stacks,
			"filter_state_seek": [{
				"filter_group": "EnemyEntities",
			},],
		},
	]
	execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

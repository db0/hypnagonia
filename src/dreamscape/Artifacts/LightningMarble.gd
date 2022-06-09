extends Artifact


func _on_player_turn_ended(_turn: Turn) -> void:
	var script = [
		{
			"name": "modify_damage",
			"subject": "boardseek",
			"amount": ArtifactDefinitions.LightningMarble.amounts.damage_amount,
			"subject_count": 1,
			"sort_by": "random",
			"tags": ["Attack", "Curio"],
			"filter_state_seek": [{
				"filter_group": "EnemyEntities",
			},],
		},
	]
	execute_script(script)

func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

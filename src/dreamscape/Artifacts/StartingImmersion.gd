extends Artifact

func _on_player_turn_started(_turn: Turn = null) -> void:
	if not _activate():
		return
	var script = [
		{
			"name": "mod_counter",
			"counter_name": "immersion",
			"modification": ArtifactDefinitions.StartingImmersion.amounts.immersion_amount,
		},
	]
	execute_script(script)

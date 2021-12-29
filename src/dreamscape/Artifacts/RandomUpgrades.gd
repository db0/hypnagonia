extends Artifact

func _on_player_turn_started(_turn: Turn = null) -> void:
	var script = [
		{
			"name": "mod_counter",
			"counter_name": "immersion",
			"tags": ["Curio"],
			"modification": ArtifactDefinitions.RandomUpgrades.amounts.immersion_amount,
		},
	]
	execute_script(script)

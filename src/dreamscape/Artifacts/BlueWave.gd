extends Artifact


func _on_player_turn_started(_turn: Turn) -> void:
	var counter = 0
	for c in cfc.NMAP.hand.get_all_cards():
		if c.get_property("Type") == "Control":
			counter += 1
	if counter >= ArtifactDefinitions.PurpleWave.amounts.threshold:
		var script = [
			{
				"name": "modify_damage",
				"subject": "boardseek",
				"amount": ArtifactDefinitions.BlueWave.amounts.damage_amount,
				"subject_count": "all",
				"tags": ["Attack", "Curio"],
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
			},
		]
		execute_script(script)

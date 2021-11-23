extends Artifact


func _on_player_turn_started(_turn: Turn) -> void:
	var counter = 0
	for c in cfc.NMAP.hand.get_all_cards():
		if c.get_property("Type") == "Understanding":
			counter += 1
	if counter >= ArtifactDefinitions.PurpleWave.amounts.threshold:
		var script = [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": -ArtifactDefinitions.PurpleWave.amounts.heal_amount,
				"tags": ["Healing"],
			},
		]
		execute_script(script)

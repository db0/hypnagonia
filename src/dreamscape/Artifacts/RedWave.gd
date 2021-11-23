extends Artifact


func _on_player_turn_started(_turn: Turn) -> void:
	var counter = 0
	for c in cfc.NMAP.hand.get_all_cards():
		if c.get_property("Type") == "Action":
			counter += 1
	if counter >= ArtifactDefinitions.PurpleWave.amounts.threshold:
		var script = [
			{
				"name": "assign_defence",
				"subject": "dreamer",
				"amount": ArtifactDefinitions.RedWave.amounts.defence_amount,
			}
		]
		execute_script(script)

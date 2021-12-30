extends Memory

func execute_memory_effect() -> void:
	var recovery = cfc.NMAP.board.turn.encounter_event_count.get("player_total_damage_own_turn",0)
	var script = [
		{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": -recovery,
				"tags": ["Healing", "Memory"],
		},
	]
	execute_script(script)

extends Memory

func execute_memory_effect():
	var recovery = cfc.NMAP.board.turn.encounter_event_count.get("player_total_damage_own_turn",0)
	var script = [
		{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": -recovery,
				"tags": ["Healing", "Memory"],
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

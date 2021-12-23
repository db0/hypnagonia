extends CombatEffect

func _on_player_turn_ended(turn: Turn) -> void:
	._on_player_turn_ended(turn)
	var tenacity = [{
		"name": "assign_defence",
		"subject": "dreamer",
		"amount": cfc.card_definitions[name]\
				.get("_amounts",{}).get("effect_defence"),
	}]
	execute_script(tenacity, cfc.NMAP.board.dreamer)

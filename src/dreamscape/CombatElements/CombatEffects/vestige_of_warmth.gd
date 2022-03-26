extends CombatEffect

func _on_player_turn_ended(_turn: Turn) -> void:
	var amount = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_effect")
	var cards_amount : int = cfc.NMAP.hand.get_card_count()
	var script = [{
		"name": "assign_defence",
		"subject": "dreamer",
		"amount": cards_amount * amount,
		"tags": ["Combat Effect", "Concentration"],
	}]
	execute_script(script)

extends CombatEffect

func _on_player_turn_started(_turn: Turn) -> void:
	var defence : int = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_defence")
	var discard_threshold : int = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_threshold")
	if cfc.NMAP.discard.get_card_count() <= discard_threshold:
		var unconventional = [{
					"name": "assign_defence",
					"subject": "dreamer",
					"amount": stacks * defence,
					"tags": ["Combat Effect", "Concentration"],
				}]
		execute_script(unconventional)

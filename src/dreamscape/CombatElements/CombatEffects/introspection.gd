extends CombatEffect

func _on_player_turn_ended(_turn: Turn) -> void:
	var multiplier = 2
	if upgrade == "deep":
		multiplier = 3
	var action_card_amount = 0
	if upgrade == "light":
		action_card_amount = 1
	var heal_amount : int = stacks * multiplier
	if cfc.NMAP.board.turn.turn_event_count.get("Action_played",0) > action_card_amount:
		return
	var script = [{
		"name": "modify_damage",
		"subject": "self",
		"amount": -heal_amount,
		"tags": ["Heal"],
	}]
	execute_script(script)

extends CombatEffect

func _on_player_turn_ended(_turn: Turn) -> void:
	var multiplier = 2
	if upgrade == "deep":
		multiplier = 3
	var action_card_amount = 0
	if upgrade == "light":
		action_card_amount = 1
	var heal_amount : int = multiplier
	if cfc.NMAP.board.turn.turn_event_count.get("Action_played",0) > action_card_amount:
		return
	var script = [{
		"name": "modify_damage",
		"subject": "dreamer",
		"amount": -heal_amount,
		"tags": ["Heal", "Combat Effect", "Concentration"],
	}]
	execute_script(script)
	set_stacks(stacks - 1)


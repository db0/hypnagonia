extends CombatEffect

func _on_player_turn_ended(_turn: Turn) -> void:
	var amount = cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_healing")
	var heal_amount : int = amount
	if cfc.NMAP.board.dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name):
		 heal_amount += amount
	var script = [{
		"name": "modify_damage",
		"subject": "self",
		"amount": -heal_amount,
		"tags": ["Heal", "Combat Effect", "Concentration"],
	}]
	execute_script(script)
	set_stacks(stacks - 1)

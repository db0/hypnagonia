extends CombatEffect

func _on_player_turn_started(_turn: Turn) -> void:
	var script = [
		{
			"name": "apply_effect",
			"tags": ["Concentration", "Combat Effect"],
			"subject": "dreamer",
			"modification": stacks,
			"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
		},
	]
	print_debug(script)
	execute_script(script)

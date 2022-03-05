extends CombatEffect

func _on_enemy_turn_ended(_turn: Turn) -> void:
	var script = [{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
			"subject": "self",
			"modification": stacks,
			"tags": ["Effect"],
		},]
	execute_script(script)

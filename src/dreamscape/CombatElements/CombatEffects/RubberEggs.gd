extends CombatEffect

func _on_turn_ended(turn: Turn) -> void:
	._on_turn_ended(turn)
	var all_enemies := get_tree().get_nodes_in_group("EnemyEntities")
	for _iter in range(stacks):
		CFUtils.shuffle_array(all_enemies)
		for rng_enemy in all_enemies:
			if rng_enemy.active_effects.get_effect(Terms.ACTIVE_EFFECTS.disempower.name):
				var egg = [{
					"name": "modify_damage",
					"subject": "trigger",
					"amount": 6,
					"tags": ["Damage"],
				}]
				execute_script(egg, rng_enemy)
				break

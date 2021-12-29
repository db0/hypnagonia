extends CombatEffect

# Do not set self_decreasing, as the reduction happens in poison_courses()
# To avoid the stacks decreasing before it fires

func _on_enemy_turn_started(_turn: Turn) -> void:
	if entity_type == Terms.ENEMY:
		poison_courses()

func _on_player_turn_started(_turn: Turn) -> void:
	if entity_type == Terms.PLAYER:
		if is_delayed:
			is_delayed = false
		else:
			poison_courses()

func poison_courses() -> void:
	var script = [{
		"name": "modify_damage",
		"subject": "self",
		"amount": stacks,
		"tags": ["Poison", "Combat Effect", "Debuff"],
	}]
	execute_script(script)
	set_stacks(stacks - 1, ["Turn Decrease"])

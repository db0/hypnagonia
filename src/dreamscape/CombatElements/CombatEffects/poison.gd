extends CombatEffect


func _decrease_stacks() -> void:
	var script = [{
		"name": "modify_damage",
		"subject": "self",
		"amount": stacks,
		"tags": ["Poison", "Combat Effect", "Debuff"],
	}]
	execute_script(script)
	set_stacks(stacks - 1, ["Turn Decrease"])

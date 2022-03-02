extends CombatEffect


func _decrease_stacks() -> void:
	if stacks == 1:
		owning_entity.die()
		if globals.current_encounter as EnemyEncounter:
			globals.current_encounter.disabled_extra_draft_rewards.append(owning_entity.canonical_name)
	else:
		set_stacks(stacks - 1, ["Turn Decrease"])

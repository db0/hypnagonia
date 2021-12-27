extends Memory

func execute_memory_effect() -> void:
	var script = [
		{
			"name": "modify_damage",
			"subject": "boardseek",
			"amount": MemoryDefinitions.DamageAll.amounts.damage_amount,
			"subject_count": "all",
			"tags": ["Memory", "Blockable"],
			"filter_state_seek": [{
				"filter_group": "EnemyEntities",
			},],
		},
	]
	execute_script(script)

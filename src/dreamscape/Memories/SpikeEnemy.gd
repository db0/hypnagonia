extends Memory

func execute_memory_effect() -> void:
	var script = [
		{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": MemoryDefinitions.SpikeEnemy.amounts.damage_amount,
				"tags": ["Attack"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
		},
	]
	execute_script(script)

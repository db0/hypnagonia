extends Memory

func execute_memory_effect() -> void:
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.SpikeEnemy.amounts.upgrade_amount
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

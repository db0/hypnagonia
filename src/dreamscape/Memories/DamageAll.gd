extends Memory

func execute_memory_effect() -> void:
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.SpikeEnemy.amounts.upgrade_multiplier
	var script = [
		{
			"name": "modify_damage",
			"subject": "boardseek",
			"amount": MemoryDefinitions.DamageAll.amounts.damage_amount + upgrades,
			"subject_count": "all",
			"tags": ["Memory", "Blockable"],
			"filter_state_seek": [{
				"filter_group": "EnemyEntities",
			},],
		},
	]
	execute_script(script)

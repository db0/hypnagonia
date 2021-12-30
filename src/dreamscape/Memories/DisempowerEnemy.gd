extends Memory

func execute_memory_effect() -> void:
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.DisempowerEnemy.amounts.upgrade_multiplier
	var script = [
		{
				"name": "apply_effect",
				"tags": ["Memory"],
				"subject": "target",
				"needs_subject": true,
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"modification": MemoryDefinitions.DisempowerEnemy.amounts.effect_stacks + upgrades,
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
		},
	]
	execute_script(script)

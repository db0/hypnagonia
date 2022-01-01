extends Memory

func execute_memory_effect():
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.SpikeEnemy.amounts.upgrade_multiplier
	var script = [
		{
				"name": "modify_damage",
				"subject": "target",
				"needs_subject": true,
				"amount": MemoryDefinitions.SpikeEnemy.amounts.damage_amount + upgrades,
				"tags": ["Attack", "Memory"],
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

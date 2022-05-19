extends Memory

func execute_memory_effect():
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.SpikeEnemy.amounts.upgrade_multiplier
	var script = [
		{
			"name": "modify_damage",
			"subject": "boardseek",
			"amount": MemoryDefinitions.DamageAll.amounts.damage_amount + upgrades,
			"subject_count": "all",
			"tags": ["Memory", "Attack"],
			"filter_state_seek": [{
				"filter_group": "EnemyEntities",
			},],
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

extends Memory

func execute_memory_effect():
	var script = [
		{
				"name": "apply_effect",
				"tags": ["Memory"],
				"subject": "target",
				"needs_subject": true,
				"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
				"modification": MemoryDefinitions.PoisonEnemy.amounts.effect_stacks,
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

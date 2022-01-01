extends Memory

func execute_memory_effect():
	var script = [
		{
				"name": "apply_effect",
				"tags": ["Memory"],
				"effect_name": Terms.ACTIVE_EFFECTS.quicken.name,
				"subject": "dreamer",
				"modification": MemoryDefinitions.QuickenSelf.amounts.effect_stacks,
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

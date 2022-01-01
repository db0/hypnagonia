extends Memory

func execute_memory_effect():
	var script = [
			{
				"name": "mod_counter",
				"tags": ["Memory"],
				"counter_name": "immersion",
				"modification": MemoryDefinitions.ImmerseSelf.amounts.immersion_amount
			},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

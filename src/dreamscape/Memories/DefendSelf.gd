extends Memory

func execute_memory_effect():
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.DefendSelf.amounts.upgrade_multiplier
	var script = [
		{
			"name": "assign_defence",
			"tags": ["Memory"],
			"subject": "dreamer",
			"amount": MemoryDefinitions.DefendSelf.amounts.defence_amount + upgrades,
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

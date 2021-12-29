extends Memory

func execute_memory_effect() -> void:
	var script = [
		{
				"name": "apply_effect",
				"tags": ["Memory"],
				"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
				"subject": "dreamer",
				"modification": MemoryDefinitions.ImperviousSelf.amounts.effect_stacks,
		},
	]
	execute_script(script)

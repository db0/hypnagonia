extends Memory

func execute_memory_effect() -> void:
	var script = [
		{
				"name": "apply_effect",
				"tags": ["Memory"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": MemoryDefinitions.BufferSelf.amounts.effect_stacks,
		},
	]
	execute_script(script)

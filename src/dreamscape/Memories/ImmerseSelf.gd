extends Memory

func execute_memory_effect() -> void:
	var script = [
			{
				"name": "mod_counter",
				"tags": ["Memory"],
				"counter_name": "immersion",
				"modification": MemoryDefinitions.ImmerseSelf.amounts.effect_stacks
			},
	]
	execute_script(script)

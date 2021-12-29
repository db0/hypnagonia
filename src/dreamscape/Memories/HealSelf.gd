extends Memory

func execute_memory_effect() -> void:
	var script = [
		{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": MemoryDefinitions.HealSelf.amounts.heal_amount,
				"tags": ["Healing", "Memory"],
		},
	]
	execute_script(script)

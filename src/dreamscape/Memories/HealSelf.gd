extends Memory

func execute_memory_effect() -> void:
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.HealSelf.amounts.upgrade_multiplier
	var script = [
		{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": -MemoryDefinitions.HealSelf.amounts.heal_amount + upgrades,
				"tags": ["Healing", "Memory"],
		},
	]
	execute_script(script)

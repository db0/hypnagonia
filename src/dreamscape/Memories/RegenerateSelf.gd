extends Memory

func execute_memory_effect() -> void:
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.RegenerateSelf.amounts.upgrade_multiplier
	var script = [
		{
				"name": "apply_effect",
				"tags": ["Memory"],
				"effect_name": Terms.ACTIVE_EFFECTS.zen_of_flight.name,
				"subject": "dreamer",
				"modification": MemoryDefinitions.RegenerateSelf.amounts.turns_amount + upgrades,
		},
	]
	execute_script(script)

extends Memory

func execute_memory_effect() -> void:
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.ExertSelf.amounts.upgrade_multiplier
	var script = [
		{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": MemoryDefinitions.ExertSelf.amounts.exert_amount,
				"tags": ["Exert", "Memory"],
				"repeat": MemoryDefinitions.ExertSelf.amounts.repeat_amount + upgrades,
		},
	]
	execute_script(script)
	for _iter in range(int((MemoryDefinitions.ExertSelf.amounts.repeat_amount + upgrades) / 2)):
		var effect = cfc.NMAP.board.dreamer.active_effects.get_random_effect("Debuff")
		if effect:
			cfc.NMAP.board.dreamer.active_effects.mod_effect(effect, -1 , false, false, ["Memory"])
	

extends Memory

func execute_memory_effect():
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.RemoveDebuff.amounts.upgrade_multiplier
	var script = [
		{
			"name": "assign_defence",
			"tags": ["Memory"],
			"subject": "dreamer",
			"amount": MemoryDefinitions.RemoveDebuff.amounts.defence_amount + upgrades,
		},
	]
	var sceng = execute_script(script)
	var active_effects = cfc.NMAP.board.dreamer.active_effects
	var effect = active_effects.get_effect_with_most_stacks("Debuff")
	var stacks = MemoryDefinitions.RemoveDebuff.amounts.stacks_amount
	if effect:
		# If it's a versatile effect and we got it as a debuff, it means it has a negative value
		# So we need to increase it instead
		if effect in Terms.get_all_effect_types("Versatile"):
			active_effects.mod_effect(effect, stacks , false, false, ["Trigger"])
		else:
			active_effects.mod_effect(effect, -stacks , false, false, ["Trigger"])
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

class_name DreamerCombatEffectMemory
extends CombatEffectMemory

func execute_memory_effect():
	var script = [
		{
				"name": "apply_effect",
				"tags": ["Memory"],
				"effect_name": effect_name,
				"subject": "dreamer",
				"modification": memory_definition.amounts.effect_stacks + _get_upgrades_modifier(),
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

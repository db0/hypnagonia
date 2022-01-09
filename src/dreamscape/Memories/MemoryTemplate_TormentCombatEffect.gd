class_name TormentCombatEffectMemory
extends CombatEffectMemory

func execute_memory_effect():
	var script = [
		{
				"name": "apply_effect",
				"tags": ["Memory"],
				"subject": "target",
				"needs_subject": true,
				"effect_name": effect_name,
				"modification": memory_definition.amounts.effect_stacks + _get_upgrades_modifier(),
				"filter_state_subject": [{
					"filter_group": "EnemyEntities",
				},],
		},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

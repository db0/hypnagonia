extends "res://tests/HUTCommon_Ordeal.gd"

var combat_effects: Array

var effects_to_play := [
#	{
#		"name": ,
#		"amount": ,
#		"upgrade": ,
#	}
]

func before_each():
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	spawn_test_torments()
	for effect_payload in effects_to_play:
		var ce = spawn_effect(test_torment, effect_payload.name, effect_payload.amount, effect_payload.get("upgrade", ''))
	yield(yield_for(0.1), YIELD)
	for effect_payload in effects_to_play:
		if effect_payload.get("upgrade"):
			var cname = effect_payload.get("upgrade", '') + ' ' +  effect_payload.name
			combat_effects.append(test_torment.active_effects.get_effect(cname))
		else:
			combat_effects.append(test_torment.active_effects.get_effect(effect_payload.name))
			

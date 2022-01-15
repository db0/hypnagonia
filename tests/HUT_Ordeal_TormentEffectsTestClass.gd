extends "res://tests/HUTCommon_Ordeal.gd"

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
		spawn_effect(test_torment,effect_payload.name, effect_payload.amount, effect_payload.get("upgrade", ''))
	yield(yield_for(0.1), YIELD)


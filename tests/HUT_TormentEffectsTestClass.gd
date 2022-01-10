extends "res://tests/HUTCommon.gd"

var effects_to_play := [
#	{
#		"effect_name": ,
#		"amount": ,
#		"upgrade": ,
#	}
]

func before_each():
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	spawn_test_torment()
	for effect_payload in effects_to_play:
		spawn_effect(test_torment,effect_payload.effect_name, effect_payload.amount, effect_payload.get("upgrade", ''))
	yield(yield_for(0.1), YIELD)
#	test_torment.

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
		spawn_effect(dreamer,effect_payload.name, effect_payload.amount, effect_payload.get("upgrade", ''))
	yield(yield_for(0.1), YIELD)
	# Failsafe. Sometimes this happens
	for torment in test_torments:
		if not is_instance_valid(torment):
			test_torments.erase(torment)


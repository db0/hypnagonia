extends "res://tests/HUTCommon_Ordeal.gd"

var intents_to_test := [
#	{
#		"intent_scripts": ["Stress:10"],
#		"reshuffle": true,
#	},
]

func before_each():
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	if not globals.test_flags.has("no_end_turn_delay"):
		globals.test_flags["no_end_turn_delay"] = true
	spawn_test_torments()
	test_torment.intents.replace_intents(intents_to_test)
	test_torment.intents.refresh_intents()
	yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
	turn.call_deferred("end_player_turn")
	yield(yield_to(scripting_bus, "player_turn_started",3 ), YIELD)

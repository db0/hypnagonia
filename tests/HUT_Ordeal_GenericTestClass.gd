extends "res://tests/HUTCommon_Ordeal.gd"

func before_each():
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	if not globals.test_flags.has("no_end_turn_delay"):
		globals.test_flags["no_end_turn_delay"] = true
	spawn_test_torments()

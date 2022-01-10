extends "res://tests/HUTCommon.gd"

var torments_to_spawn := []
var torments := []

func before_each():
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	for t in torments_to_spawn:
		torments.append(board.spawn_enemy(t))

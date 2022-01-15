extends "res://tests/HUTCommon_Journal.gd"

var testing_artifact_name: String
var artifact: Artifact

func before_each():
	testing_artifact_names.append(testing_artifact_name)
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	artifact = player_info.find_artifact(testing_artifact_name)

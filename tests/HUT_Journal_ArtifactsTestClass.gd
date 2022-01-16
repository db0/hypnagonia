extends "res://tests/HUTCommon_Journal.gd"

var testing_artifact_name: String
var artifact: Artifact
var expected_amount_keys := []

func before_each():
	if testing_artifact_name != '':
		testing_artifact_names.append(testing_artifact_name)
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	if testing_artifact_name != '':
		artifact = player_info.find_artifact(testing_artifact_name)

func get_amount(amount_key: String):
	var requested_amount = artifact.artifact_object.definition.get("amounts", {}).get(amount_key)
	return(requested_amount)

# Will return true if not all asserts succeed
func assert_has_amounts() -> bool:
	assert_true(ArtifactDefinitions.artifact_exists(testing_artifact_name), "Artifact %s should exist" % [testing_artifact_name])
	var artifact_def = ArtifactDefinitions.find_artifact_from_canonical_name(testing_artifact_name)
	if artifact_def != null:
		if expected_amount_keys.empty():
			return(true)
		assert_has(artifact_def, "amounts", "Artifact %s should have _amounts" % [testing_artifact_name])
		var amounts = artifact_def.get("amounts")
		if amounts:
			for akey in expected_amount_keys:
				assert_has(amounts, akey, "Artifact %s amounts should have key: %s" % [testing_artifact_name, akey])
				return(true)
	return(false)

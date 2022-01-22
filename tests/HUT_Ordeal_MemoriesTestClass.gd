extends "res://tests/HUTCommon_Ordeal.gd"

var testing_memory_name: String
var memory: Memory
var expected_amount_keys := []


func before_each():
	if testing_memory_name != '':
		test_memories_names.append(testing_memory_name)
	var confirm_return = .before_each()
	if confirm_return is GDScriptFunctionState: # Still working.
		confirm_return = yield(confirm_return, "completed")
	spawn_test_torments()
	if testing_memory_name != '':
		memory = player_info.find_memory(testing_memory_name)
		watch_signals(memory)
	yield(yield_for(0.1), YIELD)

func get_amount(amount_key: String):
	var requested_amount = memory.artifact_object.definition.get("amounts", {}).get(amount_key)
	return(requested_amount)

# Will return true if not all asserts succeed
func assert_has_amounts() -> bool:
	assert_true(MemoryDefinitions.memory_exists(testing_memory_name), "Memory %s should exist" % [testing_memory_name])
	var memory_def = MemoryDefinitions.find_memory_from_canonical_name(testing_memory_name)
	if memory_def != null:
		if expected_amount_keys.empty():
			return(true)
		assert_has(memory_def, "amounts", "Memory %s should have _amounts" % [testing_memory_name])
		var amounts = memory_def.get("amounts")
		if amounts:
			for mkey in expected_amount_keys:
				assert_has(amounts, mkey, "Memory %s amounts should have key: %s" % [testing_memory_name, mkey])
				return(true)
	return(false)

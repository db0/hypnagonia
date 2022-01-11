extends "res://tests/HUT_TormentEffectsTestClass.gd"

func _init() -> void:
	
	test_card_names = [
		"Confidence",
	]

# I don't know why, but in Gihub actions, the first test it runs
# always fails. Scripts just fail to execute and sceng is null.
# It sounds like a loading issue (like maybe cfc is not finished loading?)
# but no matter how much extra time I make it wait, it is still happening
# As such, as a workaround, I'm adding this test, which should typically execute first
func test__aa_dummy_test():
	var sceng = card.execute_scripts()
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	assert_true(true)

extends "res://tests/HUTCommon_Ordeal.gd"

class TestOnceOff:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func test_no_problem():
		watch_signals(hand)
		var c1 = add_single_card("Inner Justice", hand)
		var c2 = add_single_card("Confidence", hand)
		for c in [c1, c2]:
			c.modify_property("Tags", Terms.GENERIC_TAGS.once_off.name)
		var sceng = c1.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(c2.check_play_costs(), CFConst.CostsState.OK)

	func test_non_upgraded():
		watch_signals(hand)
		var c1 = add_single_card("Confidence", hand)
		var c2 = add_single_card("Confidence", hand)
		for c in [c1, c2]:
			c.modify_property("Tags", Terms.GENERIC_TAGS.once_off.name)
		var sceng = c1.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(c2.check_play_costs(), CFConst.CostsState.IMPOSSIBLE)

	func test_upgraded():
		watch_signals(hand)
		var c1 = add_single_card("+ Confidence +", hand)
		var c2 = add_single_card("+ Confidence +", hand)
		for c in [c1, c2]:
			c.modify_property("Tags", Terms.GENERIC_TAGS.once_off.name)
		var sceng = c1.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(c2.check_play_costs(), CFConst.CostsState.IMPOSSIBLE)

	func test_upgraded_non_upgraded():
		watch_signals(hand)
		var c1 = add_single_card("Confidence", hand)
		var c2 = add_single_card("+ Confidence +", hand)
		for c in [c1, c2]:
			c.modify_property("Tags", Terms.GENERIC_TAGS.once_off.name)
		var sceng = c1.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(c2.check_play_costs(), CFConst.CostsState.IMPOSSIBLE)

	func test_non_upgraded_upgraded():
		watch_signals(hand)
		var c1 = add_single_card("+ Confidence +", hand)
		var c2 = add_single_card("Confidence", hand)
		for c in [c1, c2]:
			c.modify_property("Tags", Terms.GENERIC_TAGS.once_off.name)
		var sceng = c1.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(c2.check_play_costs(), CFConst.CostsState.IMPOSSIBLE)

	func test_mix_upgraded():
		watch_signals(hand)
		var c1 = add_single_card("+ Confidence +", hand)
		var c2 = add_single_card("- Confidence -", hand)
		for c in [c1, c2]:
			c.modify_property("Tags", Terms.GENERIC_TAGS.once_off.name)
		var sceng = c1.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(c2.check_play_costs(), CFConst.CostsState.IMPOSSIBLE)

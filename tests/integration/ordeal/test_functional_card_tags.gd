extends "res://tests/HUTCommon_Ordeal.gd"

class TestTags:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	var alpha1: CardEntry
	var alpha2: CardEntry
	var omega1: CardEntry

	func _init() -> void:
		globals.test_flags["no_refill"] = false
		globals.test_flags["test_initial_hand"] = true

	func extra_hypnagonia_setup() -> void:
		alpha1 = globals.player.deck.add_new_card("^ Sneaky-Beaky ^")
		alpha2 = globals.player.deck.add_new_card("^ Absurdity Unleashed ^")
		omega1 = globals.player.deck.add_new_card("Ω Excogitate Ω")

	func test_frozen_alpha_and_omega():
		alpha1.card_object.properties.Tags.append(Terms.GENERIC_TAGS.frozen.name)
		assert_true(hand.has_card(alpha1.card_object), "Alpha cards should start in hand")
		assert_true(hand.has_card(alpha2.card_object), "Alpha cards should start in hand")
		assert_eq(deck.get_bottom_card(), omega1.card_object, "Omega cards should start at the deck bottom")
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started", 3), YIELD)
		assert_true(hand.has_card(alpha1.card_object), "Frozen cards should stay in hand")
		assert_eq(hand.get_card_count(), 6, "Hand refill ignores frozen cards")

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

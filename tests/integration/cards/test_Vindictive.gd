extends "res://tests/HUT_Ordeal_CardTestClass.gd"

class TestStoreInMind:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Store in Mind"
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		expected_amount_keys = [
			"beneficial_integer",
		]
		test_card_names = [
			"Store in Mind",
			"Keep in Mind",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		var selwindows = get_tree().get_nodes_in_group("selection_windows")
		assert_ne(selwindows.size(), 0)
		if not selwindows.size():
			return
		var selection_window : SelectionWindow = selwindows[0]
		yield(yield_to(selection_window, "selection_window_opened", 1), YIELD)
		var card_options = selection_window.get_all_card_options()
		for sel_card in card_options:
			assert_does_not_have(sel_card.properties.Tags, Terms.GENERIC_TAGS.frozen.name, "Cards with frozen are excluded")
		selection_window.select_cards([0])
		assert_has(card_options[0].properties.Tags, Terms.GENERIC_TAGS.frozen.name, "Chosen card got frozen tag")

class TestKeepInMind:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Keep in Mind"
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		expected_amount_keys = [
			"beneficial_integer",
		]
		test_card_names = [
			"Keep in Mind",
			"Store in Mind",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var found_frozen := 0
		for sel_card in hand.get_all_cards():
			if sel_card.properties.Tags.has(Terms.GENERIC_TAGS.frozen.name):
				found_frozen += 1
		assert_eq(found_frozen, 2, "One random card got frozen tag")

class TestAngerMemento:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Memento of Anger"
		expected_amount_keys = [
			"damage_amount",
			"damage_amount2",
		]
		test_card_names = [
			"Memento of Anger",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")))

	func test_frozen_card_results():
		assert_has_amounts()
		card.properties.Tags.append(Terms.GENERIC_TAGS.frozen.name)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount") + get_amount("damage_amount2")))

class TestFistofCandies:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		testing_card_name = "Fist of Candies"
		expected_amount_keys = [
			"damage_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount") * 6))

class TestMovingOn:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Moving On"
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		expected_amount_keys = [
			"draw_amount",
			"discard_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		yield(yield_for(0.3), YIELD)
		var selwindows = get_tree().get_nodes_in_group("selection_windows")
		assert_ne(selwindows.size(), 0)
		if not selwindows.size():
			if sceng is GDScriptFunctionState:
				sceng = yield(sceng, "completed")
			return
		var selection_window : SelectionWindow = selwindows[0]
		yield(yield_to(selection_window, "selection_window_opened", 1), YIELD)
		var card_options = selection_window.get_all_card_options()
		var selcards = selection_window.select_cards([0])
		assert_eq(hand.get_card_count(), 6, "One extra card drawn")
		for c in selcards:
			assert_eq(c.get_parent(), discard, "Selected cards discarded")

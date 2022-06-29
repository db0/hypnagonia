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

class TestKeepInMindPlus:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "+ Keep in Mind +"
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		expected_amount_keys = [
			"beneficial_integer",
		]
		test_card_names = [
		]

	func test_card_results():
		var hcards = hand.get_all_cards()
		var other_cards := []
		for iter in hand.get_card_count():
			if hcards[iter].canonical_name != testing_card_name:
				other_cards.append(hcards[iter])
			if iter < 5:
				hcards[iter].modify_property("Tags", Terms.GENERIC_TAGS.frozen.name)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var found_frozen := 0
		for sel_card in other_cards:
			if sel_card.properties.Tags.has(Terms.GENERIC_TAGS.frozen.name):
				found_frozen += 1
		assert_eq(found_frozen, 5, "All random cards got frozen tag")
		assert_eq(card.get_parent(), forgotten, "Card Played")

class TestAngerMemento:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.burn.name
	func _init() -> void:
		testing_card_name = "Memento of Anger"
		expected_amount_keys = [
			"damage_amount",
			"effect_stacks",
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
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), 0,
				"%s stacks on Torment not increased" % [effect])
				
	func test_frozen_card_results():
		assert_has_amounts()
		card.properties.Tags.append(Terms.GENERIC_TAGS.frozen.name)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")))
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), int(get_amount("effect_stacks")),
				"%s stacks on Torment increased by correct amount" % [effect])

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
		assert_eq(hand.get_card_count(), 6 + get_amount("draw_amount") - get_amount("discard_amount"), "One extra card drawn")
		for c in selcards:
			assert_eq(c.get_parent(), discard, "Selected cards discarded")


class TestHandofGrudge:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.thorns.name
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		testing_card_name = "Hand of Grudge"
		expected_amount_keys = [
			"effect_stacks",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), int(get_amount("effect_stacks") * 6),
				"%s stacks on Dreamer increased by correct amount" % [effect])


class TestVestigeOfWarmth:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.vestige_of_warmth.name
	var amount = 1
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]

	func test_vestige():
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "enemy_turn_started",1), YIELD)
		var amount = cfc.card_definitions[effect]\
			.get("_amounts",{}).get("concentration_effect")
		assert_eq(dreamer.defence, hand.get_card_count() * amount)


class TestTheColdDish:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "The Cold Dish"
		expected_amount_keys = [
			"damage_amount",
			"beneficial_integer",
		]

	func test_card_results():
		assert_has_amounts()
		var original_cost = card.get_property("Cost")
		turn.call_deferred("end_player_turn")
		yield(yield_to(card, "scripts_executed",3), YIELD)
		assert_eq(card.get_property("Cost"), original_cost - get_amount("beneficial_integer"))
		turn.call_deferred("end_player_turn")
		yield(yield_to(card, "scripts_executed",3), YIELD)
		assert_eq(card.get_property("Cost"), original_cost - get_amount("beneficial_integer") * 2)



class TestNothingForgotten:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.nothing_forgotten.name
	var amount = 1
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]

	func test_vestige():
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		var frozens := 0
		for c in hand.get_all_cards():
			if c.get_property("Tags").has(Terms.GENERIC_TAGS.frozen.name):
				frozens += 1
		assert_eq(frozens, 1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		frozens = 0
		for c in hand.get_all_cards():
			if c.get_property("Tags").has(Terms.GENERIC_TAGS.frozen.name):
				frozens += 1
		assert_eq(frozens, 2)


class TestStewing:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Stewing"
		expected_amount_keys = [
			"defence_amount",
			"increase_amount",
		]

	func test_card_results():
		assert_has_amounts()
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount") + get_amount("increase_amount"))


class TestReactionary:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.thorns.name
	func _init() -> void:
		testing_card_name = "Reactionary"
		expected_amount_keys = [
			"damage_amount",
			"effect_stacks",
			"min_requirements_amount",
		]

	func test_no_stress():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")))
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"%s stacks on Dreamer not increased" % [effect])

	func test_stress():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:10"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")))
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Dreamer increased by correct amount" % [effect])


class TestGoingInTheBook:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.thorns.name
	func _init() -> void:
		testing_card_name = "That's Going in the Book"
		expected_amount_keys = [
			"effect_stacks",
		]

	func test_card_effect():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Dreamer increased by correct amount" % [effect])


class TestNoteTaking:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.note_taking.name
	var amount = 3
	func _init() -> void:
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]

	func test_effect():
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.thorns.name), amount,
				"%s stacks on Dreamer increased by correct amount" % [Terms.ACTIVE_EFFECTS.thorns.name])


class TestVengeance:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.thorns.name
	func _init() -> void:
		testing_card_name = "Unstoppable Vengeance"
		expected_amount_keys = [
			"beneficial_integer",
			"effect_stacks",
		]

	func test_card_effect():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.thorns.name, 5, '')
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(5 + get_amount("beneficial_integer") + get_amount("effect_stacks")))
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 5 + get_amount("effect_stacks"),
				"%s stacks on Dreamer increased by correct amount" % [effect])
				

class TestPlanning:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.thorns.name
	func _init() -> void:
		testing_card_name = "Planning"
		expected_amount_keys = [
			"damage_amount",
			"draw_amount",
		]

	func test_card_effect():
		var scard = add_single_card("That's Going in the Book", deck)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")))
		assert_eq(scard.get_parent(), hand)
				

class TestSavedforLater:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.empower.name
	func _init() -> void:
		testing_card_name = "Saved for Later"
		expected_amount_keys = [
			"defence_amount",
			"effect_stacks",
		]

	func test_card_results_with_thorns():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.thorns.name, 5, '')
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"))
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), int(get_amount("effect_stacks")),
				"%s stacks on Dreamer increased by correct amount" % [effect])

	func test_card_results_without_thorns():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"))
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"%s stacks on Dreamer not increased" % [effect])


class TestShadenfreude:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.schadenfreude.name
	var amount = 2
	func _init() -> void:
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]

	func test_effect():
		spawn_effect(test_torment, Terms.ACTIVE_EFFECTS.poison.name, 14, '')
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name), int(floor(amount * 14.0 / 5.0)),
				"%s stacks on Dreamer increased by correct amount" % [Terms.ACTIVE_EFFECTS.armor.name])


class TestReckoningTime:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.thorns.name
	func _init() -> void:
		testing_card_name = "Reckoning Time"
		expected_amount_keys = [
			"detrimental_percentage",
			"multiplier_amount",
		]

	func test_card_effect():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.thorns.name, 15, '')
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(15 * get_amount("multiplier_amount")))
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 15 - int(15 * get_amount("detrimental_percentage")),
				"%s stacks on Dreamer decreased by correct amount" % [effect])


class TestTheLastStraw:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.thorns.name
	func _init() -> void:
		testing_card_name = "The Last Straw"
		expected_amount_keys = [
			"beneficial_percentage",
			"beneficial_float",
		]

	func test_card_effect():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.thorns.name, 15, '')
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, int(15 / get_amount("beneficial_float")))
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 15 + 15 * get_amount("beneficial_percentage"),
				"%s stacks on Dreamer decreased by correct amount" % [effect])
		yield(yield_for(3.3), YIELD)
				

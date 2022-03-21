extends "res://tests/HUT_Ordeal_CardTestClass.gd"

class TestCannon:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.marked.name
	func _init() -> void:
		testing_card_name = "Cannon"
		expected_amount_keys = [
			"damage_amount",
			"effect_stacks",
			"fuse_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Torment increased by correct amount" % [effect])

class TestHiCannon:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.marked.name
	func _init() -> void:
		testing_card_name = "HiCannon"
		expected_amount_keys = [
			"damage_amount",
			"effect_stacks",
			"fuse_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Torment increased by correct amount" % [effect])

class TestMegaCannon:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.marked.name
	func _init() -> void:
		testing_card_name = "MegaCannon"
		expected_amount_keys = [
			"damage_amount",
			"effect_stacks",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Torment increased by correct amount" % [effect])

class TestVulcan:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Vulcan"
		expected_amount_keys = [
			"damage_amount",
			"chain_amount",
			"fuse_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount") * get_amount("chain_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])

class TestVulcan2:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Vulcan2"
		expected_amount_keys = [
			"damage_amount",
			"chain_amount",
			"fuse_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount") * get_amount("chain_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])

class TestVulcan3:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Vulcan3"
		expected_amount_keys = [
			"damage_amount",
			"chain_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount") * get_amount("chain_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])

class TestPhotonShield:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Photon Shield"
		expected_amount_keys = [
			"defence_amount",
			"fuse_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"),
				"%s gave correct amount of confidence" % [card.canonical_name])

class TestLumenShield:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.fortify.name
	func _init() -> void:
		testing_card_name = "Lumen Shield"
		expected_amount_keys = [
			"defence_amount",
			"effect_stacks",
			"fuse_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"),
				"%s gave correct amount of confidence" % [card.canonical_name])
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Dreamer increased by correct amount" % [effect])

class TestPlasmaShield:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.fortify.name
	func _init() -> void:
		testing_card_name = "Plasma Shield"
		expected_amount_keys = [
			"defence_amount",
			"effect_stacks",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"),
				"%s gave correct amount of confidence" % [card.canonical_name])
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Dreamer increased by correct amount" % [effect])

class TestPhotonBlade:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Photon Blade"
		expected_amount_keys = [
			"damage_amount",
			"discount_amount",
			"discount_uses",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])
		assert_eq(get_tree().get_nodes_in_group("cost_discounts").size(), 1, "One cost discounter added")
		if get_tree().get_nodes_in_group("cost_discounts").size() < 1:
			return
		var cd: CostDiscount = get_tree().get_nodes_in_group("cost_discounts")[0]
		assert_eq(cd.uses, get_amount("discount_uses"))
		assert_eq(cd.discount_amount, -get_amount("discount_amount"))

class TestChargedShot:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Charged Shot"
		test_card_names = [
			"Charged Shot",
			"Confidence",
			"Confidence",
			"Confidence",
		]
		expected_amount_keys = [
			"damage_amount",
			"increase_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(cards[2])
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.5), YIELD)
		assert_eq(get_current_amount("damage_amount"), get_amount("damage_amount") + get_amount("increase_amount"),
				"%s damage amount increased" % [card.canonical_name])
		sceng = execute_with_yield(cards[1])
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.5), YIELD)
		assert_eq(get_current_amount("damage_amount"), get_amount("damage_amount") + get_amount("increase_amount") * 2,
				"%s damage amount increased" % [card.canonical_name])
		sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_current_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])


class TestBlindingFlash:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.armor.name
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		testing_card_name = "Blinding Flash"
		expected_amount_keys = [
			"effect_stacks",
		]

	func test_card_results():
		assert_has_amounts()
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Dreamer increased by correct amount" % [effect])

	func extra_hypnagonia_setup():
		globals.player.deck.add_new_card(testing_card_name)


class TestDarkRecovery:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		testing_card_name = "Dark Recovery"
		dreamer_starting_damage = 20
		expected_amount_keys = [
			"healing_amount",
		]

	func test_card_results():
		assert_has_amounts()
		assert_eq(dreamer.damage, dreamer_starting_damage - get_amount("healing_amount"),
				"%s healed correct amount of damage" % [card.canonical_name])

	func extra_hypnagonia_setup():
		globals.player.deck.add_new_card("Dark Recovery")

class TestDarkApproach:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		testing_card_name = "Dark Approach"
		expected_amount_keys = [
			"draw_amount",
		]

	func test_card_results():
		assert_has_amounts()
		assert_eq(hand.get_card_count(), get_amount("draw_amount") + 1,
				"%s drew correct amount of cards" % [card.canonical_name])

	func extra_hypnagonia_setup():
		globals.player.deck.add_new_card(testing_card_name)

class TestWidebeam:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Widebeam"
		globals.test_flags["test_initial_hand"] = true
		expected_amount_keys = [
			"damage_amount",
			"forget_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var initial_card_size = deck.get_card_count()
		var last_card = deck.get_bottom_card()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])
		assert_eq(deck.get_card_count(), initial_card_size - get_amount("forget_amount"))
		assert_eq(forgotten.get_card_count(), get_amount("forget_amount"))
		assert_eq(last_card.get_parent(), forgotten)

class TestWidebeamForget:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "~ Widebeam ~"
		globals.test_flags["test_initial_hand"] = true
		expected_amount_keys = [
			"damage_amount",
			"forget_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var initial_card_size = deck.get_card_count()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])
		assert_eq(deck.get_card_count(), initial_card_size - get_amount("forget_amount"))
		assert_eq(forgotten.get_card_count(), get_amount("forget_amount") + 1)

class TestPrecision:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.strengthen.name
	func _init() -> void:
		testing_card_name = "Precision"
		globals.test_flags["test_initial_hand"] = true
		expected_amount_keys = [
			"effect_stacks",
		]

	func test_card_results():
		assert_has_amounts()
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), get_amount("effect_stacks"),
				"%s stacks on Dreamer increased by correct amount" % [effect])

	func extra_hypnagonia_setup():
		globals.player.deck.add_new_card(testing_card_name)


class TestNanoMachines:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Nano-Machines"
		globals.test_flags["test_initial_hand"] = true
		expected_amount_keys = [
			"damage_amount",
			"draw_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var c1 : DreamCard = cfc.instance_card("Cannon")
		deck.add_child(c1)
		c1._determine_idle_state()
		var c2 : DreamCard = cfc.instance_card("Vulcan")
		deck.add_child(c2)
		c2._determine_idle_state()
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")),
				"%s dealt correct amount of interpretation" % [card.canonical_name])
		assert_eq(hand.get_card_count(), 2, "Only 2 of the drawn cards are Fusion")


class TestSpareLens:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.spare_lens.name
	var amount = 2
	func _init() -> void:
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]


	func test_spare_lens_gen():
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		yield(yield_for(1), YIELD)
		assert_eq(deck.get_card_count(), 2)
		if deck.get_card_count() == 0:
			return
		assert_has(deck.get_top_card().get_property('Tags'), Terms.GENERIC_TAGS.fusion.name)

class TestHeatVenting:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.heat_venting.name
	var amount = 2
	func _init() -> void:
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]

	func test_heat_venting():
		for iter in 4:
			var c : DreamCard = cfc.instance_card("Cannon")
			deck.add_child(c)
			c._determine_idle_state()
			hand.draw_card()
		yield(yield_for(1), YIELD)
		assert_eq(dreamer.defence, amount * get_amount_from_card(effect, "concentration_defence") * 2,
				"%s gave correct amount of confidence" % [effect])
		

class TestStreamlining:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.streamlining.name
	var amount = 2
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]

	func test_effect():
		for iter in 4:
			var c : DreamCard = cfc.instance_card("Cannon")
			deck.add_child(c)
			c._determine_idle_state()
			hand.draw_card()
		yield(yield_for(1), YIELD)
		assert_eq(hand.get_card_count(), amount * 2 + 2,
				"%s drew correct amount of cards" % [effect])
		



class TestBrooding:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Brooding"
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_refill"] = false
		expected_amount_keys = [
			"forget_amount",
			"draw_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var selwindows = get_tree().get_nodes_in_group("selection_windows")
		assert_eq(selwindows.size(), 1)
		if not selwindows.size() == 1:
			return
		var selection_window = selwindows[0]
		pending("Add check that cards are forgotten")
		pending("Add check that cards are drawn")
		pending("Add check that cards are drawn even when there's nothing to forget")

class TestRecycling:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Recycling"
		expected_amount_keys = [
			"defence_amount",
			"defence_amount2",
		]

	func test_card_results():
		assert_has_amounts()
		TurnEventMessage.new("card_fused", +4)
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount") + get_amount("defence_amount2") * 4,
				"%s gave correct amount of confidence" % [card.canonical_name])


class TestFusionGrenade:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		testing_card_name = "Fusion Grenade"
		expected_amount_keys = [
			"damage_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for t in test_torments:
			assert_eq(t.damage, tdamage(get_amount("damage_amount")),
					"%s dealt correct amount of interpretation" % [card.canonical_name])


class TestLightJump:
	extends "res://tests/HUT_Ordeal_CardTestClass.gd"
	func _init() -> void:
		testing_card_name = "Light Jump"
		expected_amount_keys = [
			"defence_amount",
			"discard_amount",
		]

	func test_card_results():
		assert_has_amounts()
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"),
				"%s gave correct amount of confidence" % [card.canonical_name])
		var selwindows = get_tree().get_nodes_in_group("selection_windows")
		assert_eq(selwindows.size(), 1)
		if not selwindows.size() == 1:
			return
		var selection_window = selwindows[0]
		pending("Add check that cards are moved to bottom of deck")

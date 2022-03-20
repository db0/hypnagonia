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
		yield(yield_for(0.3), YIELD)
		assert_eq(get_current_amount("damage_amount"), get_amount("damage_amount") + get_amount("increase_amount"),
				"%s damage amount increased" % [card.canonical_name])
		sceng = execute_with_yield(cards[1])
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.3), YIELD)
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
		globals.player.deck.add_new_card("Blinding Flash")


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

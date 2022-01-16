extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"

class TestDamageAll:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		testing_memory_name = MemoryDefinitions.DamageAll.canonical_name
		expected_amount_keys = [
			"damage_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memory._use()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for torment in test_torments:
			assert_eq(torment.damage, tdamage(get_amount("damage_amount")), "All Torments should take damage")


class TestHealSelfAll:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.HealSelf.canonical_name
		expected_amount_keys = [
			"heal_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		dreamer.damage = 50
		if not assert_has_amounts():
			return
		var sceng = memory._use()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 50 - get_amount("heal_amount"), "Dreamer should heal damage")

class TestSpikeEnemy:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.SpikeEnemy.canonical_name
		expected_amount_keys = [
			"damage_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount")), "Target Torments should take damage")

	func test_upgraded_memory_use():
		memories[0].set_upgrades_amount(3)
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(get_amount("damage_amount") + memories[0].upgrades_amount), "Target Torments should take damage")

class TestFortifySelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.FortifySelf.canonical_name
		expected_amount_keys = [
			"effect_stacks",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.fortify.name), get_amount("effect_stacks"),
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.fortify.name, dreamer])

class TestDefendSelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.DefendSelf.canonical_name
		expected_amount_keys = [
			"defence_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, get_amount("defence_amount"),
				"Expected %s defence added")

class TestQuickenSelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.QuickenSelf.canonical_name
		expected_amount_keys = [
			"effect_stacks",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), get_amount("effect_stacks"),
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.quicken.name, dreamer])

class TestStrengthenSelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.StrengthenSelf.canonical_name
		expected_amount_keys = [
			"effect_stacks",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), get_amount("effect_stacks"),
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.strengthen.name, dreamer])

class TestRandomChaos:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.RandomChaos.canonical_name
		expected_amount_keys = [
			"draw_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		var deck_cards_names := [
			"Interpretation",
			"Interpretation",
			"Confidence",
			"Confidence",
			"Confidence",
		]
		if not assert_has_amounts():
			return
		var deck_cards = setup_deckpile_cards(deck_cards_names)
		watch_signals(cfc.signal_propagator)
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(deck.get_card_count(), deck_cards_names.size() - get_amount("draw_amount"), "Correct amount of cards played")
		assert_eq(turn.turn_event_count.get("cards_played", 0), get_amount("draw_amount"), "Correct amount of cards played")

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
		var _deck_cards = setup_deckpile_cards(deck_cards_names)
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(deck.get_card_count(), deck_cards_names.size() - get_amount("draw_amount"), "Correct amount of cards played")
		assert_eq(turn.turn_event_count.get("cards_played", 0), get_amount("draw_amount"), "Correct amount of cards played")

class TestReshuffleHand:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.ReshuffleHand.canonical_name
		expected_amount_keys = [
			"upgrade_multiplier",
		]
		test_card_names = [
			"Interpretation",
			"Confidence",
			"Confidence",
		]

	func test_memory_use():
		var deck_cards_names := [
			"Lacuna",
			"Lacuna",
			"Lacuna",
			"Lacuna",
			"Lacuna",
		]
		if not assert_has_amounts():
			return
		var _deck_cards = setup_deckpile_cards(deck_cards_names)
		var hand_pre_cards = hand.get_all_cards()
		var deck_pre_cards = deck.get_all_cards()
		watch_signals(deck)
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_ne(hand.get_all_cards(), hand_pre_cards, "Hand contents changed")
		assert_ne(deck.get_all_cards(), deck_pre_cards, "Deck contents changed")
		assert_eq(hand.get_card_count(), hand_pre_cards.size(), "Correct amount of cards in hand")
		assert_signal_emitted(deck, "shuffle_completed")


class TestPoisonEnemy:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.PoisonEnemy.canonical_name
		expected_amount_keys = [
			"effect_stacks",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory, test_torment)
#		yield(yield_for(0.2), YIELD)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name), get_amount("effect_stacks"),
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.poison.name, dreamer])


class TestDisempowerEnemy:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.DisempowerEnemy.canonical_name
		expected_amount_keys = [
			"effect_stacks",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory, test_torment)
#		yield(yield_for(0.2), YIELD)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower.name), get_amount("effect_stacks"),
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.disempower.name, dreamer])


class TestImperviousSelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.ImperviousSelf.canonical_name
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
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name), get_amount("effect_stacks"),
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.impervious.name, dreamer])


class TestCardDraw:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.CardDraw.canonical_name
		expected_amount_keys = [
			"draw_amount",
			"upgrade_multiplier",
		]
		test_card_names = [
			"Interpretation",
			"Confidence",
		]

	func test_memory_use():
		var deck_cards_names := [
			"Lacuna",
			"Lacuna",
			"Lacuna",
			"Lacuna",
			"Lacuna",
		]
		if not assert_has_amounts():
			return
		var _deck_cards = setup_deckpile_cards(deck_cards_names)
		var hand_pre_size = hand.get_card_count()
		var deck_pre_size = deck.get_card_count()
		watch_signals(deck)
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(hand.get_card_count(), hand_pre_size + get_amount("draw_amount"), "Hand draw expected amount")
		assert_eq(deck.get_card_count(), deck_pre_size - get_amount("draw_amount"), "Deck reduced by expected amount")


class TestExertRecovery:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.ExertRecovery.canonical_name
		expected_amount_keys = [
			"upgrade_multiplier",
		]
		test_card_names = [
			"Interpretation",
			"Interpretation",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		card.scripts = EXERT_SCRIPT
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 5)
		dreamer.damage += 10
		sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 10)

class TestExertSelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.ExertSelf.canonical_name
		expected_amount_keys = [
			"exert_amount",
			"repeat_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.poison.name, 4)
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.disempower.name, 4)
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.drain.name, 4)
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var total_exert = get_amount("exert_amount") * get_amount("repeat_amount")
		assert_eq(dreamer.damage, total_exert)
		var total_stacks := 0
		for effect in dreamer.active_effects.get_all_effects_nodes():
			assert_has(Terms.get_all_effect_types("Debuff"), effect.canonical_name)
			total_stacks += effect.stacks
		assert_eq(total_stacks, 12 - (total_exert/2), "%s removed the expected amount of debuffs" % [memory.name])

	func test_upgraded_memory_use():
		if not assert_has_amounts():
			return
		memories[0].set_upgrades_amount(3)
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.poison.name, 4)
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.disempower.name, 4)
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.drain.name, 4)
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var total_exert = get_amount("exert_amount") * (get_amount("repeat_amount") + 3)
		assert_eq(dreamer.damage, total_exert)
		var total_stacks := 0
		for effect in dreamer.active_effects.get_all_effects_nodes():
			assert_has(Terms.get_all_effect_types("Debuff"), effect.canonical_name)
			total_stacks += effect.stacks
		assert_eq(total_stacks, 12 - (total_exert/2), "%s removed the expected amount of debuffs" % [memory.name])


class TestRegenerateSelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.RegenerateSelf.canonical_name
		expected_amount_keys = [
			"heal_amount",
			"turns_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.zen_of_flight.name), get_amount("turns_amount"))


class TestBufferSelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.BufferSelf.canonical_name
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
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.buffer.name), get_amount("effect_stacks"),
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.buffer.name, dreamer])


class TestProtectSelf:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.ProtectSelf.canonical_name
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
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.protection.name), get_amount("effect_stacks"),
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.protection.name, dreamer])


class TestActivateStartups:
	extends "res://tests/HUT_Ordeal_MemoriesTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_initial_hand"] = true
		testing_memory_name = MemoryDefinitions.ActivateStartups.canonical_name
		expected_amount_keys = [
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		spawn_test_card("Dark Approach", forgotten)
		spawn_test_card("Precision", forgotten)
		var sceng = memexecute(memory)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(1), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 2,
				"Expected %s stacks added to %s" % [Terms.ACTIVE_EFFECTS.strengthen.name, dreamer])
		assert_eq(hand.get_card_count(), 2,
				"%s drew correct amount of cards" % [memory.canonical_name])

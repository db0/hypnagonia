extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"

class TestStress:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Stress:10"],
				"reshuffle": true,
			},
		]

	func test_stress():
		assert_eq(dreamer.damage, 10, "Dreamer should take damage")
		assert_eq(test_torment.damage, 30, "Torment should not take damage")


class TestPerplex:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Perplex:10"],
				"reshuffle": true,
			},
		]

	func test_perplex():
		assert_eq(test_torment.defence, 10, "Torment should gain defence")
		assert_eq(dreamer.defence, 0, "Dreamer should not gain defence")


class TestPerplexGroup:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		intents_to_test = [
			{
				"intent_scripts": ["PerplexGroup:10"],
				"reshuffle": true,
			},
		]

	func test_perplexgroup():
		for torment in test_torments:
			assert_eq(torment.defence, 10, "All Torments should gain defence")
		assert_eq(dreamer.defence, 0, "Dreamer should not gain defence")


class TestDebuff:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Debuff:1:disempower","Debuff:10:vulnerable"],
				"reshuffle": true,
			},
		]

	func test_debuff():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower.name), 1,
				"Dreamer should gain debuff stacks")
		assert_eq(test_torment.intents.get_child_count(), 2,
				"Torment should have 2 intents displayed")
		for intent in test_torment.intents.get_children():
			assert_false(intent.signifier_amount.visible, "Debuff amount should not be visible")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.vulnerable.name), 10,
				"Dreamer should gain many debuff stacks")

class TestBuff:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Buff:1:strengthen","Buff:10:advantage"],
				"reshuffle": true,
			},
		]

	func test_buff():
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 1,
				"Torments should gain buff stacks")
		assert_eq(test_torment.intents.get_child_count(), 2,
				"Torment should have 2 intents displayed")
		for intent in test_torment.intents.get_children():
			assert_false(intent.signifier_amount.visible, "Buff amount should not be visible")
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.advantage.name), 10,
				"Torments should gain many buff stacks")


class TestBuffGroup:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		intents_to_test = [
			{
				"intent_scripts": ["BuffGroup:1:strengthen","BuffGroup:10:advantage"],
				"reshuffle": true,
			},
		]

	func test_buffgroup():
		for torment in test_torments:
			assert_eq(torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 1,
				"All Torments should gain buff stacks")
			assert_eq(torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.advantage.name), 10,
				"Torments should gain many buff stacks")
		assert_eq(test_torment.intents.get_child_count(), 2,
				"Torment should have 2 intents displayed")
		for intent in test_torment.intents.get_children():
			assert_false(intent.signifier_amount.visible, "Buff amount should not be visible")


class TestStare:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Stare"],
				"reshuffle": true,
			},
		]

	func test_stare():
		assert_eq(count_card_names("Dread"), 1,
			"1 Dread spawned per Stare Intent")
		for card in get_filtered_cards("Name", "Dread"):
			assert_null(card.deck_card_entry, "Dread added should be temporary")


class TestDelight:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Delight"],
				"reshuffle": true,
			},
		]

	func test_delight():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.delighted.name), 1,
				"Dreamer should be delighted")
		assert_eq(test_torment.intents.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for intent in test_torment.intents.get_children():
			assert_false(intent.signifier_amount.visible, "Delight amount should not be visible")


class TestLethargy:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Lethargy:2"],
				"reshuffle": true,
			},
		]

	func test_lethargy():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.drain.name), 0,
				"Dreamer should have already used drain stacks")
		assert_eq(counters.counters.immersion, 1,
				"Dreamer's energy reduced")
		assert_eq(test_torment.intents.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for intent in test_torment.intents.get_children():
			assert_true(intent.signifier_amount.visible, "Delight amount should be visible")


class TestEvident:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Evident:33"],
				"reshuffle": true,
			},
		]

	func test_evident():
		assert_eq(test_torment.damage, 63, "Torment should take self damage")


class TestFrustrate:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Frustrate:20"],
				"reshuffle": true,
			},
		]

	func test_frustrate():
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.enemy], 20,
				"Frustration should increase")


class TestDisheartenNegative:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		set_released_pathos[Terms.RUN_ACCUMULATION_NAMES.enemy] = 37
		intents_to_test = [
			{
				"intent_scripts": ["Dishearten:-20"],
				"reshuffle": true,
			},
		]

	func test_dishearten():
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		assert_eq(globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.enemy], 17,
				"Frustration should decrease")
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.enemy], 0,
				"Frustration should decrease to 0")


class TestDisheartenPositive:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		set_released_pathos[Terms.RUN_ACCUMULATION_NAMES.enemy] = 37
		intents_to_test = [
			{
				"intent_scripts": ["Dishearten:20"],
				"reshuffle": true,
			},
		]

	func test_dishearten():
		assert_eq(globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.enemy], 57,
				"Frustration should decrease")
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(globals.player.pathos.released[Terms.RUN_ACCUMULATION_NAMES.enemy], 77,
				"Frustration should decrease to 0")


class TestUnfocus:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		var test_effect := {
				"name": Terms.ACTIVE_EFFECTS.rebalance.name,
				"amount": 2,
			}
		test_torment_starting_effects.append(test_effect)
		intents_to_test = [
			{
				"intent_scripts": ["Unfocus"],
				"reshuffle": true,
			},
		]

	func test_unfocus():
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), -2,
				"Torment should be unfocused")
		assert_eq(test_torment.intents.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for intent in test_torment.intents.get_children():
			assert_false(intent.signifier_amount.visible, "intent amount should not be visible")


class TestPencilsReady:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		var test_effect := {
				"name": Terms.ACTIVE_EFFECTS.rebalance.name,
				"amount": 2,
			}
		test_torment_starting_effects.append(test_effect)
		intents_to_test = [
			{
				"intent_scripts": ["Pencils Ready"],
				"reshuffle": true,
			},
		]

	func test_pencils_ready():
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.the_exam.name), 2,
				"Dreamer should have 2 the_exam")
		assert_eq(test_torment.intents.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for intent in test_torment.intents.get_children():
			assert_false(intent.signifier_amount.visible, "intent amount not be visible")


class TestMemoryFailing:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		globals.test_flags["no_refill"] = false
		globals.test_flags["no_end_turn_delay"] = false
		test_card_names = BASIC_HAND
		intents_to_test = [
			{
				"intent_scripts": ["Memory Failing"],
				"reshuffle": true,
			},
		]

	func test_memory_failing():
		assert_eq(hand.get_card_count(), 4,
				"Hand should have 4 cards")
		assert_eq(forgotten.get_card_count(), 1,
				"Forgotten should have 1 card")


class TestIncreaseComplexity:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Increase Complexity:10"],
				"reshuffle": true,
			},
		]

	func test_increase_complexity():
		assert_eq(dreamer.damage, 10, "Dreamer should take damage")
		assert_eq(test_torment.damage, 20, "Torment should heal damage")
		dreamer.defence = 5
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 15, "Dreamer should take less damage")
		assert_eq(test_torment.damage, 15, "Torment should heal less damage")

class TestSummonMinion1:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Summon Minion 1"],
				"reshuffle": true,
			},
		]

	func test_summon_minion():
		assert_eq(get_tree().get_nodes_in_group("EnemyEntities").size(), 2, "New Minion Spawned")

class TestArmorTheBoss:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		torments_amount = 3
		intents_to_test = [
			{
				"intent_scripts": ["Armor The Boss"],
				"reshuffle": true,
			},
		]

	func test_armor_the_boss():
		for torment in test_torments:
			assert_eq(torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name), 0,
				"No Torments should have armor stacks")
			torment.intents.replace_intents(intents_to_test)
			torment.intents.refresh_intents()
		var boss_torment = board.spawn_enemy(EnemyDefinitions.ADMINISTRATION)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		# Boss loses 1 armor stack at the start of its turn
		assert_eq(boss_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.armor.name), 2,
			"Boss torment got expected amount of armor")


class TestSpawnCard:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["SpawnCard:Lacuna:hand"],
				"reshuffle": true,
			},
		]

	func test_spawn_card():
		assert_eq(hand.get_card_count(), 1, "1 Lacuna spawned in hand")
		assert_eq(count_card_names("Lacuna"), 1,
				"1 Lacuna spawned")

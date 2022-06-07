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

class TestPiercingStress:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Piercing Stress:10"],
				"reshuffle": true,
			},
		]

	func test_stress():
		assert_eq(dreamer.damage, 10, "Dreamer should take damage")
		assert_eq(test_torment.damage, 30, "Torment should not take damage")

	func extra_board_setup():
		dreamer.defence = 0


class TestPerplex:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		# We need to avoid the turn start defence wipe going after defence gain intent
		globals.test_flags["no_end_turn_delay"] = false
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
		assert_eq(globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy].repressed, 20,
				"Frustration should increase")


class TestDishearten:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Dishearten:20"],
				"reshuffle": true,
			},
		]

	func test_dishearten():
		# Apparently a delay is needed here
		yield(yield_for(0.2), YIELD)
		assert_eq(globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy].temp_modification_for_next_level, 30.0,
				"Frustration requirements should increase")
		assert_eq(globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy].get_level_requirement(), 75.0,
				"Mastery Requirements increased")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy].temp_modification_for_next_level, 60.0,
				"Frustration requirements should increase")
		assert_eq(globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy].get_level_requirement(), 105.0,
				"Mastery Requirements increased")


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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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


class TestAwkwardCompliments:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	func _init() -> void:
		intents_to_test = [
			{
				"intent_scripts": ["Awkward Compliments"],
				"reshuffle": true,
			},
		]

	func test_stress():
		assert_eq(dreamer.damage, 3, "Dreamer should take damage")
		assert_eq(test_torment.damage, tdamage(0), "Torment should not take damage")
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		TurnEventMessage.new("new_turn", 3)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		assert_eq(dreamer.damage, 3 * 6, "Dreamer should take damage")

class TestCheckBrowserHistory:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	var dmg = 7
	func _init() -> void:
		torments_amount = 3
		intents_to_test = [
			{
				"intent_scripts": ["Stress:" + str(dmg), "Check browser history"],
				"reshuffle": true,
			},
		]

	func test_intent():
		assert_eq(dreamer.damage, dmg, "Dreamer should take damage")
		var t_health := {}
		for t in test_torments:
			t_health[t] = t.health
			t.intents.replace_intents(intents_to_test)
			t.intents.refresh_intents()
		dreamer.defence = dmg * 2 + 15
		if not dreamer.incoming_dmg_signifier:
			yield(yield_to(dreamer,"incoming_signifier_set", 0.2), YIELD)
		assert_not_null(dreamer.incoming_dmg_signifier)
		if not dreamer.incoming_dmg_signifier:
			return
		yield(yield_for(0.2), YIELD)
		assert_eq(dreamer.incoming_dmg_signifier.signifier_amount.text, str(2))
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		assert_eq(dreamer.damage, dmg + 2, "Dreamer should take a bit of damage")
		assert_eq(test_torments[0].health, t_health[test_torments[0]] + 10, "First Torment should increase its health")
		assert_eq(test_torments[1].health, t_health[test_torments[1]], "Second Torment should not increase its health")
		assert_eq(test_torments[2].health, t_health[test_torments[2]], "Third Torment should not increase its health")

class TestCheckUnderwearDrawer:
	extends "res://tests/HUT_Ordeal_IntentScriptsTestClass.gd"
	var dmg = 7
	func _init() -> void:
		torments_amount = 4
		intents_to_test = [
			{
				"intent_scripts": ["Check underwear drawer"],
				"reshuffle": true,
			},
		]

	func test_intent():
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.fortify.name), 2)
		for t in test_torments:
			t.intents.replace_intents(intents_to_test)
			t.intents.refresh_intents()
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.fortify.name, 2,  '')
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.quicken.name, 4,  '')
		yield(yield_for(0.2), YIELD)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.fortify.name), 0)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), 2)
		assert_eq(test_torments[0].active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), 0)
		assert_eq(test_torments[1].active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), 1)
		assert_eq(test_torments[2].active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), 4)
		assert_eq(test_torments[3].active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), 3)
		assert_eq(cfc.get_tree().get_nodes_in_group("EnemyEntities").size(), 5)

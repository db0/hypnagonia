extends "res://tests/HUTCommon_Ordeal.gd"

class TestCoatOfCringe:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.coat_of_cringe.name
	func _init() -> void:
		test_card_names = [
			"Interpretation",
			"Interpretation",
			"Confidence",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 1,
			}
		]

	func test_effect():
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = snipexecute(cards[1], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = execute_with_yield(cards[2])
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(count_card_names("Cringeworthy Memory"), 2,
				"1 Cringeworthy Memory spawned per attack")

class TestVoid:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS["void"].name
	func _init() -> void:
		test_card_names = [
			"Void",
			"Confidence",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 2,
			}
		]

	func test_void():
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = cards[1].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(1.5), YIELD)
		assert_eq(count_card_names("Lacuna"), 2,
				"2 Lacuna as spawned per played Understanding")

class TestSelfCleaning:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.self_cleaning.name
	var amount = 2
	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			},
			{
				"name": Terms.ACTIVE_EFFECTS.outrage.name,
				"amount": 10,
			},
			{
				"name": Terms.ACTIVE_EFFECTS.poison.name,
				"amount": 6,
			},
			{
				"name": Terms.ACTIVE_EFFECTS.strengthen.name,
				"amount": -4,
			},
		]


	func test_self_cleaning():
		turn.end_player_turn()
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name), 5 - amount,
				"%s reduced %s" % [effect, Terms.ACTIVE_EFFECTS.poison.name])
		assert_eq(abs(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name)), 4,
				"%s did not reduce %s" % [effect, Terms.ACTIVE_EFFECTS.disempower.name])
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(abs(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name)), 4 - amount,
				"%s reduced %s" % [effect, Terms.ACTIVE_EFFECTS.strengthen.name])
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name), 4 - amount,
				"%s did not reduce %s" % [effect, Terms.ACTIVE_EFFECTS.poison.name])


class TestJumbletron:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.jumbletron.name
	var amount = 1
	func _init() -> void:
		test_card_names = [
			"Subconscious",
			"Butterfly",
			"Interpretation",
			"Confidence",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			},
		]


	func test_jumbletron():
		var card_entries := []
		for index in range(cards.size()):
			watch_signals(cards[index].deck_card_entry)
			card_entries.append(cards[index].deck_card_entry)
		var sceng = snipexecute(cards[0], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = cards[1].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = snipexecute(cards[2], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = cards[3].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		# We need to wait a bit, or we might deinstance critical nodes while
		# they're executing
		yield(yield_for(1), YIELD)
		for index in range(card_entries.size()):
			var ce: CardEntry = card_entries[index]
			if index <= 1:
				assert_signal_emitted(ce, "card_entry_modified")
			else:
				assert_signal_not_emitted(ce, "card_entry_modified")

class TestEnraged:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.enraged.name
	func _init() -> void:
		test_card_names = [
			"Interpretation",
			"Confidence",
			"Nothing to Fear",
			"Fearmonger",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 2,
			}
		]

	func test_enraged():
		var sceng = cards[1].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = cards[2].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = cards[3].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = snipexecute(cards[0], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.3), YIELD)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 2,
				"%s added %s from Control cards only" % [effect, Terms.ACTIVE_EFFECTS.strengthen.name])


class TestLifePathAction:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.life_path.name
	func _init() -> void:
		test_card_names = [
			"Interpretation",
			"Interpretation",
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 1,
				"upgrade": "Active"
			}
		]

	func test_life_path():
		yield(yield_for(0.3), YIELD)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_to(combat_effects[0], 'scripting_finished', 1), YIELD)
		sceng = snipexecute(cards[1], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_to(combat_effects[0], 'scripting_finished', 1), YIELD)
		assert_eq(dreamer.damage, 2,
				"1 damage taken as per stack")
		yield(yield_for(0.1), YIELD)


class TestLifePathControl:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.life_path.name
	func _init() -> void:
		torments_amount = 3
		test_card_names = [
			"Confidence",
			"Confidence",
			"Confidence",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 1,
				"upgrade": "Controlling"
			}
		]

	func test_life_path():
		spawn_effect(test_torments[0],effect, 1, "Active")
		spawn_effect(test_torments[1],effect, 1, "Focused")
		card.execute_scripts()
		yield(yield_to(combat_effects[0], 'scripting_finished', 1), YIELD)
		cards[1].execute_scripts()
		yield(yield_to(combat_effects[0], 'scripting_finished', 1), YIELD)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.protection.name), 2,
				"amount of %s equal to stacks received" % [Terms.ACTIVE_EFFECTS.protection.name])
		assert_eq(test_torments[0].active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.protection.name), 0,
				"0 on test torment with different upgrade")
		assert_eq(test_torments[1].active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.protection.name), 0,
				"0 on test torment with different upgrade")
		for t in test_torments:
			assert_eq(t.damage, tdamage(-2), "All torments healed")
		yield(yield_for(0.3), YIELD)

class TestLifePathConcentration:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.life_path.name
	func _init() -> void:
		test_card_names = [
			"Nothing to Fear",
			"Nothing to Fear",
			"Nothing to Fear",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 1,
				"upgrade": "Focused"
			}
		]

	func test_life_path():
		card.execute_scripts()
		yield(yield_to(combat_effects[0], 'scripting_finished', 1), YIELD)
		cards[1].execute_scripts()
		yield(yield_to(combat_effects[0], 'scripting_finished', 1), YIELD)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 2,
				"2 %s received" % [Terms.ACTIVE_EFFECTS.strengthen.name])

class TestDoom:
	extends "res://tests/HUT_Journal_CombatEncounterTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.doom.name
	func _init() -> void:
		add_starting_effect(effect, 2)

	func test_effect():
		var begin = begin_enemy_encounter()
		if begin is GDScriptFunctionState:
			begin = yield(begin, "completed")
		if not test_torment:
			return
		watch_signals(test_torment)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_signal_not_emitted(test_torment, "entity_killed")
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_signal_emitted(test_torment, "entity_killed")
		yield(yield_to(ce, 'encounter_end', 5), YIELD)
		journal.card_draft.display("card_draft")
		var draft  = get_tree().get_nodes_in_group("card_draft")
		assert_eq(draft.size(), 1, "Card Draft Started")
		if draft.size() == 1:
			return
		assert_eq(draft[0].get_draft_card_count(), 3, "Killed enemies through doom don't show draft rewards")

class TestDisruptionNoDiscard:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.disruption.name
	func _init() -> void:
		globals.test_flags.test_initial_hand = true
		test_card_names = [
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 3,
				"upgrade": "Focused"
			}
		]

	func test_effect():
		turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started", 3), YIELD)
		assert_eq(hand.get_card_count(), 2,
				"%s reduced refill by 3" % [effect])
		turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started", 3), YIELD)
		assert_eq(hand.get_card_count(), 4,
				"%s at 3+ stacks prevent card discard" % [effect])

class TestDisruptionDiscard:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.disruption.name
	func _init() -> void:
		globals.test_flags.test_initial_hand = true
		test_card_names = [
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 2,
				"upgrade": "Focused"
			}
		]

	func test_effect():
		turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started", 3), YIELD)
		assert_eq(hand.get_card_count(), 3,
				"%s reduced refill by 2" % [effect])
		turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started", 3), YIELD)
		assert_eq(hand.get_card_count(), 3,
				"%s at 2- stacks does not prevent card discard" % [effect])



class TestActLength:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.act_length.name
	var amount := 1
	var modified_dmg = DMG
	func _init() -> void:
		torments_amount = 3
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]

	func test_act_length_on_multiple_torments():
		card.scripts = MULTI_ATTACK_SCRIPT
		spawn_effect(test_torments[0], effect, 2, '')
#		drag_card(card,card.global_position)
		card._start_dragging(Vector2(0,0))
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		for index in range(test_torments.size()):
			var predictions = test_torments[index].incoming.get_children()
			for iindex in range(predictions.size()):
				if index == 0:
					assert_eq(predictions[iindex].signifier_amount.text, '1', "Card DMG hitting %s should be 1" % [effect])
				else:
					assert_eq(predictions[iindex].signifier_amount.text, str(modified_dmg), "Card DMG should be %s" % [modified_dmg])
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for index in range(test_torments.size()):
			if index == 0:
				assert_eq(test_torments[index].damage, starting_torment_dgm + 1, "Torment should take 1 damage")
			else:
				assert_eq(test_torments[index].damage, starting_torment_dgm + modified_dmg, "Torment should take damage")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), 2,
				"%s stacks not modified by card attack" % [effect])

	func test_act_length_and_dots():
		spawn_effect(test_torment, effect, 2, '')
		spawn_effect(test_torment, Terms.ACTIVE_EFFECTS.poison.name, 5, '')
		spawn_effect(test_torment, Terms.ACTIVE_EFFECTS.burn.name, 5, '')
		turn.end_player_turn()
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.damage, tdamage(2),
				"%s stops DoTs" % [effect])

	func test_act_length_and_rubber_eggs():
		spawn_effect(test_torment, effect, 2, '')
		spawn_effect(test_torment, Terms.ACTIVE_EFFECTS.disempower.name, 1, '')
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.rubber_eggs.name, 1, '')
		turn.end_player_turn()
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.damage, tdamage(1),
				"%s stops Rubber Eggs" % [effect])

	func test_act_length_kill():
		spawn_effect(test_torment, effect, 1, '')
		watch_signals(test_torment)
		turn.end_player_turn()
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_signal_emitted(test_torment, "entity_killed")


class TestClawingForAir:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.clawing_for_air.name
	func _init() -> void:
		globals.test_flags.test_initial_hand = true
		test_card_names = [
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 3,
			}
		]

	func test_effect():
		turn.end_player_turn()
		yield(yield_to(turn, "player_turn_started", 3), YIELD)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 3,
				"%s added correct amount of %s" % [effect, Terms.ACTIVE_EFFECTS.strengthen.name])
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), 3,
				"%s stacks not reduced" % [effect])
		turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started", 3), YIELD)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 6,
				"%s added correct amount of %s" % [effect, Terms.ACTIVE_EFFECTS.strengthen.name])
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), 3,
				"%s stacks not reduced" % [effect])

class TestCheekPinching:
	extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS.cheek_pinching.name
	func _init() -> void:
		globals.test_flags.test_initial_hand = true
		test_card_names = [
		]

	func test_effect():
		spawn_effect(test_torment,effect, 1)
		counters.call_deferred("mod_counter", "immersion", 2)
		yield(yield_to(counters, "mod_counter", 0.2), YIELD)
		assert_eq(test_torment.defence, 10)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 1,
				"%s added %s" % [effect, Terms.ACTIVE_EFFECTS.poison.name])
		turn.end_player_turn()
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.defence, 0)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 1,
				"%s added %s" % [effect, Terms.ACTIVE_EFFECTS.poison.name])

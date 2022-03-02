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
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
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
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.3), YIELD)
		sceng = snipexecute(cards[1], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.3), YIELD)
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
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.3), YIELD)
		sceng = execute_with_yield(cards[1])
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.3), YIELD)
		assert_eq(test_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.protection.name), 2,
				"2 %s received" % [Terms.ACTIVE_EFFECTS.protection.name])
		assert_eq(test_torments[0].active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.protection.name), 0,
				"0 on test torment with different upgrade")
		assert_eq(test_torments[1].active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.protection.name), 0,
				"0 on test torment with different upgrade")
		for t in test_torments:
			assert_eq(t.damage, tdamage(-2), "All torments healed")

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
		var sceng = execute_with_yield(card)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = execute_with_yield(cards[1])
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		yield(yield_for(0.3), YIELD)
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

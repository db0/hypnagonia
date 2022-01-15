extends "res://tests/HUTCommon_Ordeal.gd"

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


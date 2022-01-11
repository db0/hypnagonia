extends "res://tests/HUT_TormentTestClass.gd"

class TestVoid:
	extends "res://tests/HUT_TormentEffectsTestClass.gd"
	var effect = Terms.ACTIVE_EFFECTS["void"].name
	func _init() -> void:
		test_card_names = [
			"Void",
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
		yield(yield_for(0.5), YIELD)
		assert_eq(count_card_names("Lacuna"), 2,
				"2 Lacuna as spawned per played Understanding")

class TestSelfCleaning:
	extends "res://tests/HUT_TormentEffectsTestClass.gd"
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

# Need to move this to a new file
#class TestSurrealBoss:
#	extends "res://tests/HUT_TormentEffectsTestClass.gd"
#
#	var effect = Terms.ACTIVE_EFFECTS.surreal_boss.name
#	func _init() -> void:
#		test_card_names = [
#			"Interpretation",
#			"Confidence",
#		]
#		effects_to_play = [
#			{
#				"name": effect,
#				"amount": 1,
#			}
#		]
#
#
#	func test_surreal_boss():
#		cards[0].scripts = BIG_ATTACK_SCRIPT
#		cards[1].scripts = BIG_DEFENCE_SCRIPT
#		cards[1].execute_scripts()
#		var sceng = snipexecute(cards[0], test_torment)
#		if sceng is GDScriptFunctionState:
#			sceng = yield(sceng, "completed")
#		assert_eq(test_torment.active_effects.get_effect_stacks(effect), 1,
#				"%s gave %s due to massive damage" % [effect, Terms.ACTIVE_EFFECTS.strengthen.name])
#		cfc.NMAP.board.turn.end_player_turn()
#		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)

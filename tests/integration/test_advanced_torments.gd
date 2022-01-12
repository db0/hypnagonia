extends "res://tests/HUT_AdvancedTormentTestClass.gd"


class TestSurrealBoss:
	extends "res://tests/HUT_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Bosses/SurrealBoss.tscn")
		test_card_names = [
			"Interpretation",
			"Confidence",
		]

	func test_surreal_boss():
		advanced_torment.intents.prepare_intents(0)
		cards[0].scripts = BIG_ATTACK_SCRIPT
		cards[1].scripts = BIG_DEFENCE_SCRIPT
		cards[1].execute_scripts()
		var sceng = snipexecute(cards[0], advanced_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 1,
				"%s gained %s due to massive damage" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.strengthen.name])
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 2,
				"%s gained %s due to not doing any stres" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.strengthen.name])

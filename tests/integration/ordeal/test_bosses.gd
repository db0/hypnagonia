extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


class TestSurrealBoss:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Bosses/SurrealBoss.tscn")
		test_card_names = [
			"Interpretation",
			"Confidence",
		]

	func test_surreal_boss_gain_focus():
		# warning-ignore:return_value_discarded
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

	func test_surreal_boss_not_gain_focus():
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(0)
		cards[1].execute_scripts()
		var sceng = snipexecute(cards[0], advanced_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 0,
				"%s not gained %s due to damage being in normal range" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.strengthen.name])
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 0,
				"%s not gained %s due stress being taken" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.strengthen.name])

class TestNarcissus:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Bosses/Narcissus.tscn")
		test_card_names = [
			"Interpretation",
			"Confidence",
		]

	func test_surreal_has_poison_at_low_anxiety():
		# warning-ignore:return_value_discarded
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_gt(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name), 0,
				"%s inflicted %s due player having low anxiety" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.poison.name])

	func test_surreal_has_drain_at_high_anxiety():
		dreamer.damage = dreamer.health - 5
		advanced_torment.intents.prepare_intents(0)
		# warning-ignore:return_value_discarded
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_gt(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.drain.name), 0,
				"%s inflicted %s due player having hight anxiety" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.drain.name])

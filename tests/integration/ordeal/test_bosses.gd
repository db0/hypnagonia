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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_gt(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name), 0,
				"%s inflicted %s due player having low anxiety" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.poison.name])

	func test_surreal_has_drain_at_high_anxiety():
		dreamer.damage = dreamer.health - 5
		advanced_torment.intents.prepare_intents(0)
		# warning-ignore:return_value_discarded
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_gt(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.drain.name), 0,
				"%s inflicted %s due player having hight anxiety" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.drain.name])

class TestFearAndPhobia:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scenes = [
			preload("res://src/dreamscape/CombatElements/Enemies/Bosses/FearBoss.tscn"),
			preload("res://src/dreamscape/CombatElements/Enemies/Bosses/PhobiaBoss.tscn"),
		]
		test_card_names = [
			"Interpretation",
			"Confidence",
		]

	func test_initial_intents():
		# warning-ignore:return_value_discarded
		watch_signals(dreamer)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_signal_emit_count(dreamer, "entity_attacked", 4)
		assert_eq(get_filtered_cards('Name', "Scattered Dreams").size(), 1)
		for t in advanced_torments:
			assert_eq(t.defence, 16)
		assert_eq(dreamer.defence, 0)
		assert_eq(dreamer.damage, 20)

	func test_second_intents():
		advanced_torments[0].intents.prepare_intents(1)
		advanced_torments[1].intents.prepare_intents(0)
		# warning-ignore:return_value_discarded
		watch_signals(dreamer)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_signal_emit_count(dreamer, "entity_attacked", 1)
		assert_eq(get_filtered_cards('Name', "Scattered Dreams").size(), 0)
		for t in advanced_torments:
			assert_eq(t.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 2)
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.strengthen.name), 0)
		assert_eq(dreamer.damage, 22)

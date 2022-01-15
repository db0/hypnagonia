extends "res://tests/HUT_AdvancedTormentTestClass.gd"


class TestSurrealBoss:
	extends "res://tests/HUT_AdvancedTormentTestClass.gd"


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
	extends "res://tests/HUT_AdvancedTormentTestClass.gd"


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

class TestBully:
	extends "res://tests/HUT_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Elites/Bully.tscn")
		test_card_names = [
			"Confidence",
		]

	func test_spawn_buddies_on_damage():
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq( get_tree().get_nodes_in_group("EnemyEntities").size(), 3, "All Buddies Summoned")

	func test_spawn_less_buddies_on_partial_block():
		dreamer.defence = 10
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq( get_tree().get_nodes_in_group("EnemyEntities").size(), 2, "Partial Buddies Summoned")

	func test_spawn_no_buddies_on_full_block():
		dreamer.defence = 20
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq( get_tree().get_nodes_in_group("EnemyEntities").size(), 1, "No Buddies Summoned")

class TestIndescribableAbsurdity:
	extends "res://tests/HUT_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Elites/IndescribableAbsurdity.tscn")
		test_card_names = [
			"Confidence",
		]

	func test_spam_debuffs():
		# This ensures that it will always spawn the same amount of debuffs, regardless of seed
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(0)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		var total_stacks := 0
		for effect in dreamer.active_effects.get_all_effects_nodes():
			assert_has(Terms.get_all_effect_types("Debuff"), effect.canonical_name)
			total_stacks += effect.stacks
		assert_eq(total_stacks, 4, "%s spammed expected amount of debuffs on normal" % [advanced_torment.canonical_name])
		total_stacks = 0
		for effect in advanced_torment.active_effects.get_all_effects_nodes():
			if effect.canonical_name == "Self Cleaning": continue
			assert_has(Terms.get_all_effect_types("Buff"), effect.canonical_name)
			total_stacks += effect.stacks
		assert_eq(total_stacks, 0, "%s spammed no buffs" % [advanced_torment.canonical_name])

	func test_spam_buffs():
		# This ensures that it will always spawn the same amount of debuffs, regardless of seed
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(2)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		var total_stacks := 0
		for effect in advanced_torment.active_effects.get_all_effects_nodes():
			if effect.canonical_name == "Self Cleaning": continue
			assert_has(Terms.get_all_effect_types("Buff"), effect.canonical_name)
			total_stacks += effect.stacks
		assert_eq(total_stacks, 4, "%s spammed expected amount of buffs on normal" % [advanced_torment.canonical_name])
		total_stacks = 0
		for effect in dreamer.active_effects.get_all_effects_nodes():
			assert_has(Terms.get_all_effect_types("Debuff"), effect.canonical_name)
			total_stacks += effect.stacks
		assert_eq(total_stacks, 0, "%s spammed no debuffs" % [advanced_torment.canonical_name])

	func test_dispell_on_concentration():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.nunclucks.name, 3)
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.strengthen.name, 3)
		# This ensures that it will always spawn the same amount of debuffs, regardless of seed
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(4)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		var total_stacks := 0
		for effect in dreamer.active_effects.get_all_effects_nodes():
			total_stacks += abs(effect.stacks)
		assert_eq(total_stacks, 4,
				"%s dispelled expected amount of effects" % [advanced_torment.canonical_name])
		assert_eq(dreamer.damage, 4 * 2.5, "Dreamer took the expected amount of damage")
		

	func test_dispell_on_alone():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.quicken.name, -3)
		# This ensures that it will always spawn the same amount of debuffs, regardless of seed
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(4)
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 4 * 5, "Dreamer took the expected amount of damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), -3,
				"%s not dispelled negative %s" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.quicken.name])

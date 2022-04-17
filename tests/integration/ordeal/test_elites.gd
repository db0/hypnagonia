extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


class TestBully:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = load("res://src/dreamscape/CombatElements/Enemies/Elites/Bully.tscn")
		test_card_names = [
			"Confidence",
		]

	func test_spawn_buddies_on_damage():
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq( get_tree().get_nodes_in_group("MinionEnemyEntities").size(), 2, "All Buddies Summoned")

	func test_spawn_less_buddies_on_partial_block():
		dreamer.defence = 10
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq( get_tree().get_nodes_in_group("MinionEnemyEntities").size(), 1, "Partial Buddies Summoned")

	func test_spawn_no_buddies_on_full_block():
		dreamer.defence = 20
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq( get_tree().get_nodes_in_group("MinionEnemyEntities").size(), 0, "No Buddies Summoned")

class TestIndescribableAbsurdity:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = load("res://src/dreamscape/CombatElements/Enemies/Elites/IndescribableAbsurdity.tscn")
		test_card_names = [
			"Confidence",
		]

	func test_spam_debuffs():
		# This ensures that it will always spawn the same amount of debuffs, regardless of seed
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(2)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(4)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(4)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 4 * 5, "Dreamer took the expected amount of damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.quicken.name), -3,
				"%s not dispelled negative %s" % [advanced_torment.canonical_name, Terms.ACTIVE_EFFECTS.quicken.name])


class TestTheatrePlay:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = load("res://src/dreamscape/CombatElements/Enemies/Elites/TheatrePlay.tscn")
		test_card_names = [
			"Interpretation",
		]

	func test_init():
		# warning-ignore:return_value_discarded
		assert_eq(get_tree().get_nodes_in_group("MinionEnemyEntities").size(), 2, "All Acts Summoned")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_ne(dreamer.damage, 0, "Initial intent is always Stage Fright")
		assert_eq(count_card_names("Lacuna"), 2,
				"Initial intent is always Stage Fright")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(count_card_names("Lacuna"), 2,
				"Stage Fright not used twice in a row")

	func test_respawn_acts():
		for minion in get_tree().get_nodes_in_group("MinionEnemyEntities"):
			minion.die()
		yield(yield_for(1.1), YIELD)
		advanced_torment.intents.prepare_intents()
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq( get_tree().get_nodes_in_group("MinionEnemyEntities").size(), 2, "Acts Respawned")

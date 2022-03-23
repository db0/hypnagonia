extends "res://tests/HUT_Journal_NCESurpriseClass.gd"

class TestNCE:
	extends "res://tests/HUT_Journal_NCESurpriseClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd")

	func test_memory_rewards():
		begin_surprise_encounter(nce)
		yield(yield_to(cfc, "all_nodes_mapped", 3), YIELD)
		assert_has(cfc.NMAP, "board")
		if not cfc.NMAP.has("board"):
			return
		yield(yield_to(cfc.NMAP.board, "battle_begun", 2), YIELD)
		watch_signals(globals.encounters.run_changes)
		watch_signals(globals.player)
		var recurrence
		if get_tree().get_nodes_in_group("EnemyEntities").size() > 0:
			recurrence = get_tree().get_nodes_in_group("EnemyEntities")[0]
		assert_not_null(recurrence, "Recurrence spawned")
		if not recurrence:
			return
		assert_connected(cfc.NMAP.board.dreamer, recurrence,
				"effect_modified", "_on_dreamer_effect_modified")
		assert_connected(cfc.NMAP.board.dreamer, recurrence,
				"entity_defence_modified", "_on_dreamer_defended")
		assert_connected(cfc.NMAP.board.dreamer, recurrence,
				"entity_healed", "_on_dreamer_healed")
		assert_connected(cfc.NMAP.board.dreamer, recurrence,
				"entity_damaged", "_on_dreamer_damaged")
		assert_connected(cfc.signal_propagator, recurrence,
				"signal_received", "_on_card_signal_received")
		assert_eq(recurrence.get_property("_difficulty"), "easy", "Difficulty set correctly")
		end_surprise_encounter()
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd"))
		assert_signal_emit_count(globals.player, "memory_added", 2)

	func test_memory_upgrade_rewards():
		var mem1 = globals.player.add_memory(MemoryDefinitions.DamageAll.canonical_name)
		var mem2 = globals.player.add_memory(MemoryDefinitions.BossFaster.canonical_name)
		var mem3 = globals.player.add_memory(MemoryDefinitions.HealSelf.canonical_name)
		var mem4 = globals.player.add_memory(MemoryDefinitions.ProgressRandom.canonical_name)
		watch_signals(mem1)
		watch_signals(mem2)
		watch_signals(mem3)
		watch_signals(mem4)
		nce._test_memory_prep.selected_memories.append(mem1)
		nce._test_memory_prep.selected_memories.append(mem2)
		begin_surprise_encounter(nce)
		yield(yield_to(cfc, "all_nodes_mapped", 3), YIELD)
		assert_has(cfc.NMAP, "board")
		if not cfc.NMAP.has("board"):
			return
		yield(yield_to(cfc.NMAP.board, "battle_begun", 2), YIELD)
		watch_signals(globals.encounters.run_changes)
		watch_signals(globals.player)
		end_surprise_encounter()
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd"))
		assert_signal_emit_count(globals.player, "memory_added", 0)
		gut.p([cfc.game_rng.seed,cfc.game_rng.state])
		assert_signal_emitted_with_parameters(mem1, "memory_upgraded", [mem1,2])
		assert_signal_emitted_with_parameters(mem2, "memory_upgraded", [mem2,2])
		assert_signal_not_emitted(mem3, "memory_upgraded")
		assert_signal_not_emitted(mem4, "memory_upgraded")


	func test_learning():
		begin_surprise_encounter(nce)
		yield(yield_to(cfc, "all_nodes_mapped", 3), YIELD)
		assert_has(cfc.NMAP, "board")
		if not cfc.NMAP.has("board"):
			return
		yield(yield_to(cfc.NMAP.board, "battle_begun", 2), YIELD)
		board = cfc.NMAP.board
		hand = cfc.NMAP.hand
		deck = cfc.NMAP.deck
		discard = cfc.NMAP.discard
		forgotten = cfc.NMAP.forgotten
		player_info = board.player_info
		var card_list = [
			"Confidence",
			"Interpretation",
			"Interpretation",
			"Interpretation",
			"Interpretation",
			"Interpretation",
		]
		var recurrence
		if get_tree().get_nodes_in_group("EnemyEntities").size() > 0:
			recurrence = get_tree().get_nodes_in_group("EnemyEntities")[0]
		assert_not_null(recurrence, "Recurrence spawned")
		if not recurrence:
			return
		var sceng
		cards = setup_test_cards(card_list)
		for c in cards:
			c.properties.Cost = 0
		cards[0].scripts = BIG_DEFENCE_SCRIPT
		cards[1].scripts = EXERT_SCRIPT
		cards[2].scripts = EFFECT_SCRIPT
		cards[3].scripts = REPEAT_ATTACK_SCRIPT
		cards[4].scripts = DEBUFF_SCRIPT
		cards[5].scripts = HEAL_SCRIPT
		yield(yield_for(1), YIELD)
		for index in [3,4]:
			sceng = snipexecute(cards[index], recurrence)
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		for index in [0,1,2,5]:
			sceng = execute_with_yield(cards[index])
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		board.turn.call_deferred("end_player_turn")
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(surprise_combat_encounter.lessons_learned.get("attacks", []), [[6,6,6]], "Attacks learned")
		assert_eq(surprise_combat_encounter.lessons_learned.get("defences", []), [25], "Defences learned")
		assert_eq(surprise_combat_encounter.lessons_learned.get("heals", []), [-5], "Heals learned")
		var buffs = surprise_combat_encounter.lessons_learned.get("buffs", [])
		var debuffs = surprise_combat_encounter.lessons_learned.get("debuffs", [])
		assert_gt(buffs.size(), 0, "Buffs learned")
		assert_gt(debuffs.size(), 0, "Debuffs learned")
		if debuffs.size() == 0 or buffs.size() == 0:
			return
		assert_eq(buffs[0].hash(), {"Clarity":1}.hash(), "Correct Buffs learned")
		assert_eq(debuffs[0].hash(), {"Confusion":1}.hash(), "Correct Debuffs learned")
		assert_eq(surprise_combat_encounter.lessons_learned.get("cards", []), [6])


class TestCounterMeasureCalculations:
	extends "res://tests/HUTCommon.gd"
	const NCE = preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd")
	const RECURRENCE_ELITE = {
		"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")]
	}
	const RECURRENCE_SURPRISE = preload("res://src/dreamscape/Run/NCE/AllActs/RecurrenceCombatEncounter.gd")

	func test_recurrence_cm_high_defences():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["defences"] = [0,18,0,19,17,1,11]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["high_defences"])

	func test_recurrence_cm_defence_avg():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["defences"] = [9,12,6,12,12,1,11]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["defence_average"])

	func test_recurrence_cm_attack_amount():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["attacks"] = [
			[5,6,5,6,4,3,3,3],
			[14,5,5],
			[3,3,3],
			[2,2,2,2,2,2,2,2],
			[],
			[16,4,4,4,4],
			[18,3,3,3,3,3,3],
		]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["average_attacks"])

	func test_recurrence_cm_high_attacks():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["attacks"] = [[18],[20],[],[14],[],[15],[16]]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["high_attacks"])

	func test_recurrence_cm_heal_avg():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["heals"] = [0,-12,0,-12,-12,-1,-11]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["heals"])

	func test_recurrence_cm_card_avg():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["cards"] = [4,7,2,8,10,3,10,7,4,10,9]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["average_cards"])

	func test_recurrence_cm_nonspecific():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["heals"] = [0,0,0,5,0,0,0]
		sce.lessons_learned["attacks"] = [[6,6,6],[2,5],[],[7,7,7],[],[6,7,6],[6,6]]
		sce.lessons_learned["defences"] = [0,6,15,0,18,0,0]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["nonspecific"])

	func test_recurrence_buffs():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["buffs"] = [
			{"empower": 2},
			{"empower": 2},
			{"empower": 2},
			{"empower": 2},
			{"empower": 2},
		]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["empower"])

	func test_recurrence_debuffs():
		var sce = RECURRENCE_SURPRISE.new(
			RECURRENCE_ELITE,
			"easy",
			NCE.new())
		sce.lessons_learned["cards"] = [3,3,3,3,3,3,3]
		sce.lessons_learned["buffs"] = [
			{"disempower": 2, "poison": 6},
			{"disempower": 1},
			{"disempower": 1},
			{"disempower": 4},
		]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["disempower"])


class TestWildAttacksEasy:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		difficulty = "easy"
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
		test_card_names = [
			"Confidence",
		]

	func test_wild_attacks_easy():
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				wa * wa,
				"Dreamer took the expected amount of damage")


class TestWildAttacksMedium:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
		test_card_names = [
			"Confidence",
		]

	func test_wild_attacks_medium():
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				wa * wa,
				"Dreamer took the expected amount of damage")

	func test_wild_attacks_cm_impervious1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.impervious.name] = 1
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				(wa - 1) * wa,
				"Dreamer took the expected amount of damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.burn.name),
				wa + advanced_torment.intents.BURN_AMOUNT_MOD,
				"%s added %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.impervious.name])

	func test_wild_attacks_cm_armor1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.armor.name] = 1
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				(wa - 1) * wa,
				"Dreamer took the expected amount of damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.burn.name),
				wa + advanced_torment.intents.BURN_AMOUNT_MOD,
				"%s added %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.armor.name])

	func test_wild_attacks_cm_thorns1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.thorns.name] = 1
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.thorns.name, 10)
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				wa * wa,
				"Dreamer took the expected amount of damage")
		assert_eq(advanced_torment.damage,
				10,
				"Recurrence consolidated attacks to countermeasure against thorns")

	func test_wild_attacks_cm_high_defense1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags["high_defences"] = 1
		advanced_torment.intents.prepare_intents(0)
		dreamer.defence = 100
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				wa,
				"Dreamer took the expected amount of damage through pierce")

	func test_wild_attacks_cm_average_attacks1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags["average_attacks"] = 1
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
# warning-ignore:unused_variable
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.thorns.name),
				advanced_torment.intents.THORNS_AMOUNT,
				"%s added %s countermeasure" % [advanced_torment.name, "average_attacks"])


	func test_wild_attacks_cm_empower1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.empower.name] = 1
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
# warning-ignore:unused_variable
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower.name),
				advanced_torment.intents.DISEMPOWER_AMOUNT,
				"%s added double %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.empower.name])


	func test_wild_attacks_cm_buffer1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.buffer.name] = 1
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
# warning-ignore:unused_variable
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.drain.name),
				advanced_torment.intents.DRAIN_AMOUNT,
				"%s added double %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.buffer.name])

class TestWildAttacksHard:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		difficulty = "hard"
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
		test_card_names = [
			"Confidence",
		]

	func test_wild_attacks_hard():
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				wa * wa,
				"Dreamer took the expected amount of damage")


	func test_wild_attacks_cm_impervious2():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.impervious.name] = 2
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				(wa - 1) * wa,
				"Dreamer took the expected amount of damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.burn.name),
				wa + advanced_torment.intents.BURN_AMOUNT_MOD + advanced_torment.intents.BURN_CM_2_MOD,
				"%s added double %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.impervious.name])


	func test_wild_attacks_cm_armor2():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.armor.name] = 2
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				(wa - 1) * wa,
				"Dreamer took the expected amount of damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.burn.name),
				wa + advanced_torment.intents.BURN_AMOUNT_MOD + advanced_torment.intents.BURN_CM_2_MOD,
				"%s added double %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.armor.name])


	func test_wild_attacks_cm_armor1_and_impervious1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.armor.name] = 1
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.impervious.name] = 1
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				(wa - 1) * wa,
				"Dreamer took the expected amount of damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.burn.name),
				wa + advanced_torment.intents.BURN_AMOUNT_MOD + advanced_torment.intents.BURN_CM_2_MOD,
				"%s added %s and %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.armor.name, Terms.ACTIVE_EFFECTS.impervious.name])

	func test_wild_attacks_cm_high_defense2():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags["high_defences"] = 2
		advanced_torment.intents.prepare_intents(0)
		dreamer.defence = 100
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.damage,
				wa,
				"Dreamer took the expected amount of damage through pierce")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name),
				wa + advanced_torment.intents.POISON_AMOUNT_MOD + advanced_torment.intents.POISON_CM_2_MOD,
				"%s added double %s countermeasure" % [advanced_torment.name, "high_defences"])


	func test_wild_attacks_cm_high_defense1_and_impervious1():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags["high_defences"] = 1
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.impervious.name] = 1
		dreamer.defence = 100
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.burn.name),
				wa + advanced_torment.intents.BURN_AMOUNT_MOD,
				"%s added %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.impervious.name])
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.poison.name),
				wa + advanced_torment.intents.POISON_AMOUNT_MOD,
				"%s added %s countermeasure" % [advanced_torment.name, "high_defences"])
		assert_eq(dreamer.damage,
				wa,
				"Dreamer took the expected amount of damage through pierce")

	func test_wild_attacks_cm_high_attacks2():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags["high_attacks"] = 2
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
# warning-ignore:unused_variable
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name),
				advanced_torment.intents.IMPERVIOUS_STACKS,
				"%s added double %s countermeasure" % [advanced_torment.name, "high_attacks"])

	func test_wild_attacks_cm_average_attacks2():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags["average_attacks"] = 2
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
# warning-ignore:unused_variable
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.thorns.name),
				advanced_torment.intents.THORNS_AMOUNT + advanced_torment.intents.THORNS_CM_2_AMOUNT,
				"%s added double %s countermeasure" % [advanced_torment.name, "average_attacks"])

	func test_wild_attacks_cm_empower2():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.empower.name] = 2
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
# warning-ignore:unused_variable
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower.name),
				advanced_torment.intents.DISEMPOWER_AMOUNT + advanced_torment.intents.DISEMPOWER_CM_2_AMOUNT,
				"%s added double %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.empower.name])

	func test_wild_attacks_cm_buffer2():
		# warning-ignore:return_value_discarded
		advanced_torment.cm_flags[Terms.ACTIVE_EFFECTS.buffer.name] = 2
		advanced_torment.intents.prepare_intents(0)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
# warning-ignore:unused_variable
		var wa = advanced_torment.intents.WILD_AMOUNTS[difficulty]
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.drain.name),
				advanced_torment.intents.DRAIN_AMOUNT + advanced_torment.intents.DRAIN_CM_2_AMOUNT,
				"%s added double %s countermeasure" % [advanced_torment.name, Terms.ACTIVE_EFFECTS.buffer.name])


class TestLearnEasy:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		difficulty = "easy"
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
		test_card_names = [
			"Confidence",
			"Confidence",
			"Interpretation",
			"Interpretation",
		]

	func test_learn_easy():
		# warning-ignore:return_value_discarded
		counters.mod_counter("immersion", 1)
		var prev_counter = counters.get_counter("immersion")
# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		assert_eq(advanced_torment.defence,
				advanced_torment.intents.LEARNING_DEFENCE[difficulty],
				"Recurrence defended as expected")
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name),
				0,
				"%s did not add %s countermeasures" % [advanced_torment.name, "high_attacks"])
		var intents = advanced_torment.intents.get_children()
		assert_eq(intents.size(), 1, "Recurrence is slapping back for remaining immersion")
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text,
			str(prev_counter * advanced_torment.intents.LEFTOVER_IMMERSION_SLAP[difficulty]),
			"Attack copied")

	func test_mimic_easy():
		# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
# warning-ignore:return_value_discarded
		counters.mod_counter("immersion", 1)
		var sceng
		for index in [3,2]:
			sceng = snipexecute(cards[index], advanced_torment)
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		for index in [0,1]:
			sceng = execute_with_yield(cards[index])
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		assert_eq(advanced_torment.defence,
				advanced_torment.intents.LEARNING_DEFENCE[difficulty],
				"Recurrence defended as expected")
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name),
				0,
				"%s did not add %s countermeasures" % [advanced_torment.name, "high_attacks"])
		var intents = advanced_torment.intents.get_children()
		assert_eq(intents.size(), 3, "Recurrence should have copied all cards")
		for iindex in range(intents.size()):
			if iindex in [0,1]:
				assert_eq(intents[iindex].signifier_amount.text, str(6), "Attack copied")
			else:
				assert_eq(intents[iindex].signifier_amount.text, str(10), "Defences copied")


class TestLearnMedium:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
		test_card_names = [
			"Confidence",
			"Butterfly",
			"Nothing to Fear",
		]

	func test_learn_medium():
		# warning-ignore:return_value_discarded
		var prev_counter = counters.get_counter("immersion")
		advanced_torment.countermeasures = ["high_attacks"]
		advanced_torment._prepare_countermeasures()
		advanced_torment.intents.prepare_intents(1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		assert_eq(advanced_torment.defence,
				advanced_torment.intents.LEARNING_DEFENCE[difficulty],
				"Recurrence defended as expected")
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name),
				advanced_torment.intents.IMPERVIOUS_STACKS,
				"%s added %s countermeasures" % [advanced_torment.name, "high_attacks"])
		var intents = advanced_torment.intents.get_children()
		assert_eq(intents.size(), 1, "Recurrence is slapping back for remaining immersion")
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text,
			str(prev_counter * advanced_torment.intents.LEFTOVER_IMMERSION_SLAP[difficulty]),
			"Attack copied")

	func test_mimic_misc():
		# warning-ignore:return_value_discarded
		cards[0].scripts = EXERT_SCRIPT
		cards[1].scripts = EFFECT_SCRIPT
		var sceng
		for exec_card in cards:
			sceng = execute_with_yield(exec_card)
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		advanced_torment.countermeasures = ["high_attacks"]
		advanced_torment._prepare_countermeasures()
		advanced_torment.intents.prepare_intents(1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		var intents = advanced_torment.intents.get_children()
		assert_eq(intents.size(), 3, "Recurrence copying all intents")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(advanced_torment.damage,
				5,
				"Recurrence took exert damage")
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.empower.name),
				1,
				"%s added copied buffs" % [advanced_torment.name])
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.nothing_to_fear.name),
				0,
				"%s did not copy concentrations" % [advanced_torment.name])



class TestLearnHard:
	extends "res://tests/HUT_Ordeal_AdvancedTormentTestClass.gd"


	func _init() -> void:
		difficulty = "hard"
		advanced_torment_scene = preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
		test_card_names = [
			"Interpretation",
			"Interpretation",
			"Interpretation",
		]

	func test_learn_hard():
		# warning-ignore:return_value_discarded
		counters.mod_counter("immersion", -1)
		var prev_counter = counters.get_counter("immersion")
		advanced_torment.countermeasures = ["high_attacks","high_attacks"]
		advanced_torment._prepare_countermeasures()
# warning-ignore:return_value_discarded
		advanced_torment.intents.prepare_intents(1)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		# The wild attack amount for this difficulty
		assert_eq(advanced_torment.defence,
				advanced_torment.intents.LEARNING_DEFENCE[difficulty],
				"Recurrence defended as expected")
		assert_eq(advanced_torment.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.impervious.name),
				advanced_torment.intents.IMPERVIOUS_STACKS,
				"%s added %s countermeasures" % [advanced_torment.name, "high_attacks"])
		var intents = advanced_torment.intents.get_children()
		assert_eq(intents.size(), 1, "Recurrence is slapping back for remaining immersion")
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text,
			str(prev_counter * advanced_torment.intents.LEFTOVER_IMMERSION_SLAP[difficulty]),
			"Attack copied")



	func test_mimic_cm_thorns():
		# warning-ignore:return_value_discarded
		advanced_torment.countermeasures = [Terms.ACTIVE_EFFECTS.thorns.name,Terms.ACTIVE_EFFECTS.thorns.name]
		advanced_torment._prepare_countermeasures()
		advanced_torment.intents.prepare_intents(1)
		var sceng
		for exec_card in cards:
			sceng = snipexecute(exec_card, advanced_torment)
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		var intents = advanced_torment.intents.get_children()
		assert_eq(intents.size(), 1, "Recurrence is consolidating attacks as countermeasure to thorns")
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text,
			str(cards.size() * 6),
			"Attack copied and consolidated")


	func test_mimic_cm_pierce():
		# warning-ignore:return_value_discarded
		advanced_torment.countermeasures = ["high_defences","high_defences"]
		advanced_torment._prepare_countermeasures()
		advanced_torment.intents.prepare_intents(1)
		dreamer.defence = 100
		var sceng
		for exec_card in cards:
			sceng = snipexecute(exec_card, advanced_torment)
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		var intents = advanced_torment.intents.get_children()
		assert_eq(intents.size(), cards.size(), "Recurrence is setting up piercing as countermeasure to high defences")
		for iindex in range(intents.size()):
			assert_eq(intents[iindex].signifier_amount.text,
			str(6),
			"Attack copied and piercing")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage,
				cards.size() * 6,
				"Dreamer took the expected amount of piercing damage")
		



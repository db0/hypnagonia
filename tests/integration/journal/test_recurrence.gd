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
				"entity_defended", "_on_dreamer_defended")
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
		assert_signal_emit_count(globals.player, "memory_added", 1)
		assert_signal_emitted_with_parameters(mem1, "memory_upgraded", [mem1,2])
		assert_signal_not_emitted(mem2, "memory_upgraded")
		assert_signal_not_emitted(mem3, "memory_upgraded")
		assert_signal_not_emitted(mem4, "memory_upgraded")


class TestCounterMeasureCalculations:
	extends "res://tests/HUTCommon.gd"
	const NCE = preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd")
	const RECURRENCE_ELITE = {
		"scene": preload("res://src/dreamscape/CombatElements/Enemies/Elites/Recurrence.tscn")
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
		sce.lessons_learned["heals"] = [0,12,0,12,12,1,11]
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
			{"disempower": 2},
			{"disempower": 1},
			{"disempower": 1},
			{"disempower": 4},
		]
		sce.finish_surpise_ordeal()
		assert_eq(globals.encounters.run_changes.store.get("Recurrence"), ["disempower"])

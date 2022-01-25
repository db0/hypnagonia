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

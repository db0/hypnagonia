extends "res://tests/HUT_Journal_NCESurpriseClass.gd"

class TestNCE:
	extends "res://tests/HUT_Journal_NCESurpriseClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd")

	func test_memory_rewards():
		begin_surprise_encounter(nce)
		yield(yield_to(cfc, "all_nodes_mapped", 3), YIELD)
		assert_has(cfc.NMAP, "board")
		watch_signals(globals.encounters.run_changes)
		watch_signals(globals.player)
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
		watch_signals(globals.encounters.run_changes)
		watch_signals(globals.player)
		end_surprise_encounter()
		assert_nce_unlocked(preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd"))
		assert_signal_emit_count(globals.player, "memory_added", 1)
		assert_signal_emitted_with_parameters(mem3, "memory_upgraded", [mem3,2])
		assert_signal_not_emitted(mem1, "memory_upgraded")
		assert_signal_not_emitted(mem2, "memory_upgraded")
		assert_signal_not_emitted(mem4, "memory_upgraded")

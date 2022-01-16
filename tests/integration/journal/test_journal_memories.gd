extends "res://tests/HUT_Journal_MemoriesTestClass.gd"

class TestProgressRandom:
	extends "res://tests/HUT_Journal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.ProgressRandom.canonical_name
		expected_amount_keys = [
			"progress_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		watch_signals(globals.player.deck)
		memory._use()
		yield(yield_to(globals.player.deck, "card_entry_progressed", 0.2), YIELD)
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_progressed")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.upgrade_progress, get_amount("progress_amount"),
				"Selected card progressed as expected")

class TestBossFaster:
	extends "res://tests/HUT_Journal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.BossFaster.canonical_name
		expected_amount_keys = [
			"pathos_amount",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		memory._use()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.boss], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [memory.canonical_name])


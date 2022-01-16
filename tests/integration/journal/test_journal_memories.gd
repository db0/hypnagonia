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
		assert_signal_emitted(globals.player.deck, "card_entry_progressed")
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


class TestRerollDraft:
	extends "res://tests/HUT_Journal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.RerollDraft.canonical_name
		expected_amount_keys = [
			"max_upgrades",
			"upgrade_multiplier",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		assert_false(memory.active_highlight.visible, "memory not technically active because it has a special condition")
		memory._use()
		assert_true(memory.artifact_object.is_ready, "memory object is charged after invalid use attempt")
		var current_draft : CardDraft = get_tree().get_nodes_in_group("card_draft")[0]
		var pre_use_draft = current_draft.get_children()
		current_draft.display()
		yield(yield_to(current_draft, "draft_prepared", 0.2), YIELD)
		journal.display_enemy_rewards('')
		assert_true(memory.active_highlight.visible, "memory active after draft cards appear")
		memory._use()
		yield(yield_to(current_draft, "draft_prepared", 0.2), YIELD)
		assert_ne(pre_use_draft, current_draft.get_children())
		


class TestRemovePerturbation:
	extends "res://tests/HUT_Journal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.RemovePerturbation.canonical_name
		expected_amount_keys = [
			"max_upgrades",
			"upgrade_multiplier",
		]
		test_card_names = [
			"Lacuna",
			"Gaslighter",
			"Lacuna",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		watch_signals(globals.player.deck)
		memory._use()
		yield(yield_to(globals.player.deck, "card_removed", 0.2), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_removed", 1, "Only single card removed")
		var signal_details = get_signal_parameters(globals.player.deck, "card_removed")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_eq(card_entry.properties.Type, "Perturbation", "Correct type of card removed")



class TestGainMaxHealth:
	extends "res://tests/HUT_Journal_MemoriesTestClass.gd"
	func _init() -> void:
		testing_memory_name = MemoryDefinitions.GainMaxHealth.canonical_name
		expected_amount_keys = [
			"anxiety_amount",
			"upgrade_multiplier",
			"max_upgrades",
		]

	func test_memory_use():
		if not assert_has_amounts():
			return
		watch_signals(globals.player)
		memory._use()
		yield(yield_to(globals.player, "health_changed", 0.2), YIELD)
		assert_signal_emitted(globals.player, "health_changed")
		var signal_details = get_signal_parameters(globals.player, "health_changed")
		if not signal_details or signal_details.size() == 0:
			return
		var new_health = signal_details[1]
		assert_eq(new_health, PLAYER_HEALTH + get_amount("anxiety_amount"))
		assert_eq(globals.player.health, PLAYER_HEALTH + get_amount("anxiety_amount"))


extends "res://tests/HUT_Journal_NCESurpriseClass.gd"

class TestNCE:
	extends "res://tests/HUT_Journal_NCESurpriseClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/UnderwaterCave.gd")

	func test_rewards():
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key('explore')
		yield(yield_to(cfc, "all_nodes_mapped", 3), YIELD)
		surprise_combat_encounter = nce.surprise_combat_encounter
		assert_has(cfc.NMAP, "board")
		if not cfc.NMAP.has("board"):
			return
		yield(yield_to(cfc.NMAP.board, "battle_begun", 2), YIELD)
		watch_signals(globals.encounters.run_changes)
		watch_signals(globals.player)
		watch_signals(globals.player.pathos)
		assert_eq(get_tree().get_nodes_in_group("EnemyEntities").size(), 2, "Basic Enemies spawned")
		if not surprise_combat_encounter:
			return
		end_surprise_encounter()
		assert_signal_emit_count(globals.player, "memory_added", 1)
		assert_signal_emit_count(globals.player, "artifact_added", 1)
		assert_pathos_signaled('released_pathos_gained', nce.PATHOS)
		var new_choice = journal.entries_list.get_node("CustomDraft")
		watch_signals(globals.player.deck)
		if new_choice:
			assert_eq(new_choice.draft_nodes.size(), 1)
			new_choice._execute_custom_entry()
			yield(yield_for(0.3), YIELD)
			assert_not_null(new_choice, "Custom choice added to journal")
			var draft_node : CardDraft = new_choice.draft_nodes[0].get_child(0)
			if draft_node as CardDraft:
				var draft_card = draft_node.get_child(1)
				watch_signals(draft_node)
				if draft_card as CVGridCardObject and globals.player.deck:
					watch_signals(draft_card)
					draft_card.select_card()
					assert_signal_emitted(draft_card, "card_selected")
			yield(yield_to(globals.player.deck, "card_added", 1), YIELD)
			assert_signal_emitted(draft_node, "card_drafted")
			assert_signal_emitted(globals.player.deck, "card_added")
			var signal_details = get_signal_parameters(globals.player.deck, "card_added")
			assert_is(signal_details[0], CardEntry)

class TestLeave:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/UnderwaterCave.gd")

	func test_choice_leave():
		globals.player.pathos.released[nce.PATHOS] = 500
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("released_pathos_lost", nce.PATHOS)
		assert_eq(globals.player.pathos.released[nce.PATHOS], 0)

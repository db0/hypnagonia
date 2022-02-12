extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestMultipleDestroys:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act3/MultipleDestroys.gd")

	func test_choices():
		watch_signals(globals.player.deck)
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		# Option should be disabled because the deck doesn't have a relevant card type
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key == "Understanding":
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
			else:
				assert_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		activate_secondary_choice_by_key("Action")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_removed")
		var removed_cards_signal = get_signal_parameters(globals.player.deck, "card_removed")
		if not removed_cards_signal or removed_cards_signal.size() == 0:
			return
		var removed_card: CardEntry = removed_cards_signal[0]
		assert_eq(removed_card.properties.Type, "Action")

	func test_other_choices():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("Control")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_removed")
		var removed_cards_signal = get_signal_parameters(globals.player.deck, "card_removed")
		if not removed_cards_signal or removed_cards_signal.size() == 0:
			return
		var removed_card: CardEntry = removed_cards_signal[0]
		assert_eq(removed_card.properties.Type, "Control")

class TestArtifactReward:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act3/ArtifactReward.gd")

	func test_receive():
		var porg := set_random_pathos_org("released")
		watch_signals(globals.player)
		watch_signals(globals.player.pathos)
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		# Option should be disabled because the deck doesn't have a relevant card type
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key == "use":
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
			else:
				assert_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		activate_secondary_choice_by_key("receive")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")
		var added_artifact_signal = get_signal_parameters(globals.player, "artifact_added")
		if not added_artifact_signal or added_artifact_signal.size() == 0:
			return
		var added_artifact: ArtifactObject = added_artifact_signal[0]
		assert_eq(added_artifact.canonical_name, nce.SPECIAL_ARTIFACT)
		assert_pathos_signaled("pathos_spent", porg.high)

	func test_use():
		globals.player.add_artifact(nce.SPECIAL_ARTIFACT)
		var porg := set_random_pathos_org("released", true)
		watch_signals(globals.player)
		watch_signals(globals.player.pathos)
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		# Option should be disabled because the deck doesn't have a relevant card type
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key == "receive":
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
			else:
				assert_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		activate_secondary_choice_by_key("use")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_pathos_signaled("released_pathos_gained", porg.low)


class TestSubconsciousProcessing:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act3/SubconsciousProcessing.gd")

	func test_comment():
		var choice = "comment"
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key(choice)
		var new_choice = journal.entries_list.get_node("CustomDraft")
		watch_signals(globals.player.deck)
		if new_choice:
			assert_eq(new_choice.draft_nodes.size(), nce.DRAFTS[choice])
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
			var card_entry: CardEntry = signal_details[0]
			assert_eq(globals.player.damage, nce.DAMAGES[choice])

	func test_debug():
		var choice = "debug"
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key(choice)
		var new_choice = journal.entries_list.get_node("CustomDraft")
		watch_signals(globals.player.deck)
		if new_choice:
			assert_eq(new_choice.draft_nodes.size(), nce.DRAFTS[choice])
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
			var card_entry: CardEntry = signal_details[0]
			assert_eq(globals.player.damage, nce.DAMAGES[choice])

	func test_refactor():
		var choice = "refactor"
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key(choice)
		var new_choice = journal.entries_list.get_node("CustomDraft")
		watch_signals(globals.player.deck)
		if new_choice:
			assert_eq(new_choice.draft_nodes.size(), nce.DRAFTS[choice])
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
			var card_entry: CardEntry = signal_details[0]
			assert_eq(globals.player.damage, nce.DAMAGES[choice])

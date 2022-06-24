extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestMultipleDestroys:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/MultipleDestroys.gd")

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
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/ArtifactReward.gd")

	func test_receive():
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
		assert_signal_emitted(globals.player.pathos, "advancements_modified")
		assert_eq(globals.player.pathos.available_masteries, 0)

	func test_use():
		globals.player.add_artifact(nce.SPECIAL_ARTIFACT)
		var porg := set_random_pathos_org("level", true)
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
		assert_eq(globals.player.pathos.available_masteries, Pathos.STARTING_MASTERIES + nce.MASTERIES_AMOUNT)


class TestSubconsciousProcessing:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/SubconsciousProcessing.gd")

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


class TestBeastMirror:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/BeastMirror.gd")

	func test_choice_bear():
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.health, PLAYER_HEALTH, "Player max health not modified")
		assert_signal_not_emitted(globals.player.deck, "card_added")

	func test_choice_continue():
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("continue")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.health, PLAYER_HEALTH + nce.CONTINUE_HEALTH_LOSS, "Player max health modified")
		# warning-ignore:return_value_discarded
		assert_deck_signaled("card_added", "card_name", "Beast Mode")


class TestExperience:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/Experience.gd")

	func test_disabled_choices():
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key in ["card", "memory", "pathos"]:
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")

	func test_choice_card():
		globals.player.deck.add_new_card("+ Interpretation +")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("card")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		yield(yield_for(0.2), YIELD)
		var selection_decks =  get_tree().get_nodes_in_group("selection_decks")
		var selection_deck2 : SelectionDeck = selection_decks[0]
		selection_deck2._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_entry_progressed")
		assert_signal_emitted(globals.player.deck, "card_removed")

	func test_choice_memory():
		globals.player.deck.add_new_card("+ Interpretation +")
		var mem1 = globals.player.add_memory(MemoryDefinitions.DamageAll.canonical_name)
		watch_signals(mem1)
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("memory")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted_with_parameters(mem1, "memory_upgraded", [mem1, nce.MEMORY_PROGRESS])

	func test_choice_pathos():
		globals.player.deck.add_new_card("+ Interpretation +")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("pathos")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_eq(globals.player.pathos.available_masteries, Pathos.STARTING_MASTERIES + nce.MASTERIES_AMOUNT)

	func test_choice_progress():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("progress")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_pathos_signaled("pathos_repressed", nce.PATHOS)
		assert_signal_not_emitted(globals.player.deck, "card_removed")

class TestMultipleProgress:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/MultipleProgress.gd")

	func test_secret_relic():
		for card in globals.player.deck.cards:
			card.upgrade_progress = card.upgrade_threshold
		watch_signals(globals.player)
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		var found_secret_choice := false
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key in ["progress2", "progress4", "progress6"]:
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
			if selected_choice.choice_key == 'secret':
				found_secret_choice = true
		assert_true(found_secret_choice)
		if not found_secret_choice:
			return
		activate_secondary_choice_by_key("secret")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")

	func test_progress4():
		for citer in range(globals.player.deck.cards.size() - 3):
			globals.player.deck.cards[citer].upgrade_progress = 100
		watch_signals(globals.player.deck)
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		var found_secret_choice := false
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key in ["progress6"]:
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
			if selected_choice.choice_key in ["progress2", "progress4"]:
				assert_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
			if selected_choice.choice_key == 'secret':
				found_secret_choice = true
		assert_false(found_secret_choice)
		activate_secondary_choice_by_key("progress4")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var progressed_cards := 0
		for card in globals.player.deck.cards:
			if card.upgrade_progress and card.upgrade_progress != card.upgrade_threshold:
				assert_eq(card.upgrade_progress, nce.CARD_PROGRESS, "Cards progressed correct amount")
				progressed_cards += 1
		assert_eq(progressed_cards, 3, "Correct amount of cards progressed")
		assert_eq(globals.player.damage, nce.PROGRESS4_DAMAGE)


class TestCockroaches:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/Cockroaches.gd")

	func test_ignore():
		globals.player.damage = 50
		watch_signals(globals.player.deck)
		var choice = "ignore"
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key(choice)
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_added")
		assert_eq(globals.player.damage, 50 * nce.DAMAGE_PCT_REDUCE)
		
	func test_stomp():
		globals.player.damage = 50
		watch_signals(globals.player.deck)
		var choice = "stomp"
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key(choice)
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player.deck, "card_added")
		assert_eq(globals.player.damage, 50 + nce.STOMP_DAMAGE)

class TestCake:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/TheCake.gd")

	func test_disabled_choices():
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key in ["recipe", "map", "ground"]:
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")

	func test_choice_recipe():
		globals.player.deck.add_new_card("+ Interpretation +")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("recipe")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		yield(yield_for(0.2), YIELD)
		assert_signal_emitted(globals.player.deck, "card_added")
		assert_signal_emitted(globals.player.deck, "card_entry_progressed")
		assert_signal_emitted(globals.player.deck, "card_removed")

	func test_choice_map():
		globals.player.deck.add_new_card("+ Interpretation +")
		var mem1 = globals.player.add_memory(MemoryDefinitions.DamageAll.canonical_name)
		watch_signals(mem1)
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("map")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		yield(yield_for(0.2), YIELD)
		var selection_decks =  get_tree().get_nodes_in_group("selection_decks")
		var selection_deck2 : SelectionDeck = selection_decks[0]
		selection_deck2._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_duplicated")

	func test_choice_ground():
		globals.player.deck.add_new_card("+ Interpretation +")
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("ground")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		yield(yield_for(0.2), YIELD)
		var selection_decks =  get_tree().get_nodes_in_group("selection_decks")
		var selection_deck2 : SelectionDeck = selection_decks[0]
		selection_deck2._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_eq(card_entry.properties.Cost, card_entry.printed_properties.Cost - 1,
				"Card modified to have -1 cost")
		assert_gt(card_entry.printed_properties.Cost, 0,
				"Selected card had originally more than 0 cost")

	func test_choice_support():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("support")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player.deck, "card_removed")


class TestCucumbers:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act3/Cucumbers.gd")


	func test_choice_stand():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("stand")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_entry_modified")

	func test_choice_jump():
		globals.player.damage = 40
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("jump")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(globals.player.damage, 40 - nce.RELAX_AMOUNT)
		assert_signal_emitted(globals.player.deck, "card_entry_modified")

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

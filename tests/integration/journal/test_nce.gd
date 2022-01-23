extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestTheCandyman:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/AllActs/TheCandyman.gd")

	func test_selecting_with_starting_deck():
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice(0)
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		assert_signal_emitted(journal, "selection_deck_spawned")
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1, "Selected Deck spawned")
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
		watch_signals(globals.player.deck)
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_added")
		var signal_details = get_signal_parameters(nested_choices_scene, "secondary_choice_selected")
		assert_gt(signal_details.size(), 0, "secondary option selected")
		if signal_details.size() >= 1:
			var choice_key = signal_details[0]
			var removed_card = get_signal_parameters(globals.player.deck, "card_removed")
			var added_card = get_signal_parameters(globals.player.deck, "card_added")
			if removed_card.size() > 0 and added_card.size() > 0:
				var cards = [removed_card[0], added_card[0]]
				var used_indexes := []
				for index in range(2):
					for c in cards:
						if c.properties.Type == HConst.COLOUR_MAP[choice_key[index]] and not index in used_indexes:
							used_indexes.append(index)
				assert_eq(used_indexes.size(), 2, "Added and Removed cards match the candy colours")

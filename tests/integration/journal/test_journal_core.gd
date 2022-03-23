extends "res://tests/HUTCommon_Journal.gd"

class TestUpgrades:
	extends "res://tests/HUTCommon_Journal.gd"

	func test_upgrades():
		for c in globals.player.deck.get_progressing_cards():
			c.upgrade_progress = c.upgrade_threshold
		watch_signals(journal)
		watch_signals(globals.player.deck)
		journal.call_deferred("display_enemy_rewards")
		yield(yield_to(journal._tween, "tween_all_completed", 1), YIELD)
		assert_signal_emitted(journal, "entry_displayed")
		assert_almost_ne(journal.card_upgrade.modulate.a, 0.0, 0.1)
		journal.card_upgrade.display()
		assert_ne(journal.card_upgrade.get_child_count(),0)
		var upgrade_choices : Array = get_tree().get_nodes_in_group("choice_card_objects")
		assert_ne(upgrade_choices.size(), 0)
		if not upgrade_choices.size():
			return
		upgrade_choices[0].select_card()
		var selection_windows : Array = get_tree().get_nodes_in_group("selection_windows")
		assert_ne(selection_windows.size(), 0)
		if not selection_windows.size():
			return
		yield(yield_to(selection_windows[0], "card_choices_ready", 1), YIELD)
		selection_windows[0].select_cards([0])
		assert_signal_emitted(globals.player.deck, "card_entry_upgraded")
		

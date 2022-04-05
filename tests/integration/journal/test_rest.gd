extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestRest:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Rest.gd")

	func test_option_rest():
		globals.player.damage = 50
		watch_signals(globals.player)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			assert_has(["rest", "progress", "resist"], selected_choice.choice_key, "Ensure unlockable options not shown")
		activate_secondary_choice_by_key("rest")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "health_changed")
		assert_eq(globals.player.damage, 25)

class TestProgress:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Rest.gd")
		
	func test_option_progress():
		globals.player.damage = 50
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("progress")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_entry_progressed")
		assert_signal_not_emitted(globals.player, "health_changed")
		assert_eq(globals.player.damage, 50)

class TestQuickenUp:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Rest.gd")
		
	func test_option_quicken_up():
		var curio = globals.player.add_artifact(ArtifactDefinitions.QuickenUp.canonical_name)
		globals.player.damage = 50
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("quicken_up")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(curio.counter, 1, "Curio received counter")
		
	func test_option_quicken_up_disabled():
		var curio = globals.player.add_artifact(ArtifactDefinitions.QuickenUp.canonical_name)
		curio.counter = ArtifactDefinitions.QuickenUp.max_uses
		globals.player.damage = 50
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key == 'quicken_up':
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		

class TestStrengthenUp:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Rest.gd")
		
	func test_option_quicken_up():
		var curio = globals.player.add_artifact(ArtifactDefinitions.StrengthenUp.canonical_name)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("strengthen_up")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_eq(curio.counter, 1, "Curio received counter")
		
	func test_option_quicken_up_disabled():
		var curio = globals.player.add_artifact(ArtifactDefinitions.StrengthenUp.canonical_name)
		curio.counter = ArtifactDefinitions.StrengthenUp.max_uses
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key == 'strengthen_up':
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		

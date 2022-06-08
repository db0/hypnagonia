extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestBannersOfRuin:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/BannersOfRuin.gd")

	func test_choice_mouse():
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("mouse")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.health, 90, "Player max health decreased")
		assert_signal_not_emitted(globals.player.deck, "card_added")

	func test_choice_bear():
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("bear")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.health, 110, "Player max health increased")
		assert_signal_not_emitted(globals.player.deck, "card_added")

	func test_choice_hyena():
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("hyena")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_eq(globals.player.health, PLAYER_HEALTH, "Player max health not modified")
		# warning-ignore:return_value_discarded
		assert_deck_signaled("card_added", "card_name", "Hyena")

class TestGriftlands:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/Griftlands.gd")

	func test_choice_spy():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("spy")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Common")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.class]),
					card.card_name, "Card Belongs to Ego Aspect")
		assert_eq(globals.player.damage, 0, "Player took no damage")

	func test_choice_double_cross():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("double-cross")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Uncommon")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.class]),
					card.card_name, "Card Belongs to Ego Aspect")
		assert_eq(globals.player.damage, 7, "Player took damage")

	func test_choice_triple_cross():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("triple-cross")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Rare")
		assert_eq(globals.player.damage, 15, "Player took damage")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.class]),
					card.card_name, "Card Belongs to Ego Aspect")

class TestGriftlands2:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/Griftlands2.gd")

	func test_choice_drink():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("drink")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Common")
		assert_eq(globals.player.damage, 0, "Player took no damage")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.race]),
					card.card_name, "Card Belongs to Disposition Aspect")
		assert_eq(globals.player.damage, 0, "Player took no damage")

	func test_choice_gamble():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("gamble")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Uncommon")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.race]),
					card.card_name, "Card Belongs to Disposition Aspect")
		assert_eq(globals.player.damage, 7, "Player took damage")

	func test_choice_investigate():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("investigate")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Rare")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.race]),
					card.card_name, "Card Belongs to Disposition Aspect")
		assert_eq(globals.player.damage, 15, "Player took damage")

class TestGriftlands3:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/Griftlands3.gd")

	func test_choice_lay_low():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("lay_low")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Common")
		assert_eq(globals.player.damage, 0, "Player took no damage")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.life_goal]),
					card.card_name, "Card Belongs to Injustice Aspect")
		assert_eq(globals.player.damage, 0, "Player took no damage")

	func test_choice_clear_name():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("clear_name")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Uncommon")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.life_goal]),
					card.card_name, "Card Belongs to Injustice Aspect")
		assert_eq(globals.player.damage, 7, "Player took damage")

	func test_choice_revenge():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("revenge")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		var card = assert_deck_signaled("card_added", "_rarity", "Rare")
		if card:
			assert_has(Aspects.get_all_cards_in_archetype(
					globals.player.deck_groups[Terms.CARD_GROUP_TERMS.life_goal]),
					card.card_name, "Card Belongs to Injustice Aspect")
		assert_eq(globals.player.damage, 15, "Player took damage")

class TestLoseRandomCurio:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/LoseRandomCurio.gd")
		pre_init_artifacts.append(ArtifactDefinitions.EndingHeal.canonical_name)

	func test_choice_allow():
		watch_signals(globals.player)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("allow")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		assert_player_signaled("artifact_added", 'canonical_name', "BetterArtifactChance")
		assert_signal_emitted(globals.player, "artifact_removed")

	func test_choice_deny():
		watch_signals(globals.player)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("deny")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player, "artifact_added")
		assert_signal_not_emitted(globals.player, "artifact_removed")

class TestMiniShop:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/MiniShop.gd")

	func test_choice_remove():
		globals.player.pathos.available_masteries = testing_nce_script.COSTS["remove"]
		watch_signals(globals.player.deck)
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key in ["progress", "upgrade"]:
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		activate_secondary_choice_by_key("remove")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		assert_signal_emitted_with_parameters(globals.player.pathos, "advancements_modified", [0,1])
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")

	func test_choice_progress():
		globals.player.pathos.available_masteries = testing_nce_script.COSTS["progress"]
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("progress")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		assert_signal_emitted_with_parameters(globals.player.pathos, "advancements_modified", [0,2])
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emit_count(globals.player.deck, "card_entry_progressed", 2)


	func test_choice_upgrade():
		globals.player.pathos.available_masteries = 10
		var memory : MemoryObject = globals.player.add_memory('DamageAll')
		watch_signals(memory)
		watch_signals(globals.player)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("upgrade")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		assert_signal_emitted_with_parameters(
				globals.player.pathos, 
				"advancements_modified", 
				[10 - testing_nce_script.COSTS["upgrade"],10])
		assert_signal_emit_count(memory, "memory_upgraded", 1)
		assert_eq(memory.upgrades_amount, testing_nce_script.MEMORY_PROGRESS)

	func test_choice_leave():
		watch_signals(globals.player.deck)
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key != "leave":
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player.pathos, "pathos_spent")

class TestMultipleScriptMods:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/MultipleScriptMods.gd")

	func test_choice_scold():
		watch_signals(globals.player.deck)
		var secondary_choices = begin_nce_with_choices(nce)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		# Option should be disabled because the deck doesn't have a relevant card
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key == "ignore":
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		activate_secondary_choice_by_key("scold")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_deck_signaled("card_entry_modified", "_amounts", "defence_amount")

	func test_choice_flail():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("flail")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_deck_signaled("card_entry_modified", "_amounts", "damage_amount")

	func test_choice_ignore():
		globals.player.deck.add_new_card("Guilt")
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("ignore")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_deck_signaled("card_entry_modified", "_amounts", "draw_amount")

class TestMultipleTags:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/AlphaKappaOmega.gd")

	func test_choice_alpha():
		globals.player.pathos.available_masteries = testing_nce_script.COSTS["alpha"]
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		watch_signals(globals.player.pathos)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("alpha")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_deck_signaled("card_entry_modified", "Tags", Terms.GENERIC_TAGS.alpha.name)
		assert_signal_emitted_with_parameters(
				globals.player.pathos, 
				"advancements_modified", 
				[0,testing_nce_script.COSTS["alpha"]])

	func test_choice_kappa():
		globals.player.pathos.available_masteries = testing_nce_script.COSTS["kappa"]
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		watch_signals(globals.player.pathos)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("kappa")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_deck_signaled("card_entry_modified", "Tags", Terms.GENERIC_TAGS.frozen.name)
		assert_signal_emitted_with_parameters(
				globals.player.pathos, 
				"advancements_modified", 
				[0,testing_nce_script.COSTS["kappa"]])

	func test_choice_omega():
		globals.player.pathos.available_masteries = testing_nce_script.COSTS["omega"]
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		watch_signals(globals.player.pathos)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("omega")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_deck_signaled("card_entry_modified", "Tags", Terms.GENERIC_TAGS.omega.name)
		assert_signal_emitted_with_parameters(
				globals.player.pathos, 
				"advancements_modified", 
				[0,testing_nce_script.COSTS["omega"]])

	func test_choice_leave():
		var secondary_choices = begin_nce_with_choices(nce)
		watch_signals(globals.player.pathos)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("leave")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		for selected_choice in get_tree().get_nodes_in_group("secondary_choices"):
			if selected_choice.choice_key != "leave":
				assert_not_connected(selected_choice, secondary_choices, "pressed", "_on_choice_pressed")
		assert_signal_not_emitted(globals.player.pathos, "pathos_spent")

class TestRiskyEvent3:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/RiskyEvent3.gd")

	func test_choice_emotions():
		var key = "emotions"
		var reduction = round(globals.player.health * nce.amounts[key])
		var expected_player_health = PLAYER_HEALTH - reduction
		var porg := set_random_pathos_org("released")
		var secondary_choices = begin_nce_with_choices(nce)
		watch_signals(globals.player.pathos)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_signal_emit_count(globals.player.pathos, "released_pathos_gained", 1)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts[key]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_signal_emit_count(globals.player.pathos, "released_pathos_gained", 2)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts[key]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_signal_emit_count(globals.player.pathos, "released_pathos_gained", 3)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts["bliss"]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key("bliss")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emit_count(globals.player.pathos, "released_pathos_gained", 3)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		assert_signal_emitted(nce, "encounter_end")

	func test_choice_knowledge():
		var key = "knowledge"
		var reduction = round(globals.player.health * nce.amounts[key])
		var expected_player_health = PLAYER_HEALTH - reduction
		var porg := set_random_pathos_org("released")
		var secondary_choices = begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_deck_signaled("card_added", "Type", "Understanding", 0)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts[key]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_deck_signaled("card_added", "Type", "Understanding", 1)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts[key]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_deck_signaled("card_added", "Type", "Understanding", 2)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts["bliss"]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key("bliss")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emit_count(globals.player.deck, "card_added", 3)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		assert_signal_emitted(nce, "encounter_end")

	func test_choice_memories():
		var memory := globals.player.add_memory('DamageAll')
		var key = "memories"
		var reduction = 5
		var expected_player_health = PLAYER_HEALTH - reduction
		var porg := set_random_pathos_org("released")
		var secondary_choices = begin_nce_with_choices(nce)
		watch_signals(memory)
		if secondary_choices as GDScriptFunctionState:
			secondary_choices = yield(secondary_choices, "completed")
		if not secondary_choices:
			return
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_signal_emit_count(memory, "memory_upgraded", 1)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts[key]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_signal_emit_count(memory, "memory_upgraded", 2)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts[key]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key(key)
		yield(yield_to(secondary_choices, "secondary_choice_selected", 0.2), YIELD)
		assert_signal_emit_count(memory, "memory_upgraded", 3)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		reduction = nce.amounts["bliss"]
		expected_player_health = expected_player_health - reduction
		activate_secondary_choice_by_key("bliss")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emit_count(memory, "memory_upgraded", 3)
		assert_almost_eq(globals.player.health, expected_player_health, 0.2)
		assert_signal_emitted(nce, "encounter_end")


class TestRiskyEvent4:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/RiskyEvent4.gd")

	func test_choice_help():
		var porg := set_random_pathos_org("released")
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		watch_signals(globals.player.pathos)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("help")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")
		assert_signal_emitted(globals.player.pathos, "advancements_modified")

	func test_choice_ignore():
		var porg := set_random_pathos_org("released")
		begin_nce_with_choices(nce)
		watch_signals(globals.player)
		watch_signals(globals.player.deck)
		watch_signals(globals.player.pathos)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("ignore")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_emitted(globals.player, "artifact_added")
		assert_pathos_signaled("pathos_leveled", nce.ignore_pathos)
		assert_deck_signaled("card_added", "card_name", "Apathy")


class TestSubconscious:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/Subconscious.gd")

	func test_choice_intrerpret():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		watch_signals(globals.player.pathos)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("intrerpret")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_deck_signaled("card_added", "card_name", "Subconscious")
		assert_eq(globals.player.damage, nce.DAMAGE_AMOUNT)
		assert_signal_not_emitted(globals.player.pathos, "released_pathos_gained")

	func test_choice_avoid():
		var porg := set_random_pathos_org("level", true)
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		watch_signals(globals.player.pathos)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("avoid")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player.deck, "card_added")
		assert_eq(globals.player.damage, 0)
		assert_pathos_signaled("released_pathos_gained", porg.low.name)


class TestHangingOn:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/HangingOn.gd")

	func test_choice_swing_succeed():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		nce._testing_rng = 51
		activate_secondary_choice_by_key("swing")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_added")
		var removed_cards_signal = get_signal_parameters(globals.player.deck, "card_removed")
		var added_cards_signal = get_signal_parameters(globals.player.deck, "card_added")
		if not removed_cards_signal\
				or not added_cards_signal \
				or removed_cards_signal.size() == 0\
				or added_cards_signal.size() == 0:
			return
		var removed_card: CardEntry = removed_cards_signal[0]
		var added_card: CardEntry = added_cards_signal[0]
		assert_eq(removed_card.properties.Type, "Control")
		assert_eq(added_card.properties.Type, "Action")
		assert_eq(globals.player.damage, 0)

	func test_choice_swing_fail():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		nce._testing_rng = 50
		activate_secondary_choice_by_key("swing")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_added")
		var removed_cards_signal = get_signal_parameters(globals.player.deck, "card_removed")
		var added_cards_signal = get_signal_parameters(globals.player.deck, "card_added")
		if removed_cards_signal.size() == 0 or added_cards_signal.size() == 0:
			return
		var removed_card: CardEntry = removed_cards_signal[0]
		var added_card: CardEntry = added_cards_signal[0]
		assert_eq(removed_card.properties.Type, "Control")
		assert_eq(added_card.properties.Type, "Action")
		assert_eq(globals.player.damage, 5)

	func test_choice_shout_succeed():
		# We're upgrading all cards as well to test that received card is also upgraded
		for c in globals.player.deck.cards:
			c.upgrade(c.upgrade_options[0])
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		nce._testing_rng = 31
		activate_secondary_choice_by_key("shout")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_added")
		var removed_cards_signal = get_signal_parameters(globals.player.deck, "card_removed")
		var added_cards_signal = get_signal_parameters(globals.player.deck, "card_added")
		if removed_cards_signal.size() == 0 or added_cards_signal.size() == 0:
			return
		var removed_card: CardEntry = removed_cards_signal[0]
		var added_card: CardEntry = added_cards_signal[0]
		assert_eq(removed_card.properties.Type, "Control")
		assert_eq(added_card.properties.Type, "Control")
		assert_has(added_card.properties, "_is_upgrade")
		assert_eq(globals.player.damage, 0)

	func test_choice_shout_fail():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		nce._testing_rng = 30
		activate_secondary_choice_by_key("shout")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		# warning-ignore:return_value_discarded
		var selection_deck = assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_added")
		var removed_cards_signal = get_signal_parameters(globals.player.deck, "card_removed")
		var added_cards_signal = get_signal_parameters(globals.player.deck, "card_added")
		if removed_cards_signal.size() == 0 or added_cards_signal.size() == 0:
			return
		var removed_card: CardEntry = removed_cards_signal[0]
		var added_card: CardEntry = added_cards_signal[0]
		assert_eq(removed_card.properties.Type, "Control")
		assert_eq(added_card.properties.Type, "Control")
		assert_eq(globals.player.damage, 7)

	func test_choice_hang_succeed():
		watch_signals(globals.player.deck)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		nce._testing_rng = 51
		activate_secondary_choice_by_key("hang")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		assert_signal_not_emitted(globals.player.deck, "card_removed")
		assert_signal_emitted(globals.player.deck, "card_added")
		var added_cards_signal = get_signal_parameters(globals.player.deck, "card_added")
		if not added_cards_signal:
			return
		var added_card: CardEntry = added_cards_signal[0]
		assert_eq(added_card.card_name, "Chasm")
		assert_eq(globals.player.health, 100)

	func test_choice_hang_fail():
		watch_signals(globals.player.deck)
		nce._testing_rng = 50
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		activate_secondary_choice_by_key("hang")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		assert_signal_not_emitted(globals.player.deck, "card_removed")
		assert_signal_not_emitted(globals.player.deck, "card_added")
		assert_eq(globals.player.health, 96)


class TestBlanket:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = load("res://src/dreamscape/Run/NCE/Act2/Blanket.gd")

	func test_choice_sleep():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("sleep")
		yield(yield_to(journal, "selection_deck_spawned", 0.2), YIELD)
		var selection_deck := assert_selection_deck_spawned()
		if not selection_deck:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_added")
		assert_signal_emitted(globals.player.deck, "card_duplicated")
		assert_signal_emitted(globals.player.deck, "card_entry_modified")

	func test_choice_throw():
		begin_nce_with_choices(nce)
		watch_signals(globals.player.deck)
		watch_signals(globals.player.pathos)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
# warning-ignore:return_value_discarded
		activate_secondary_choice_by_key("throw")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
		assert_signal_not_emitted(globals.player.deck, "card_added")
		assert_signal_not_emitted(globals.player.deck, "card_duplicated")
		assert_signal_not_emitted(globals.player.deck, "card_entry_modified")
		assert_signal_emitted(globals.player.pathos, "pathos_repressed")

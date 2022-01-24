extends "res://tests/HUT_Journal_NCETestClass.gd"

class TestBannersOfRuin:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act2/BannersOfRuin.gd")

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
		assert_eq(globals.player.health, 100, "Player max health not modified")
		assert_deck_signaled("card_added", "card_name", "Hyena")

class TestGriftlands:
	extends  "res://tests/HUT_Journal_NCETestClass.gd"
	func _init() -> void:
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act2/Griftlands.gd")

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
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act2/Griftlands2.gd")

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
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act2/Griftlands3.gd")

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
		testing_nce_script = preload("res://src/dreamscape/Run/NCE/Act2/LoseRandomCurio.gd")

	func test_choice_allow():
		watch_signals(globals.player)
		begin_nce_with_choices(nce)
		yield(yield_to(journal, "secondary_entry_added", 0.2), YIELD)
		watch_signals(globals.player.pathos)
		activate_secondary_choice_by_key("allow")
		yield(yield_to(nce, "encounter_end", 0.2), YIELD)
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

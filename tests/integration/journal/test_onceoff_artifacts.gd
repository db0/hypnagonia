extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"

class TestMaxHealth:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "MaxHealth"
		expected_amount_keys = [
			"health_amount"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		assert_eq(globals.player.health, PLAYER_HEALTH + get_amount("health_amount"),
				"%s increased health" % [artifact.canonical_name])


class TestAccumulateEnemy:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		dreamer_starting_damage = 60
		testing_artifact_name = "AccumulateEnemy"
		expected_amount_keys = [
			"pathos_avg_multiplier",
			"relax_amount"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]
		assert_eq(ptype.repressed, float(ptype.get_progression_average() * get_amount("pathos_avg_multiplier")),
				"%s increased repressed pathos" % [artifact.canonical_name])
		assert_eq(globals.player.damage, dreamer_starting_damage - get_amount("relax_amount"))



class TestAccumulateRest:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateRest"
		expected_amount_keys = [
			"pathos_avg_multiplier"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.rest]
		assert_eq(ptype.repressed, float(ptype.get_progression_average() * get_amount("pathos_avg_multiplier")),
				"%s increased repressed pathos" % [artifact.canonical_name])


class TestAccumulateNCE:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateNCE"
		expected_amount_keys = [
			"pathos_avg_multiplier",
			"anxiety_amount"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]
		assert_eq(ptype.repressed, float(ptype.get_progression_average() * get_amount("pathos_avg_multiplier")),
				"%s increased repressed pathos" % [artifact.canonical_name])
		assert_eq(globals.player.health, PLAYER_HEALTH + get_amount("anxiety_amount"))

class TestAccumulateShop:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateShop"
		expected_amount_keys = [
			"pathos_avg_multiplier"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.shop]
		assert_eq(ptype.repressed, float(ptype.get_progression_average() * get_amount("pathos_avg_multiplier")),
				"%s increased repressed pathos" % [artifact.canonical_name])

class TestAccumulateElite:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateElite"
		expected_amount_keys = [
			"pathos_avg_multiplier",
			"anxiety_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]
		assert_eq(ptype.repressed, float(ptype.get_progression_average() * get_amount("pathos_avg_multiplier")),
				"%s increased repressed pathos" % [artifact.canonical_name])
		assert_eq(globals.player.health, PLAYER_HEALTH + get_amount("anxiety_amount"))

class TestAccumulateArtifact:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateArtifact"
		expected_amount_keys = [
			"pathos_avg_multiplier"
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]
		assert_eq(ptype.repressed, float(ptype.get_progression_average() * get_amount("pathos_avg_multiplier")),
				"%s increased repressed pathos" % [artifact.canonical_name])

class TestBossDraft:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "BossDraft"
		expected_amount_keys = [
			"draft_amount",
			"progress_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var new_choice = journal.entries_list.get_node("CustomDraft")
		assert_not_null(new_choice, "Custom choice added to journal")
		watch_signals(globals.player.deck)
		if new_choice:
			assert_eq(new_choice.draft_nodes.size(), get_amount("draft_amount"))
			new_choice._execute_custom_entry()
			yield(yield_for(0.3), YIELD)
			var nested_choices_scene = new_choice.secondary_choices.get_child(0)
			assert_not_null(nested_choices_scene, "artifact nested choices added")
			if not nested_choices_scene:
				return
			assert_eq(nested_choices_scene.secondary_choices_container.get_child_count(),
					Aspects.ARCHETYPES.size(),
					"Correct Amount of Aspect Draft choices exist")
			nested_choices_scene._on_choice_pressed(nested_choices_scene.secondary_choices_container.get_child(0), Terms.CARD_GROUP_TERMS.class)
			yield(yield_for(0.3), YIELD)
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
			if card_entry:
				assert_eq(card_entry.upgrade_progress,  get_amount("progress_amount"),
						"Drafted card at max upgrades")

class TestFreeCard:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"

	func test_artifact_results():
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		watch_signals(globals.player.deck)
		# warning-ignore:return_value_discarded
		setup_test_artifacts([ArtifactDefinitions.FreeCard.canonical_name])
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_eq(card_entry.properties.Cost,  0,
				"Card modified to have zero cost")
		assert_gt(card_entry.printed_properties.Cost,  0,
				"Selected card had originally more than 0 cost")

	func test_when_no_valid_selection():
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		for c in globals.player.deck.cards:
			c.modify_property("Cost",0, false)
		watch_signals(globals.player.deck)
		# warning-ignore:return_value_discarded
		setup_test_artifacts([ArtifactDefinitions.FreeCard.canonical_name])
		assert_signal_not_emitted(globals.player.deck, "card_entry_modified")

class TestAddAlphaTag:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.AddAlphaTag.canonical_name

	func test_artifact_results():
		if not assert_has_amounts():
			return
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1)
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
		watch_signals(globals.player.deck)
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.properties.Tags,  Terms.GENERIC_TAGS.alpha.name,
				"Card modified to have alpha tag")
		assert_does_not_have(card_entry.printed_properties.Tags,  Terms.GENERIC_TAGS.alpha.name,
				"Selected card had originally no alpha tag")


class TestIncreaseRandomDamage:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"

	func test_artifact_results():
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		watch_signals(globals.player.deck)
		# warning-ignore:return_value_discarded
		setup_test_artifacts([ArtifactDefinitions.IncreaseRandomDamage.canonical_name])
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.printed_properties, "_amounts")
		if not card_entry.printed_properties.has("_amounts"):
			return
		assert_has(card_entry.printed_properties._amounts, "damage_amount")
		if not card_entry.printed_properties._amounts.has("damage_amount"):
			return
		assert_eq(card_entry.properties._amounts.damage_amount,  card_entry.printed_properties._amounts.damage_amount + 1,
				"Card damage increased by 1")


class TestIncreaseRandomDefence:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"

	func test_artifact_results():
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		watch_signals(globals.player.deck)
		# warning-ignore:return_value_discarded
		setup_test_artifacts([ArtifactDefinitions.IncreaseRandomDefence.canonical_name])
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.printed_properties, "_amounts")
		if not card_entry.printed_properties.has("_amounts"):
			return
		assert_has(card_entry.printed_properties._amounts, "defence_amount")
		if not card_entry.printed_properties._amounts.has("defence_amount"):
			return
		assert_eq(card_entry.properties._amounts.defence_amount,  card_entry.printed_properties._amounts.defence_amount + 1,
				"Card damage increased by 1")



class TestIncreaseConfusionStacks:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_rng_ndex"] = 2
		testing_artifact_name = ArtifactDefinitions.IncreaseConfusionStacks.canonical_name
		test_card_names = [
			"A Strange Gaida",
		]

	func test_effect_stacks2():
		if not assert_has_amounts():
			return
#		cfc.game_rng_seed = CFUtils.generate_random_seed()
#		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1)
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
		watch_signals(globals.player.deck)
		assert_eq(selection_deck._deck_preview_grid.get_children().size(), 3)
		if selection_deck._deck_preview_grid.get_children().size() < 3:
			return
		selection_deck._deck_preview_grid.get_children()[2].select_card()
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.printed_properties.Tags,  Terms.ACTIVE_EFFECTS.disempower.name,
				"Selected card always had the disempower tag")
		assert_has(card_entry.printed_properties, "_amounts")
		if not card_entry.printed_properties.has("_amounts"):
			return
		assert_has(card_entry.printed_properties._amounts, "effect_stacks")
		if not card_entry.printed_properties._amounts.has("effect_stacks"):
			return
		assert_has(card_entry.printed_properties._amounts, "effect_stacks2")
		if not card_entry.printed_properties._amounts.has("effect_stacks2"):
			return
		assert_eq(card_entry.properties._amounts.effect_stacks,  card_entry.printed_properties._amounts.effect_stacks + 1,
				"effect_stacks increased by 1")
		assert_eq(card_entry.properties._amounts.effect_stacks2,  card_entry.printed_properties._amounts.effect_stacks2,
				"effect_stacks2 not modified")


class TestIncreaseImmersionGain:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.IncreaseImmersionGain.canonical_name
		test_card_names = [
			"Inner Justice",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1)
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
		watch_signals(globals.player.deck)
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.printed_properties.Tags,  Terms.GENERIC_TAGS.purpose.name,
				"Selected card always had the immersion tag")
		assert_has(card_entry.printed_properties, "_amounts")
		if not card_entry.printed_properties.has("_amounts"):
			return
		assert_has(card_entry.printed_properties._amounts, "immersion_amount")
		if not card_entry.printed_properties._amounts.has("immersion_amount"):
			return
		assert_eq(card_entry.properties._amounts.immersion_amount,  card_entry.printed_properties._amounts.immersion_amount + 1,
				"immersion_amount increased by 1")

class TestIncreasePoisonStacks:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_rng_ndex"] = 2
		testing_artifact_name = ArtifactDefinitions.IncreasePoisonStacks.canonical_name
		test_card_names = [
			"Confident Slap",
			"Laugh at Danger",
		]

	func test_artifact():
		if not assert_has_amounts():
			return
#		cfc.game_rng_seed = CFUtils.generate_random_seed()
#		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1)
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
		watch_signals(globals.player.deck)
		assert_eq(selection_deck._deck_preview_grid.get_children().size(), 1)
		if selection_deck._deck_preview_grid.get_children().size() < 1:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.printed_properties.Tags,  Terms.ACTIVE_EFFECTS.poison.name,
				"Selected card always had the poison tag")
		assert_has(card_entry.printed_properties, "_amounts")
		if not card_entry.printed_properties.has("_amounts"):
			return
		assert_has(card_entry.printed_properties._amounts, "effect_stacks")
		if not card_entry.printed_properties._amounts.has("effect_stacks"):
			return
		assert_eq(card_entry.properties._amounts.effect_stacks,  card_entry.printed_properties._amounts.effect_stacks + 1,
				"effect_stacks increased by 1")

class TestIncreaseBufferStacks:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_rng_ndex"] = 2
		testing_artifact_name = ArtifactDefinitions.IncreaseBufferStacks.canonical_name
		test_card_names = [
			"The Whippy-Flippy",
			"Eureka",
		]

	func test_artifact():
		if not assert_has_amounts():
			return
#		cfc.game_rng_seed = CFUtils.generate_random_seed()
#		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1)
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
		watch_signals(globals.player.deck)
		assert_eq(selection_deck._deck_preview_grid.get_children().size(), 1)
		if selection_deck._deck_preview_grid.get_children().size() < 1:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.printed_properties.Tags,  Terms.ACTIVE_EFFECTS.buffer.name,
				"Selected card always had the buffer tag")
		assert_has(card_entry.printed_properties, "_amounts")
		if not card_entry.printed_properties.has("_amounts"):
			return
		assert_has(card_entry.printed_properties._amounts, "effect_stacks")
		if not card_entry.printed_properties._amounts.has("effect_stacks"):
			return
		assert_has(card_entry.printed_properties._amounts, "effect_stacks2")
		if not card_entry.printed_properties._amounts.has("effect_stacks2"):
			return
		assert_has(card_entry.printed_properties._amounts, "effect_stacks3")
		if not card_entry.printed_properties._amounts.has("effect_stacks3"):
			return
		assert_eq(card_entry.properties._amounts.effect_stacks,  card_entry.printed_properties._amounts.effect_stacks + 1,
				"effect_stacks increased by 1")
		assert_eq(card_entry.properties._amounts.effect_stacks2,  card_entry.printed_properties._amounts.effect_stacks2,
				"effect_stacks2 not modified")
		assert_eq(card_entry.properties._amounts.effect_stacks3,  card_entry.printed_properties._amounts.effect_stacks3,
				"effect_stacks3 not modified")


class TestDecreaseExertStacks:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		globals.test_flags["test_rng_ndex"] = 2
		testing_artifact_name = ArtifactDefinitions.DecreaseExertStacks.canonical_name
		test_card_names = [
			"That too, shall pass",
		]

	func test_artifact():
		if not assert_has_amounts():
			return
#		cfc.game_rng_seed = CFUtils.generate_random_seed()
#		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		var selection_decks =  cfc.get_tree().get_nodes_in_group("selection_decks")
		assert_eq(selection_decks.size(), 1)
		if selection_decks.size() == 0:
			return
		var selection_deck : SelectionDeck = selection_decks[0]
		watch_signals(globals.player.deck)
		assert_eq(selection_deck._deck_preview_grid.get_children().size(), 2)
		if selection_deck._deck_preview_grid.get_children().size() < 1:
			return
		selection_deck._deck_preview_grid.get_children()[0].select_card()
		assert_signal_emitted(globals.player.deck, "card_entry_modified")
		var signal_details = get_signal_parameters(globals.player.deck, "card_entry_modified")
		if not signal_details or signal_details.size() == 0:
			return
		var card_entry: CardEntry = signal_details[0]
		assert_has(card_entry.printed_properties.Tags,  Terms.GENERIC_TAGS.exert.name,
				"Selected card always had the exert tag")
		assert_has(card_entry.printed_properties, "_amounts")
		if not card_entry.printed_properties.has("_amounts"):
			return
		assert_has(card_entry.printed_properties._amounts, "exert_amount")
		if not card_entry.printed_properties._amounts.has("exert_amount"):
			return
		assert_eq(card_entry.properties._amounts.exert_amount,  card_entry.printed_properties._amounts.exert_amount - 2,
				"exert_amount increased by 1")


class TestMoreRestMasteries:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.MoreRestMasteries.canonical_name
		expected_amount_keys = [
			"masteries_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.rest]
		assert_ne(ptype.masteries_when_chosen, get_amount("masteries_amount"))


class TestMoreArtifactMasteries:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.MoreArtifactMasteries.canonical_name
		expected_amount_keys = [
			"masteries_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]
		assert_eq(ptype.masteries_when_chosen, get_amount("masteries_amount"))


class TestMoreShopMasteries:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.MoreShopMasteries.canonical_name
		expected_amount_keys = [
			"masteries_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.shop]
		assert_eq(ptype.masteries_when_chosen, get_amount("masteries_amount"))


class TestMoreEliteMasteries:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.MoreEliteMasteries.canonical_name
		expected_amount_keys = [
			"masteries_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]
		assert_eq(ptype.masteries_when_chosen, 8 + get_amount("masteries_amount"))


class TestMoreNCEMasteries:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.MoreNCEMasteries.canonical_name
		expected_amount_keys = [
			"masteries_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]
		assert_eq(ptype.masteries_when_chosen, get_amount("masteries_amount"))


class TestMoreEnemyMasteries:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.MoreEnemyMasteries.canonical_name
		expected_amount_keys = [
			"masteries_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		var ptype : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]
		assert_eq(ptype.masteries_when_chosen, 3 + get_amount("masteries_amount"))


class TestCostlyUpgrades:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = ArtifactDefinitions.CostlyUpgrades.canonical_name
		expected_amount_keys = [
			"masteries_modifier",
			"immersion_amount",
		]

	func test_artifact_results():
		if not assert_has_amounts():
			return
		for p in globals.player.pathos.pathi.values():
			var ptype : PathosType = p
			assert_eq(ptype.masteries_modifiers, 0.7)


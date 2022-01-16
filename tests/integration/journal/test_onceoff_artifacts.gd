extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"

class TestMaxHealth:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "MaxHealth"
		expected_amount_keys = [
			"health_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.health, PLAYER_HEALTH + get_amount("health_amount"),
				"%s increased health" % [artifact.canonical_name])


class TestAccumulateEnemy:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateEnemy"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.enemy], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])


class TestAccumulateRest:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateRest"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.rest], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])


class TestAccumulateNCE:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateNCE"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.nce], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])


class TestAccumulateShop:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateShop"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.shop], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])

class TestAccumulateElite:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateElite"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.elite], float(get_amount("pathos_amount")),
				"%s increased repressed pathos" % [artifact.canonical_name])

class TestAccumulateArtifact:
	extends "res://tests/HUT_Journal_ArtifactsTestClass.gd"
	func _init() -> void:
		testing_artifact_name = "AccumulateArtifact"
		expected_amount_keys = [
			"pathos_amount"
		]

	func test_artifact_results():
		assert_has_amounts()
		assert_eq(globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.artifact], float(get_amount("pathos_amount")),
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
		assert_has_amounts()
		var new_choice = journal.entries_list.get_node("Artifact_BossDraft")
		assert_not_null(new_choice, "Custom choice added to journal")
		watch_signals(globals.player.deck)
		gut.p(globals.player.deck)
		if new_choice:
			assert_eq(new_choice.draft_nodes.size(), get_amount("draft_amount"))
			new_choice._execute_custom_entry()
			yield(yield_for(0.3), YIELD)
			var nested_choices_scene = new_choice.secondary_choices.get_child(0)
			assert_not_null(nested_choices_scene, "artifact nested choices added")
			assert_eq(nested_choices_scene.secondary_choices_container.get_child_count(),
					Aspects.ARCHETYPES.size(),
					"Correct Amount of Aspect Draft choices exist")
			nested_choices_scene._on_choice_pressed(nested_choices_scene.secondary_choices_container.get_child(0), Terms.CARD_GROUP_TERMS.class)
			yield(yield_for(0.3), YIELD)
			var draft_node : CardDraft = new_choice.draft_nodes[0].get_child(0)
			gut.p(draft_node)
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

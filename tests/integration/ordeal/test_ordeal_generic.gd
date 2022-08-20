extends "res://tests/HUTCommon_Ordeal.gd"

class TestInit:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func _init() -> void:
		globals.test_flags["no_refill"] = false
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["disable_board_background"] = false

	func test_init():
		assert_is(board._background.texture, ImageTexture, "Random Background loaded")
		assert_false(board._board_cover.visible, "Board Cover Invisible")
		assert_false(board.end_turn.disabled, "End Turn Button Enabled")
		assert_eq(counters.get_counter("immersion"), 3, "Dreamer starts with 3 immersion")
		assert_eq(discard.get_card_count(), 0, "Empty discard")
		assert_eq(hand.get_card_count(), 5, "Hand is filled at start")
		assert_eq(deck.get_card_count(), 7, "Deck at expected amount")
		assert_eq(forgotten.get_card_count(), 0, "Nothing automatically forgotten")
		assert_eq(dreamer.damage, 0, "Dreamer doesn't start with damage automatically somehow")
		assert_eq(test_torment.damage, tdamage(0),"Torment doesn't start with damage automatically somehow")
		assert_eq(turn.current_turn, turn.Turns.PLAYER_TURN, "Turn starts on player's")
		assert_eq(get_tree().get_nodes_in_group("CombatEntities").size(), 2, "All Entities Added to Groups")
		assert_eq(get_tree().get_nodes_in_group("EnemyEntities").size(), 1, "All Torments added to Groups")
		assert_eq(get_tree().get_nodes_in_group("PlayerEntities").size(), 1, "Dreamer added to Groups")
		assert_connected(dreamer, board, "entity_killed", "_dreamer_died")
		assert_connected(cfc, board, "cache_cleared", "spool_recalc_predictions")
		assert_connected(dreamer, player_info.health_icon, "entity_damaged", "_on_player_health_changed")
		assert_connected(dreamer, player_info.health_icon, "entity_healed", "_on_player_health_changed")
		assert_connected(dreamer, player_info.health_icon, "entity_health_modified", "_on_player_health_changed")
		for turn_signal in turn.ALL_SIGNALS:
			assert_connected(scripting_bus, board, turn_signal, "_on_" + turn_signal)
		for obj in [counters, hand]:
			for turn_signal in turn.PLAYER_SIGNALS:
				# warning-ignore:return_value_discarded
				assert_connected(scripting_bus, obj,  turn_signal, "_on_" + turn_signal)


class TestGeneric:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func _init() -> void:
		globals.test_flags["disable_starting_artifacts"] = true

	func test_win():
		watch_signals(board)
		dreamer.damage = 50
		dreamer.health = 70
		board.complete_battle()
		assert_true(board.battle_ended)
		assert_signal_emit_count(EventBus, "battle_ended", 1)
		assert_eq(globals.player.damage, 50, "Player damage synced back to globals")
		assert_eq(globals.player.health, 70, "Player health synced back to globals")

	func test_lose():
		watch_signals(board)
		board.game_over()
		assert_true(board.battle_ended)
		assert_signal_emit_count(EventBus, "game_over", 1)

class TestRounds:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func _init() -> void:
		globals.test_flags["no_refill"] = false
		globals.test_flags["test_initial_hand"] = true
		globals.test_flags["no_end_turn_delay"] = false
		torments_amount = 3

	func test_new_turn():
		watch_signals(turn)
		watch_signals(hand)
		dreamer.defence = 30
		test_torment.defence = 30
		for t in test_torments:
			watch_signals(t)
		counters.mod_counter("immersion",5)
		turn.call_deferred("end_player_turn")
		yield(yield_to(hand, "hand_refilled", 1), YIELD)
		assert_true(board.end_turn.disabled, "End Turn Button Enabled")
		assert_signal_emitted(hand, "hand_emptied")
		assert_signal_emitted(hand, "hand_refilled")
		assert_eq(test_torment.defence, 0, "Torment Defense clears up at start of turn")
		yield(yield_to(scripting_bus, "player_turn_started", 3), YIELD)
		assert_eq(dreamer.defence, 0, "Dreamer Defense clears up at start of turn")
		assert_eq(counters.get_counter("immersion"), 3, "Dreamer starts each turn with 3 immersion")
		assert_false(board.end_turn.disabled, "End Turn Button Enabled")
		assert_eq(discard.get_card_count(), 5, "All unused cards are discarded")
		assert_eq(hand.get_card_count(), 5, "Hand is refilled")
		assert_eq(deck.get_card_count(), 2, "Cards taken from deck")
		assert_eq(forgotten.get_card_count(), 0, "Nothing automatically forgotten")
		for turn_signal in turn.ALL_SIGNALS:
			assert_signal_emitted(turn, turn_signal, "All turn signals emited")
		assert_eq(turn.current_turn, turn.Turns.PLAYER_TURN, "Turn returns on player's")
		for t in test_torments:
			assert_signal_emit_count(t, "started_activation", 1)	
			assert_signal_emit_count(t, "finished_activation", 1)	


class TestTurnEventRecording:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	var alpha1: CardEntry
	var alpha2: CardEntry
	var omega1: CardEntry

	func _init() -> void:
		test_card_names = [
			"Confidence",
			"Confidence",
			"Terror",
			"Butterfly",
			"Nothing to Fear",
		]

	func test_event_recording():
		pending("Fix event recording tests")
		return
		for c in cards:
			c.properties.Cost = 0
		cards[1].properties.Tags.append(Terms.ACTIVE_EFFECTS.disempower.name)
		cards[1].properties.Tags.append(Terms.ACTIVE_EFFECTS.empower.name)
		cards[0].properties.Tags.append(Terms.GENERIC_TAGS.insomnia.name)
		cards[0].properties.Tags.append(Terms.GENERIC_TAGS.chain.name)
		var sceng
		for exec_card in cards:
			sceng = execute_with_yield(exec_card)
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		yield(yield_for(0.2), YIELD)
		var first_turn_event_count = {
			"Chain":1,
			"Clarity":1,
			"Concentration_played":1,
			"Confusion":1,
			"Control_played":2,
			"Focus":1,
			"Immersion":1,
			"Insomnia":1,
			"Perturbation_played":1,
			"Risky":1,
			"Slumber":1,
			"Understanding_played":1,
			"cards_played":5,
			"new_turn":1,
		}
		assert_eq_deep(turn.turn_event_count, first_turn_event_count)
		assert_eq_deep(turn.encounter_event_count, first_turn_event_count)

		turn.call_deferred("end_player_turn")
		yield(yield_to(hand, "hand_refilled", 3), YIELD)
		for index in [0,1]:
			sceng = execute_with_yield(cards[index])
			if sceng is GDScriptFunctionState and sceng.is_valid():
				sceng = yield(sceng, "completed")
		yield(yield_for(0.2), YIELD)
		var second_turn_event_count =  {
			"Chain":1,
			"Clarity":1,
			"Confusion":1,
			"Control_played":2,
			"Insomnia":1,
			"cards_played":2,
			"deck_shuffled":4,
			"new_turn":1,
		}
		var second_turn_encounter_events = first_turn_event_count.duplicate()
		for key in second_turn_event_count:
			second_turn_encounter_events[key] = second_turn_encounter_events.get(key,0) + second_turn_event_count[key]
		assert_eq_deep(turn.turn_event_count, second_turn_event_count)
		assert_eq_deep(turn.encounter_event_count, second_turn_encounter_events)


class TestTorments:
	extends "res://tests/HUT_Ordeal_GenericTestClass.gd"

	func _init() -> void:
		torments_amount = 4


	func test_adding_new_torments():
		watch_signals(board)
		var new_torment = board.spawn_enemy(GUT_TORMENT)
		assert_signal_emit_count(board,"enemy_spawned", 1)
		assert_connected(new_torment, board, "finished_activation", "_on_finished_enemy_activation")
		assert_connected(new_torment, board, "entity_killed", "_enemy_died")
		assert_eq(get_tree().get_nodes_in_group("EnemyEntities").size(), 5, "New Torment Added")
		new_torment = board.spawn_enemy(GUT_TORMENT)
		assert_signal_emit_count(board,"enemy_spawned", 1)
		assert_null(new_torment, "Concurrent Torments cannot exceed 5")
		assert_eq(get_tree().get_nodes_in_group("EnemyEntities").size(), 5, "New Torment Added")

	func test_torment_overcome():
		watch_signals(board)
		var intents_to_test = [
			{
				"intent_scripts": ["Perplex:10"],
				"reshuffle": true,
			},
		]
		for t in test_torments:
			t.call_deferred("die")
			yield(yield_for(0.2), YIELD)
		yield(yield_to(EventBus,"battle_ended", 2.1), YIELD)
		assert_signal_emit_count(EventBus, "battle_ended", 1)

	func test_overcome_during_own_turn():
		watch_signals(board)
		var intents_to_test = [
			{
				"intent_scripts": ["Perplex:10"],
				"reshuffle": true,
			},
		]
		for i in range(test_torments.size()):
				watch_signals(test_torments[i])
				test_torments[i].intents.replace_intents(intents_to_test)
				test_torments[i].intents.refresh_intents()
				if i == 1:
					spawn_effect(test_torments[i], Terms.ACTIVE_EFFECTS.poison.name, 200)
				if i in [0,3]:
					test_torments[i].health = 34
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.thorns.name, 15)
		turn.call_deferred("end_player_turn")
		yield(yield_to(scripting_bus, "player_turn_started", 3), YIELD)
		assert_eq(turn.current_turn, turn.Turns.PLAYER_TURN, "Turn back to the player")
		assert_eq(counters.get_counter("immersion"), 3, "Dreamer starts with 3 immersion")
		assert_false(board.end_turn.disabled, "End Turn Button Enabled")

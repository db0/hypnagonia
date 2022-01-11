extends "res://tests/HUT_TormentEffectsTestClass.gd"

class TestAdvantage:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.advantage.name
	var dmg = cfc.card_definitions["Interpretation"]["_amounts"]["damage_amount"]
	var modified_dmg = dmg * 2

	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 2,
			}
		]

	func test_advantage_general():
		var sceng = card.execute_scripts()
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible, "Damage amount should  be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_dmg), "Card damage should be doubled")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg, "Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1)

	func test_multiple_advantage_from_card():
		spawn_effect(dreamer, effect, 1, '')
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg, "Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2)

	func test_advantage_X():
		card.scripts = {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"needs_subject": true,
						"amount": dmg,
						"x_modifier": '0',
						"x_operation": "multiply",
						"tags": ["Attack", "Card"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						},],
					},
				],
			},
		}
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + (modified_dmg * 3),
				"Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1)

	func test_advantage_multi():
		var new_torment = board.spawn_enemy(GUT_TORMENT)
		new_torment.damage = 30
		test_torments.append(new_torment)
		card.scripts = {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "boardseek",
						"needs_subject": true,
						"subject_count": "all",
						"amount": dmg,
						"tags": ["Attack", "Card"],
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						},],
					},
				],
			},
		}
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for torment in test_torments:
			assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg,
					"Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1)


class TestBuffer:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.buffer.name
	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 4,
			}
		]


	func test_buffer_general():
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"Dreamer should have already used %s stacks" % [effect])
		assert_eq(counters.counters.immersion, 7,
				"Dreamer's energy increased")
		assert_eq(cfc.NMAP.board.turn.turn_event_count.get("buffer_immersion_gained"), 1)
		assert_eq(cfc.NMAP.board.turn.turn_event_count.get("immersion_increased",0), 0)
		assert_eq(cfc.NMAP.board.turn.encounter_event_count.get("immersion_increased",0), 0)

	func test_buffer_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.drain.name, 2,  '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.drain.name])


class TestEmpower:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.empower.name
	var dmg = cfc.card_definitions["Interpretation"]["_amounts"]["damage_amount"]
	var modified_dmg = int(round(dmg * 1.25))
	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 4,
			}
		]


	func test_empower_general():
		var sceng = card.execute_scripts()
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible,
					"Damage amount should  be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_dmg),
					"Card damage should be increased by 25%")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg,
				"Torment should increased damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 4,
				effect + " stacks don't reduce on use")

	func test_empower_end_turn():
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks should reduce" % [effect])

	func test_empower_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.disempower.name, 2,  '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.disempower.name])

class TestFortify:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.fortify.name
	var amount := 3
	func _init() -> void:
		test_card_names = [
			"Confidence",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]


	func test_fortify_general():
		dreamer.defence = 30
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), int(floor(amount / 2.0)),
				"Dreamer should have used half %s stacks" % [effect])
		assert_eq(dreamer.defence, 30,
				"Dreamer defence not reduced")


	func test_fortify_end_turn():
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1,
				"Dreamer should have used half %s stacks" % [effect])
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"Dreamer should have used half %s stacks to go to 0" % [effect])


class TestImpervious:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.impervious.name
	var amount := 3
	var modified_dmg = cfc.card_definitions["Interpretation"]["_amounts"]["damage_amount"]
	func _init() -> void:
		torments_amount = 3
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]


	func test_impervious_general():
		var sceng = card.execute_scripts()
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible, "Damage amount should be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_dmg), "Card damage should not be affected")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg, "Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks not modified by own attacks" % [effect])
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"Dreamer should have used all %s stacks" % [effect])

	func test_impervious_and_dots():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.poison.name, 5, '')
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.burn.name, 5, '')
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 10,
				"%s doesn't stop DoTs" % [effect])

	func test_impervious_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:3","Stress:3","Stress:3"],
				"reshuffle": true,
			},
		]
		for torment in test_torments:
			torment.intents.replace_intents(intents_to_test)
			torment.intents.refresh_intents()
		cfc.flush_cache()
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		assert_eq(test_torments.size(), 3)
		for index in range(test_torments.size()):
			var intents = test_torments[index].intents.get_children()
			for iindex in range(intents.size()):
				if index == 0:
					assert_eq(intents[iindex].signifier_amount.text, '0', "Stress intent hitting %s should be 0" % [effect])
				else:
					assert_eq(intents[iindex].signifier_amount.text, '3', "Stress intent should be 3")
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 18,
				"%s prevented stress" % [effect])

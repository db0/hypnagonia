extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"

# For checking
#yield(yield_for(5.1), YIELD)


class TestDrain:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.drain.name
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

	func test_drain_general():
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"Dreamer should have already used %s stacks" % [effect])
		assert_eq(counters.counters.immersion, 1,
				"Dreamer's energy decreased")

	func test_drain_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.buffer.name, 4,  '')
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.buffer.name])
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.buffer.name), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.buffer.name])


class TestDisempower:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.disempower.name
	var modified_dmg = int(round(DMG * 0.75))
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


	func test_disempower_general():
		var sceng = card.execute_scripts()
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible,
					"Damage amount should  be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_dmg),
					"Card damage should be decreased by 25%")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg,
				"Torment should decreased damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 4,
				effect + " stacks don't reduce on use")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks should reduce" % [effect])

	func test_disempower_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.empower.name, 2,  '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.empower.name])


class TestPoison:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.poison.name
	func _init() -> void:
		torments_amount = 2
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 4,
			}
		]

	func test_poison_general():
		dreamer.defence = 10
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks decreased by 1" % [effect])
		assert_eq(dreamer.damage, 4,
				"%s did damage through defence" % [effect])

	func test_poison_on_torments():
		spawn_effect(test_torment, effect, 12, '')
		spawn_effect(test_torments[0], effect, 12, '')
		test_torment.health = 10
		test_torment.defence = 10
		test_torments[0].defence = 30
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		if is_instance_valid(test_torment):
			assert_true(test_torment.is_dead, "test torment died from %s" % [effect])
		assert_eq(test_torments[0].damage, starting_torment_dgm + 12,
				"%s did damage to torment through defence" % [effect])
		assert_eq(dreamer.damage, 4, "Dreamer not take stress damage because torment died")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), 11,
				"%s stacks decreased by 1" % [effect])

	func test_poison_not_deadly():
		dreamer.damage = 60
		spawn_effect(dreamer, effect, 100, '')
		watch_signals(globals.player.pathos)
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, dreamer.health - 1,
				"%s left the dreamer at 1 HP" % [effect])
		assert_signal_emitted(globals.player.pathos, "released_pathos_lost")


class TestBurn:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.burn.name
	func _init() -> void:
		torments_amount = 2
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 14,
			}
		]

	func test_burn_general():
		dreamer.defence = 10
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 13,
				"%s stacks decreased by 1" % [effect])
		assert_eq(dreamer.damage, 4,
				"defence blocked %s" % [effect])

	func test_burn_on_torments():
		spawn_effect(test_torment, effect, 12, '')
		spawn_effect(test_torments[0], effect, 12, '')
		test_torment.health = 40
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:6"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		if is_instance_valid(test_torment):
			assert_true(test_torment.is_dead, "test torment died from %s" % [effect])
		assert_eq(test_torments[0].damage, starting_torment_dgm + 12,
				"%s did damage to torment through defence" % [effect])
		assert_eq(dreamer.damage, 20, "Dreamer takes stress damage because torment died after intents")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), 11,
				"%s stacks decreased by 1" % [effect])
		yield(yield_for(3), YIELD)


class TestVulnerable:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.vulnerable.name
	var modified_def = int(round(DEF * 0.75))
	func _init() -> void:
		test_card_names = [
			"Confidence",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 5,
				"tags": ['Delayed'],
			}
		]


	func test_vulnerable_general():
		# We're testing it delayed to make sure the delayed is removed as well
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		card._start_dragging(Vector2(card.global_position))
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		assert_eq(dreamer.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in dreamer.incoming.get_children():
			assert_true(prediction.signifier_amount.visible,
					"Defence amount should be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_def),
					"Card defence should be decreased by 25%")
		yield(target_entity(card, test_torment), "completed")
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.defence, modified_def,
				"Dreamer should get decreased defence")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 4,
				effect + " stacks don't reduce on use")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks should reduce" % [effect])

	func test_vulnerable_and_intents():
		spawn_effect(test_torment, effect, 1, '')
		var intents_to_test = [
			{
				"intent_scripts": ["Perplex:5","Perplex:8"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		cfc.flush_cache()
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		var intents = test_torment.intents.get_children()
		for iindex in range(intents.size()):
			if iindex == 0:
				assert_eq(intents[iindex].signifier_amount.text, str(int(round(5*0.75))), "Perplex intent with %s should be decreated" % [effect])
			else:
				assert_eq(intents[iindex].signifier_amount.text, str(int(round(8*0.75))), "Perplex intent with %s should be decreated" % [effect])
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.defence, int(round(5*0.75)) + int(round(8*0.75)),
				"%s decreated perplexity" % [effect])

class TestMarked:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.marked.name
	var amount := 3
	var modified_dmg := int(round(DMG * 1.5))
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


	func test_marked_general():
		var sceng = card.execute_scripts()
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible, "Damage amount should be visible")
			assert_eq(prediction.signifier_amount.text, str(DMG), "Card damage should not be affected")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + DMG, "Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks not modified by own attacks" % [effect])
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2,
				"Dreamer should have used all 1 stack %s" % [effect])

	func test_marked_on_multiple_torments():
		card.scripts = MULTI_ATTACK_SCRIPT
		spawn_effect(test_torments[0], effect, 2, '')
#		drag_card(card,card.global_position)
		card._start_dragging(Vector2(0,0))
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		for index in range(test_torments.size()):
			var predictions = test_torments[index].incoming.get_children()
			for iindex in range(predictions.size()):
				if index == 0:
					assert_eq(predictions[iindex].signifier_amount.text, str(modified_dmg), "Card DMG hitting %s should be +50%%" % [effect])
				else:
					assert_eq(predictions[iindex].signifier_amount.text, str(DMG), "Card DMG should be normal")
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for index in range(test_torments.size()):
			if index == 0:
				assert_eq(test_torments[index].damage, starting_torment_dgm + modified_dmg, "Torment should take +50% damage")
			else:
				assert_eq(test_torments[index].damage, starting_torment_dgm + DMG, "Torment should take normal damage")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), 2,
				"%s stacks not modified by card attack" % [effect])

	func test_marked_and_dots():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.poison.name, 5, '')
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.burn.name, 5, '')
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 10,
				"%s doesn't increase DoTs" % [effect])

	func test_marked_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:4","Stress:4","Stress:4"],
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
			for intent in intents:
				assert_eq(intent.signifier_amount.text, '6', "All Stress intents should be hitting +50%")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 18*3,
				"%s increased stress" % [effect])

	func test_marked_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.impervious.name, 2,  '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.impervious.name])

class TestDelighted:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.delighted.name
	var amount := 3
	func _init() -> void:
		torments_amount = 3
		test_card_names = [
			"Confidence",
			"Nothing to Fear",
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]

	func test_delighted_general():
		assert_eq(cards[2].check_play_costs(), CFConst.CostsState.IMPOSSIBLE)
		assert_eq(cards[0].check_play_costs(), CFConst.CostsState.OK)
		assert_eq(cards[1].check_play_costs(), CFConst.CostsState.OK)

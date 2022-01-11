extends "res://tests/HUT_TormentEffectsTestClass.gd"

# For checking
#yield(yield_for(5.1), YIELD)

class TestAdvantage:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.advantage.name
	var modified_dmg = DMG * 2

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
		card.scripts = X_ATTACK_SCRIPT
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
		card.scripts = MULTI_ATTACK_SCRIPT
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for torment in test_torments:
			assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg,
					"Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1)

	func test_advantage_and_intents():
		spawn_effect(test_torment, effect, 2, '')
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:3","Stress:3","Stress:3"],
				"reshuffle": true,
			},
		]
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		cfc.flush_cache()
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		var intents = test_torment.intents.get_children()
		# Advantage doubles all stress in a single intent turn
		for intent in intents:
			assert_eq(intent.signifier_amount.text, '6', "%s Stress intent hitting should be doubled" % [effect])
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 18,
				"%s doubled stress" % [effect])
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), 1)

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
	var modified_dmg = int(round(DMG * 1.25))
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
	var modified_dmg = DMG
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

	func test_impervious_on_multiple_torments():
		card.scripts = MULTI_ATTACK_SCRIPT
		spawn_effect(test_torments[0], effect, 2, '')
#		drag_card(card,card.global_position)
		card._start_dragging(Vector2(0,0))
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		for index in range(test_torments.size()):
			var predictions = test_torments[index].incoming.get_children()
			for iindex in range(predictions.size()):
				if index == 0:
					assert_eq(predictions[iindex].signifier_amount.text, '0', "Card DMG hitting %s should be 0" % [effect])
				else:
					assert_eq(predictions[iindex].signifier_amount.text, '6', "Card DMG should be %s" % [modified_dmg])
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for index in range(test_torments.size()):
			if index == 0:
				assert_eq(test_torments[index].damage, starting_torment_dgm, "Torment should not take damage")
			else:
				assert_eq(test_torments[index].damage, starting_torment_dgm + modified_dmg, "Torment should take damage")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), 1,
				"%s stacks modified by card attack" % [effect])

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


class TestThorns:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.thorns.name
	var amount := 6
	# We expect to lose 1 thorns due to turn start
	var modified_dmg = DMG
	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]


	func test_thorns_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:3","Stress:3","Stress:3"],
				"reshuffle": true,
			},
		]
		var expected_thorns_dmg = 6 * intents_to_test[0]["intent_scripts"].size()
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(test_torment.damage, starting_torment_dgm + expected_thorns_dmg,
				"%s caused %s stress" % [effect, expected_thorns_dmg])
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 5,
				"%s stacks modified by turn end" % [effect])


	func test_thorns_and_single_interpret():
		spawn_effect(test_torment, effect, 6, '')
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, amount, "Dreamer should take damage from %s" % [effect])

	func test_thorns_and_X_interpret():
		card.scripts = X_ATTACK_SCRIPT
		spawn_effect(test_torment, effect, 6, '')
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, amount, "Dreamer should take only a single damage from %s" % [effect])

	func test_thorns_and_repeat_interpret():
		card.scripts = REPEAT_ATTACK_SCRIPT
		spawn_effect(test_torment, effect, 6, '')
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.damage, 6*REPEAT, "Dreamer should take multiple repeat damage from %s" % [effect])
		
class TestArmor:
	extends "res://tests/HUT_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.armor.name
	var amount := 8
	var torment_amount := 4
	# We expect to lose 1 thorns due to turn start
	var modified_dmg = DMG
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


	func test_armor_and_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:9","Stress:9"],
				"reshuffle": true,
			},
		]
		for torment in test_torments:
			torment.intents.replace_intents(intents_to_test)
			torment.intents.refresh_intents()
		var expected_armor_dmg = 0
		var remaining_armor = amount
		for iter in range(intents_to_test[0]["intent_scripts"].size() * torments_amount):
			remaining_armor = amount - iter
			if remaining_armor < 0: remaining_armor = 0
			expected_armor_dmg += 9 - remaining_armor

		cfc.flush_cache()
		yield(yield_to(cfc, "cache_cleared", 0.2), YIELD)
		remaining_armor = amount
		var iter := 0
		for torment in test_torments:
			var intents = torment.intents.get_children()
			for intent in intents:
				remaining_armor = amount - iter
				iter += 1
				if remaining_armor < 0: 
					remaining_armor = 0
				assert_eq(intent.signifier_amount.text, str(9 - remaining_armor), "Intent DMG hitting %s should be reduced by %s" % [effect, remaining_armor])
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, expected_armor_dmg,
				"%s prevented %s stress" % [effect, expected_armor_dmg])
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1,
				"%s stacks modified by turn end" % [effect])
				
	func test_armor_on_multiple_torments():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:9","Stress:9"],
				"reshuffle": true,
			},
		]
		for torment in test_torments:
			torment.intents.replace_intents(intents_to_test)
			torment.intents.refresh_intents()		
		card.scripts = MULTI_ATTACK_SCRIPT
		spawn_effect(test_torments[2], effect, 4, '')
		spawn_effect(test_torments[1], effect, 3, '')
		spawn_effect(test_torments[0], effect, 2, '')
#		drag_card(card,card.global_position)
		card._start_dragging(Vector2(0,0))
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		for index in range(test_torments.size()):
			var predictions = test_torments[index].incoming.get_children()
			for prediction in predictions:
				assert_eq(prediction.signifier_amount.text, str(DMG - index - 2), "Card DMG should be %s" % [DMG - index - 2])
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for index in range(test_torments.size()):
			assert_eq(test_torments[index].damage, starting_torment_dgm + DMG - index - 2, "Torment should take less damage due to %s" % [effect])
			assert_eq(test_torments[index].active_effects.get_effect_stacks(effect), index + 1,
					"%s stacks modified by card attack" % [effect])

	func test_armor_and_single_interpret():
		spawn_effect(test_torment, effect, torment_amount, '')
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + DMG - torment_amount, "Test Torment should take reduced damage from %s" % [effect])

	func test_armor_and_repeat_interpret():
		card.scripts = REPEAT_ATTACK_SCRIPT
		spawn_effect(test_torment, effect, torment_amount, '')
		var sceng = card.execute_scripts()
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		var predictions = test_torment.incoming.get_children()
		for iindex in range(predictions.size()):
			assert_eq(predictions[iindex].signifier_amount.text, str(DMG - torment_amount + iindex), "Card DMG should be %s" % [DMG - iindex + 6])		
#		yield(yield_for(5.1), YIELD)
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		var total_dmg_done = 0
		var remaining_armor = torment_amount
		for repeat in range(REPEAT):
			remaining_armor = torment_amount - repeat
			total_dmg_done += DMG - remaining_armor
		assert_eq(test_torment.damage, starting_torment_dgm + total_dmg_done, "Test Torment should take reduced damage from %s" % [effect])
#		yield(yield_for(5.1), YIELD)

	func test_armor_and_defence():
		spawn_effect(test_torment, effect, torment_amount, '')
		test_torment.defence = 10
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.defence, 10 - DMG + torment_amount, "Defence taken after %s" % [effect])

	func test_armor_and_impervious():
		spawn_effect(test_torment, effect, torment_amount, '')
		spawn_effect(test_torment, Terms.ACTIVE_EFFECTS.impervious.name, 1, '')
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		var sceng = snipexecute(card, test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), torment_amount - 1,
				"%s activates even at 0 dmg due to %s" % [Terms.ACTIVE_EFFECTS.impervious.name, effect])
				
	func test_armor_and_dots():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.poison.name, 5, '')
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.burn.name, 5, '')
		cfc.NMAP.board.turn.end_player_turn()
		yield(yield_to(board.turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 10,
				"%s doesn't stop DoTs" % [effect])

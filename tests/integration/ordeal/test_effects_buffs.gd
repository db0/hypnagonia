extends "res://tests/HUT_Ordeal_TormentEffectsTestClass.gd"

# For checking
#yield(yield_for(5.1), YIELD)

class TestAdvantage:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
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
		if not card.targeting_arrow.is_targeting:
			yield(yield_to(card.targeting_arrow, "initiated_targeting", 1), YIELD)
		assert_eq(test_torment.incoming.get_child_count(), 1,
				"Torment should have 1 intents displayed")
		for prediction in test_torment.incoming.get_children():
			assert_true(prediction.signifier_amount.visible, "Damage amount should  be visible")
			assert_eq(prediction.signifier_amount.text, str(modified_dmg), "Card damage should be doubled")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, starting_torment_dgm + modified_dmg, "Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1, effect + " stacks should be reduced")

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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 18,
				"%s doubled stress" % [effect])
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), 1)


class TestBuffer:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.buffer.name
	func _init() -> void:
		test_card_names = [
			"Interpretation",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": 4,
				"tags": ['Delayed'],
			}
		]


	func test_buffer_general():
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 4,
				"Dreamer should not have used delayed %s stacks" % [effect])
		assert_eq(counters.counters.immersion, 3,
				"Dreamer's energy not increased")
		assert_eq(cfc.NMAP.board.turn.turn_event_count.get("buffer_immersion_gained", 0), 0, "Not increased due to Delayed")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"Dreamer should have already used %s stacks" % [effect])
		assert_eq(counters.counters.immersion, 7,
				"Dreamer's energy increased")
		assert_eq(cfc.NMAP.board.turn.turn_event_count.get("buffer_immersion_gained", 0), 1)
		assert_eq(cfc.NMAP.board.turn.turn_event_count.get("immersion_increased",0), 0, "Buffer immersion does not count for mid-turn immersion gain")
		assert_eq(cfc.NMAP.board.turn.encounter_event_count.get("immersion_increased",0), 0, "Buffer immersion does not count for mid-turn immersion gain")

	func test_buffer_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.drain.name, 2,  '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.drain.name])

class TestEmpower:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 3,
				"%s stacks should reduce" % [effect])

	func test_empower_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.disempower.name, 2,  '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.disempower.name])

class TestFortify:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), int(floor(amount / 2.0)),
				"Dreamer should have used half %s stacks" % [effect])
		assert_eq(dreamer.defence, 30,
				"Dreamer defence not reduced")


	func test_fortify_end_turn():
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 1,
				"Dreamer should have used half %s stacks" % [effect])
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 0,
				"Dreamer should have used half %s stacks to go to 0" % [effect])


class TestImpervious:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.impervious.name
	var amount := 4
	var reduction_per_stack = 0.25
	var reduction = 0.25
	var modified_dmg = int(round(DMG * reduction))
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
			assert_eq(prediction.signifier_amount.text, str(DMG), "Card damage should not be affected")
		yield(target_entity(card, test_torment), "completed")
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.damage, tdamage(DMG), "Torment should take damage")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 4,
				"%s stacks not modified by own attacks" % [effect])
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), amount / 2,
				"Stacks %s should be halved" % [effect])

	func test_impervious_on_multiple_torments():
		card.scripts = MULTI_ATTACK_SCRIPT
		spawn_effect(test_torments[0], effect, 2, '')
		var modified_dmg = int(round(DMG * 0.5))
#		drag_card(card,card.global_position)
		card._start_dragging(Vector2(0,0))
		yield(yield_to(get_tree(), "idle_frame", 0.1), YIELD)
		for index in range(test_torments.size()):
			var predictions = test_torments[index].incoming.get_children()
			for iindex in range(predictions.size()):
				if index == 0:
					assert_eq(predictions[iindex].signifier_amount.text, str(modified_dmg), "Card DMG hitting %s should be reduced" % [effect])
				else:
					assert_eq(predictions[iindex].signifier_amount.text, str(DMG), "Card DMG should be %s" % [modified_dmg])
		var sceng = card.execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		for index in range(test_torments.size()):
			if index == 0:
				assert_eq(test_torments[index].damage, tdamage(modified_dmg), "Torment should not take reduced damage")
			else:
				assert_eq(test_torments[index].damage, tdamage(DMG), "Torment should take damage")
		assert_eq(test_torments[0].active_effects.get_effect_stacks(effect), 1,
				"%s stacks modified by card attack" % [effect])

	func test_impervious_and_dots():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.poison.name, 5, '')
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.burn.name, 5, '')
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 10,
				"%s doesn't stop DoTs" % [effect])

	func test_impervious_and_intents():
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
			for iindex in range(intents.size()):
				if index == 0:
					if iindex == 0:
						assert_eq(intents[iindex].signifier_amount.text, str(4 * reduction), "Stress intent hitting %s should be decreased" % [effect])
					if iindex == 1:
						assert_eq(intents[iindex].signifier_amount.text, str(4 * reduction ), "Stress intent hitting %s should be decreased" % [effect])
					if iindex == 2:
						assert_eq(intents[iindex].signifier_amount.text, str(4 * (reduction + reduction_per_stack) ), "Stress intent hitting %s should be decreased" % [effect])
				elif index == 1:
					if iindex == 0:
						assert_eq(intents[iindex].signifier_amount.text, str(4 * (reduction + reduction_per_stack * 2) ), "Stress intent hitting %s should be decreased" % [effect])
					if iindex == 1:
						assert_eq(intents[iindex].signifier_amount.text, '4', "Stress intent should be 4")
					if iindex == 2:
						assert_eq(intents[iindex].signifier_amount.text, '4', "Stress intent should be 4")
				else:
					assert_eq(intents[iindex].signifier_amount.text, '4', "Stress intent should be 4")
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 4 * 5 + 3 + 2 + 1 + 1,
				"%s prevented stress" % [effect])

	func test_advantage_opposite():
		spawn_effect(dreamer, Terms.ACTIVE_EFFECTS.marked.name, 2,  '')
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), 2,
				"%s counters %s" % [effect, Terms.ACTIVE_EFFECTS.marked.name])


class TestThorns:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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

	func test_thorns_interrupting_intents():
		var intents_to_test = [
			{
				"intent_scripts": ["Stress:3","Stress:3","Stress:3","Debuff:3:disempower"],
				"reshuffle": true,
			},
		]
		test_torment.health = 35
		test_torment.intents.replace_intents(intents_to_test)
		test_torment.intents.refresh_intents()
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_true(test_torment.is_dead, "Test torment dies due to thorns")
		assert_eq(dreamer.active_effects.get_effect_stacks(Terms.ACTIVE_EFFECTS.disempower.name), 0,
				"Dreamer did not receive %s stacks due to torment intents interrupted" % [Terms.ACTIVE_EFFECTS.disempower.name])
		assert_eq(dreamer.damage, 6, "Dreamer damage interrupted due to torment dying to %s" % [effect])
		
class TestArmor:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
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
		card._start_dragging(Vector2(card.global_position))
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
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.damage, 10,
				"%s doesn't stop DoTs" % [effect])


class TestProtection:
	extends "res://tests/HUT_Ordeal_DreamerEffectsTestClass.gd"
	var effect: String = Terms.ACTIVE_EFFECTS.protection.name
	var amount := 7
	func _init() -> void:
		test_card_names = [
			"Butterfly",
			"Butterfly",
			"Butterfly",
			"Butterfly",
		]
		effects_to_play = [
			{
				"name": effect,
				"amount": amount,
			}
		]


	func test_protection_debuffs():
		var test_effect = Terms.ACTIVE_EFFECTS.poison.name
		var test_effect2 = Terms.ACTIVE_EFFECTS.quicken.name
		cards[0].scripts = get_dreamer_effect_script(test_effect, 5)
		cards[1].scripts = get_dreamer_effect_script(test_effect2, -5)
		var sceng = cards[0].execute_scripts()
		sceng = cards[1].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), amount - 2,
				"Dreamer should have used 1 %s stack per debuff" % [effect])
		assert_eq(dreamer.active_effects.get_effect_stacks(test_effect), 0,
				"%s blocked all %s stacks" % [effect, test_effect])
		assert_eq(dreamer.active_effects.get_effect_stacks(test_effect2), 0,
				"%s blocked all %s stacks" % [effect, test_effect2])

	func test_protection_dreamer_only_debuffs():
		var test_effect = Terms.ACTIVE_EFFECTS.drain.name
		var test_effect2 = Terms.ACTIVE_EFFECTS.delighted.name
		cards[0].scripts = get_dreamer_effect_script(test_effect, 5)
		cards[1].scripts = get_dreamer_effect_script(test_effect2, 2)
		var sceng = cards[0].execute_scripts()
		sceng = cards[1].execute_scripts()
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), amount - 2,
				"Dreamer should have used 1 %s stack per debuff" % [effect])
		assert_eq(dreamer.active_effects.get_effect_stacks(test_effect), 0,
				"%s blocked all %s stacks" % [effect, test_effect])
		assert_eq(dreamer.active_effects.get_effect_stacks(test_effect2), 0,
				"%s blocked all %s stacks" % [effect, test_effect2])

	func test_protection_dreamer_only_debuffs_on_torment():
		spawn_effect(test_torment, effect, amount, '')
		var test_effect = Terms.ACTIVE_EFFECTS.drain.name
		var test_effect2 = Terms.ACTIVE_EFFECTS.strengthen.name
		var test_effect3 = Terms.ACTIVE_EFFECTS.disempower.name
		cards[0].scripts = get_torment_effect_script(test_effect, 5)
		cards[1].scripts = get_torment_effect_script(test_effect2, 2)
		cards[2].scripts = get_torment_effect_script(test_effect3, 2)
		var sceng = snipexecute(cards[0], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = snipexecute(cards[1], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		sceng = snipexecute(cards[2], test_torment)
		if sceng is GDScriptFunctionState:
			sceng = yield(sceng, "completed")
		assert_eq(test_torment.active_effects.get_effect_stacks(effect), amount - 1,
				"Torment should have used 1 %s stack per debuff" % [effect])
		assert_eq(test_torment.active_effects.get_effect_stacks(test_effect3), 0,
				"%s blocked all %s stacks" % [effect, test_effect3])
		assert_eq(test_torment.active_effects.get_effect_stacks(test_effect2), 2,
				"%s didn't block %s stacks" % [effect, test_effect2])
		assert_eq(test_torment.active_effects.get_effect_stacks(test_effect), 5,
				"%s didn't block %s stacks" % [effect, test_effect])


	func test_fortify_end_turn():
		turn.call_deferred("end_player_turn")
		yield(yield_to(turn, "player_turn_started",3 ), YIELD)
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), amount,
				"%s stacks do not reduce at turn end" % [effect])
		turn.call_deferred("end_player_turn")

	func test_protection_non_debuffs():
		var test_effects := [
			Terms.ACTIVE_EFFECTS.strengthen.name,
			Terms.ACTIVE_EFFECTS.laugh_at_danger.name,
			Terms.ACTIVE_EFFECTS.creative_block.name,
			Terms.ACTIVE_EFFECTS.empower.name,
		]
		var sceng
		for index in range(test_effects.size()):
			cards[index].scripts = get_dreamer_effect_script(test_effects[index], 5)
			sceng = cards[index].execute_scripts()
			if sceng is GDScriptFunctionState:
				sceng = yield(sceng, "completed")
		assert_eq(dreamer.active_effects.get_effect_stacks(effect), amount,
				"Dreamer should not have used any %s stacks" % [effect])
		for index in range(test_effects.size()):
			assert_eq(dreamer.active_effects.get_effect_stacks(test_effects[index]), 5,
					"%s did not block any %s stacks" % [effect, test_effects[index]])

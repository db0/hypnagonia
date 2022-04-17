extends "res://tests/UTCommon.gd"


class TestActiveEffects:
	extends "res://tests/UTCommon.gd"
	var AE = load("res://src/dreamscape/CombatElements/ActiveEffects.tscn")

	func test_scene():
		var doubled_scene = double(AE).instance()
		assert_has_method(doubled_scene, 'mod_effect')
		assert_has_method(doubled_scene, 'get_all_effects')
		assert_has_method(doubled_scene, 'get_all_effects_nodes')
		assert_has_method(doubled_scene, 'get_ordered_effects')
		assert_has_method(doubled_scene, 'get_effect')
		assert_has_method(doubled_scene, 'get_effect_stacks')
		assert_has_method(doubled_scene, 'get_effect_with_most_stacks')
		assert_has_method(doubled_scene, 'get_effect_with_least_stacks')
		assert_has_method(doubled_scene, 'get_random_effect')
		assert_has_method(doubled_scene, 'snapshot_effect')
		assert_eq(doubled_scene.OPPOSITES[Terms.ACTIVE_EFFECTS.empower.name], Terms.ACTIVE_EFFECTS.disempower.name)
		assert_eq(doubled_scene.OPPOSITES[Terms.ACTIVE_EFFECTS.disempower.name], Terms.ACTIVE_EFFECTS.empower.name)
		assert_eq(doubled_scene.OPPOSITES[Terms.ACTIVE_EFFECTS.buffer.name], Terms.ACTIVE_EFFECTS.drain.name)
		assert_eq(doubled_scene.OPPOSITES[Terms.ACTIVE_EFFECTS.drain.name], Terms.ACTIVE_EFFECTS.buffer.name)
		assert_eq(doubled_scene.OPPOSITES[Terms.ACTIVE_EFFECTS.marked.name], Terms.ACTIVE_EFFECTS.impervious.name)
		assert_eq(doubled_scene.OPPOSITES[Terms.ACTIVE_EFFECTS.impervious.name], Terms.ACTIVE_EFFECTS.marked.name)
		assert_has_signal(doubled_scene, "effect_added")


class TestMethods:
	extends "res://tests/UTCommon.gd"
	var CE = load("res://src/dreamscape/CombatElements/CombatEntity.tscn")
	var ce: CombatEntity
	var ae: ActiveEffects
	var test_effect = Terms.ACTIVE_EFFECTS.rebalance.name

	func before_each() -> void:
		ce = add_child_autofree(CE.instance())
		ce.entity_type = Terms.PLAYER
		watch_signals(ce)
		ae = ce.active_effects
		watch_signals(ae)

	func test_mod_effect_signals() -> void:
		assert_ret_changed(ae.mod_effect(test_effect))
		assert_signal_emit_count(ae, "effect_added", 1)
		assert_signal_emit_count(ce, "effect_modified", 1)
		var signal_details = get_signal_parameters(ae, "effect_added")
		if not signal_details:
			return
		var effect : CombatEffect = signal_details[0]
		var expected_signal_params := {
			"effect_name": test_effect,
			"effect_node": effect,
			SP.TRIGGER_PREV_COUNT: 0,
			SP.TRIGGER_NEW_COUNT: 1,
			"tags": ["Manual"]
		}
		assert_signal_emitted_with_parameters(ce, "effect_modified", [ce,"effect_modified", expected_signal_params])
		assert_eq(ae.get_child_count(), 1)
		assert_eq(ae.get_effect_stacks(test_effect), 1)
		assert_ret_changed(ae.mod_effect(test_effect))
		expected_signal_params[SP.TRIGGER_PREV_COUNT] = 1
		expected_signal_params[SP.TRIGGER_NEW_COUNT] = 2
		assert_signal_emitted_with_parameters(ce, "effect_modified", [ce,"effect_modified", expected_signal_params])
		assert_signal_emit_count(ce, "effect_modified", 2)
		assert_eq(ae.get_effect_stacks(test_effect), 2)
		assert_eq(ae.get_child_count(), 1)
		assert_ret_changed(ae.mod_effect(test_effect, -2))
		assert_signal_emit_count(ce, "effect_modified", 3)
		expected_signal_params[SP.TRIGGER_PREV_COUNT] = 2
		expected_signal_params[SP.TRIGGER_NEW_COUNT] = 0
		assert_signal_emitted_with_parameters(ce, "effect_modified", [ce,"effect_modified", expected_signal_params])
		yield(get_tree(), "idle_frame")
		assert_eq(ae.get_child_count(), 0)
		assert_eq(ae.get_effect_stacks(test_effect), 0)


	func test_effect_properties() -> void:
		assert_ret_changed(ae.mod_effect(test_effect))
		assert_signal_emit_count(ae, "effect_added", 1)
		var signal_details = get_signal_parameters(ae, "effect_added")
		if not signal_details:
			return
		var effect : CombatEffect = signal_details[0]
		assert_eq(effect.name, test_effect)
		assert_eq(effect.owning_entity, ce)
		assert_eq(effect.upgrade, '')
		assert_eq(effect.entity_type, Terms.PLAYER)
		var effect_definition = Terms.get_effect_entry(test_effect)
		assert_eq_deep(effect.effect_definition, effect_definition)
		assert_eq(effect.self_decreasing, Terms.SELF_DECREASE.FALSE)
		assert_eq(effect.decrease_type, Terms.DECREASE_TYPE.REDUCE)
		assert_eq(effect.priority, Terms.ALTERANT_PRIORITY.ADD)
		assert_eq(effect.stacks, 1)


	func test_get_all_effects_nodes():
		assert_ret_changed(ae.mod_effect(test_effect))
		assert_signal_emit_count(ae, "effect_added", 1)
		var signal_details = get_signal_parameters(ae, "effect_added")
		if not signal_details:
			return
		var effect1 : CombatEffect = signal_details[0]
		assert_eq(ae.get_all_effects_nodes(), [effect1])
		assert_eq_shallow(ae.get_all_effects(), {test_effect: effect1})
		assert_ret_changed(ae.mod_effect(Terms.ACTIVE_EFFECTS.outrage.name))
		signal_details = get_signal_parameters(ae, "effect_added")
		var effect2 : CombatEffect = signal_details[0]
		assert_eq(ae.get_all_effects_nodes(), [effect1, effect2])
		assert_eq_shallow(ae.get_all_effects(),
			{
				test_effect: effect1,
				Terms.ACTIVE_EFFECTS.outrage.name: effect2,
			}
		)
		assert_ret_changed(ae.mod_effect(Terms.ACTIVE_EFFECTS.fortify.name))
		signal_details = get_signal_parameters(ae, "effect_added")
		var effect3 : CombatEffect = signal_details[0]
		assert_eq(ae.get_all_effects_nodes(), [effect1, effect2, effect3])
		assert_eq_shallow(ae.get_all_effects(),
			{
				test_effect: effect1,
				Terms.ACTIVE_EFFECTS.outrage.name: effect2,
				Terms.ACTIVE_EFFECTS.fortify.name: effect3,
			}
		)

	func test_effect_upgrades() -> void:
		assert_ret_changed(ae.mod_effect(test_effect))
		assert_ret_changed(ae.mod_effect(test_effect, 1, false, false, [], 'GUT'))
		assert_signal_emit_count(ae, "effect_added", 2)
		var signal_details = get_signal_parameters(ae, "effect_added")
		if not signal_details:
			return
		var effect : CombatEffect = signal_details[0]
		assert_eq(effect.stacks, 1)
		assert_eq(effect.name, 'Gut ' + test_effect)
		assert_eq(effect.canonical_name, test_effect)
		assert_eq(effect.get_effect_name(), 'Gut ' + test_effect)
		assert_eq(effect.upgrade, 'GUT')
		assert_ret_changed(ae.mod_effect(test_effect, 1, false, false, [], 'GUT'))
		assert_signal_emit_count(ae, "effect_added", 2)
		assert_eq(effect.stacks, 2)
		assert_eq(ae.get_effect_stacks(test_effect), 1)
		assert_eq(ae.get_effect_stacks('Gut ' + test_effect), 2)

	func test_snapshot_effect_not_existing() -> void:
		ae.snapshot_effect(test_effect, 5, false, [])
		assert_signal_not_emitted(ae, "effect_added")
		assert_eq(ae.get_effect_stacks(test_effect), 5)
		assert_eq(ae.get_child_count(), 0)
		assert_eq_shallow(ae.sceng_snapshot_modifiers, {"Rebalance":5})

	func test_snapshot_effect_existing() -> void:
		# warning-ignore:return_value_discarded
		ae.mod_effect(test_effect)
		ae.snapshot_effect(test_effect, 5, false, [])
		assert_signal_emit_count(ae, "effect_added", 1)
		assert_eq(ae.get_effect_stacks(test_effect), 6)
		assert_eq(ae.get_child_count(), 1)
		assert_eq_shallow(ae.sceng_snapshot_modifiers, {"Rebalance":6})

	func test_effect_with_noscript() -> void:
		# warning-ignore:return_value_discarded
		ae.mod_effect(test_effect)
		assert_signal_emit_count(ae, "effect_added", 1)
		var signal_details = get_signal_parameters(ae, "effect_added")
		if not signal_details:
			return
		var effect : CombatEffect = signal_details[0]
		assert_eq(effect.script, CombatEffect, "Assert no extra script added")


class TestOpposites:
	extends "res://tests/UTCommon.gd"
	var CE = load("res://src/dreamscape/CombatElements/CombatEntity.tscn")
	var ce: CombatEntity
	var ae: ActiveEffects
	var test_effect = Terms.ACTIVE_EFFECTS.empower.name
	var test_opposite = Terms.ACTIVE_EFFECTS.disempower.name

	func before_each() -> void:
		ce = add_child_autofree(CE.instance())
		watch_signals(ce)
		ae = ce.active_effects
		watch_signals(ae)

	func test_mod_effect_opposites_cancelling_each_other() -> void:
		assert_ret_changed(ae.mod_effect(test_effect, 2))
		assert_ret_changed(ae.mod_effect(test_opposite, 2))
		assert_signal_emit_count(ce, "effect_modified", 2)
		yield(get_tree(), "idle_frame")
		assert_eq(ae.get_child_count(), 0)
		assert_eq(ae.get_effect_stacks(test_effect), 0)
		assert_eq(ae.get_effect_stacks(test_opposite), 0)

	func test_mod_effect_opposites_overcoming_existing() -> void:
		assert_ret_changed(ae.mod_effect(test_effect,3))
		assert_ret_changed(ae.mod_effect(test_opposite,6))
		assert_signal_emit_count(ce, "effect_modified", 3)
		yield(get_tree(), "idle_frame")
		assert_eq(ae.get_child_count(), 1)
		assert_eq(ae.get_effect_stacks(test_effect), 0)
		assert_eq(ae.get_effect_stacks(test_opposite), 3)

	func test_mod_effect_opposites_reducing_existing() -> void:
		assert_ret_changed(ae.mod_effect(test_effect,6))
		assert_ret_changed(ae.mod_effect(test_opposite,3))
		assert_signal_emit_count(ce, "effect_modified", 2)
		yield(get_tree(), "idle_frame")
		assert_eq(ae.get_child_count(), 1)
		assert_eq(ae.get_effect_stacks(test_effect), 3)
		assert_eq(ae.get_effect_stacks(test_opposite), 0)

	func test_mod_effect_opposites_set_new() -> void:
		assert_ret_changed(ae.mod_effect(test_effect,6))
		assert_ret_changed(ae.mod_effect(test_opposite,3, true))
		assert_signal_emit_count(ce, "effect_modified", 3)
		yield(get_tree(), "idle_frame")
		assert_eq(ae.get_child_count(), 1)
		assert_eq(ae.get_effect_stacks(test_effect), 0)
		assert_eq(ae.get_effect_stacks(test_opposite), 3)



class TestMultipleEffectsMethods:
	extends "res://tests/UTCommon.gd"
	var CE = load("res://src/dreamscape/CombatElements/CombatEntity.tscn")
	var ce: CombatEntity
	var ae: ActiveEffects
	var test_effect = Terms.ACTIVE_EFFECTS.rebalance.name

	var empower : CombatEffect
	var advantage : CombatEffect
	var armor : CombatEffect
	var protection : CombatEffect
	var strengthen : CombatEffect
	var quicken : CombatEffect
	var nothing_to_fear : CombatEffect
	var test_effect_names := [
		Terms.ACTIVE_EFFECTS.empower.name,
		Terms.ACTIVE_EFFECTS.advantage.name,
		Terms.ACTIVE_EFFECTS.poison.name,
		Terms.ACTIVE_EFFECTS.protection.name,
		Terms.ACTIVE_EFFECTS.strengthen.name,
		Terms.ACTIVE_EFFECTS.quicken.name,
		Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
	]
	var buff_names := [
		Terms.ACTIVE_EFFECTS.empower.name,
		Terms.ACTIVE_EFFECTS.advantage.name,
		Terms.ACTIVE_EFFECTS.protection.name,
		Terms.ACTIVE_EFFECTS.strengthen.name,
	]
	var debuff_names := [
		Terms.ACTIVE_EFFECTS.poison.name,
		Terms.ACTIVE_EFFECTS.quicken.name,
	]
	var concentration_names := [
		Terms.ACTIVE_EFFECTS.nothing_to_fear.name,
	]
	var effect_nodes := []

	func before_each() -> void:
		ce = add_child_autofree(CE.instance())
		ce.entity_type = Terms.PLAYER
		watch_signals(ce)
		ae = ce.active_effects
		watch_signals(ae)

	func after_each() -> void:
		effect_nodes.clear()

	func test_get_all_effects():
		instance_sample_effects()
		assert_eq(ae.get_all_effects().keys(), test_effect_names)

	func test_get_all_effect_nodes():
		instance_sample_effects()
		assert_eq(ae.get_all_effects_nodes(), effect_nodes)

	func test_ordered_effects():
		instance_sample_effects()
		var ordef = ae.get_ordered_effects()
		assert_has(ordef, "adders")
		assert_has(ordef, "multipliers")
		assert_has(ordef, "setters")
		if not ordef.has("adders") or not ordef.has("multipliers") or not ordef.has("setters"):
			return
		assert_eq(ordef.adders.size(), 5)
		assert_eq(ordef.multipliers.size(), 1)
		assert_eq(ordef.setters.size(), 1)

	func test_get_effect_with_most_stacks_any_type():
		instance_sample_effects()
		assert_eq(ae.get_effect_with_most_stacks(), Terms.ACTIVE_EFFECTS.empower.name)

	func test_get_effect_with_most_stacks_buff():
		instance_sample_effects()
		assert_eq(ae.get_effect_with_most_stacks("Buff"), Terms.ACTIVE_EFFECTS.empower.name)

	func test_get_effect_with_most_stacks_concentration():
		instance_sample_effects()
		assert_eq(ae.get_effect_with_most_stacks("Concentration"), Terms.ACTIVE_EFFECTS.nothing_to_fear.name)

	func test_get_effect_with_most_stacks_debuff():
		instance_sample_effects()
		assert_eq(ae.get_effect_with_most_stacks("Debuff"), Terms.ACTIVE_EFFECTS.quicken.name, "Should consider quicken as a debuff")

	func test_get_effect_with_least_stacks():
		instance_sample_effects()
		assert_eq(ae.get_effect_with_least_stacks(), Terms.ACTIVE_EFFECTS.nothing_to_fear.name)

	func test_get_effect_with_least_stacks_buffs():
		instance_sample_effects()
		assert_eq(ae.get_effect_with_least_stacks("Buff"), Terms.ACTIVE_EFFECTS.strengthen.name)

	func test_get_effect_with_least_stacks_debuffs():
		instance_sample_effects()
		assert_eq(ae.get_effect_with_least_stacks("Debuff"), Terms.ACTIVE_EFFECTS.poison.name)

	func test_get_effect_with_least_stacks_concentration():
		instance_sample_effects()
		assert_eq(ae.get_effect_with_least_stacks("Concentration"), Terms.ACTIVE_EFFECTS.nothing_to_fear.name)

	func test_get_random_effect():
		instance_sample_effects()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		assert_has(test_effect_names, ae.get_random_effect())

	func test_get_random_effect_buffs():
		instance_sample_effects()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		assert_has(buff_names, ae.get_random_effect("Buff"))

	func test_get_random_effect_debuffs():
		instance_sample_effects()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		assert_has(debuff_names, ae.get_random_effect("Debuff"))

	func test_get_random_effect_concentration():
		instance_sample_effects()
		cfc.game_rng_seed = CFUtils.generate_random_seed()
		gut.p("Testing Random Seed: " + cfc.game_rng_seed)
		assert_has(concentration_names, ae.get_random_effect("Concentration"))

	func instance_sample_effects() -> void:
# warning-ignore:return_value_discarded
		ae.mod_effect(Terms.ACTIVE_EFFECTS.empower.name,9)
		empower =  get_signal_parameters(ae, "effect_added")[0]
		effect_nodes.append(empower)
# warning-ignore:return_value_discarded
		ae.mod_effect(Terms.ACTIVE_EFFECTS.advantage.name,8)
		advantage=  get_signal_parameters(ae, "effect_added")[0]
		effect_nodes.append(advantage)
# warning-ignore:return_value_discarded
		ae.mod_effect(Terms.ACTIVE_EFFECTS.poison.name,7)
		armor =  get_signal_parameters(ae, "effect_added")[0]
		effect_nodes.append(armor)
# warning-ignore:return_value_discarded
		ae.mod_effect(Terms.ACTIVE_EFFECTS.protection.name,6)
		protection  =  get_signal_parameters(ae, "effect_added")[0]
		effect_nodes.append(protection)
# warning-ignore:return_value_discarded
		ae.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name,5)
		strengthen  =  get_signal_parameters(ae, "effect_added")[0]
		effect_nodes.append(strengthen)
# warning-ignore:return_value_discarded
		ae.mod_effect(Terms.ACTIVE_EFFECTS.quicken.name,-8)
		quicken  =  get_signal_parameters(ae, "effect_added")[0]
		effect_nodes.append(quicken)
# warning-ignore:return_value_discarded
		ae.mod_effect(Terms.ACTIVE_EFFECTS.nothing_to_fear.name,1)
		nothing_to_fear  =  get_signal_parameters(ae, "effect_added")[0]
		effect_nodes.append(nothing_to_fear)


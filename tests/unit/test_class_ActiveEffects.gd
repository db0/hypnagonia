extends "res://tests/UTCommon.gd"


class TestActiveEffects:
	extends "res://tests/UTCommon.gd"
	const AE = preload("res://src/dreamscape/CombatElements/ActiveEffects.tscn")

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
	const CE = preload("res://src/dreamscape/CombatElements/CombatEntity.tscn")
	var ce: CombatEntity
	var ae: ActiveEffects
	var test_effect = Terms.ACTIVE_EFFECTS.rebalance.name

	func before_each() -> void:
		ce = add_child_autofree(CE.instance())
		watch_signals(ce)
		ae = ce.active_effects
		watch_signals(ae)

	func test_mod_effect() -> void:
		assert_ret_changed(ae.mod_effect(test_effect))
		assert_signal_emit_count(ae, "effect_added", 1)

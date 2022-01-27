extends "res://tests/UTCommon.gd"


class TestCombatEntity:
	extends "res://tests/UTCommon.gd"
	const CE = preload("res://src/dreamscape/CombatElements/CombatEntity.tscn")

	func test_scene():
		var doubled_scene = double(CE).instance()
		assert_has_method(doubled_scene, 'setup')
		assert_has_method(doubled_scene, '_set_texture')
		assert_has_method(doubled_scene, 'set_defence')
		assert_has_method(doubled_scene, 'set_damage')
		assert_has_method(doubled_scene, 'set_health')
		assert_has_method(doubled_scene, 'modify_damage')
		assert_has_method(doubled_scene, 'modify_defence')
		assert_has_method(doubled_scene, 'modify_health')
		assert_has_method(doubled_scene, 'get_class')
		assert_has_method(doubled_scene, 'show_predictions')
		assert_has_method(doubled_scene, 'clear_predictions')
		assert_has_method(doubled_scene, '_update_health_label')
		assert_has_method(doubled_scene, 'get_property')
		assert_has_method(doubled_scene, '_on_Defence_mouse_entered')
		assert_has_method(doubled_scene, '_on_Health_mouse_entered')
		assert_has_method(doubled_scene, '_show_description_popup')
		assert_has_method(doubled_scene, '_on_CombatSingifier_mouse_exited')
		assert_has_method(doubled_scene, '_on_Description_mouse_exited')
		assert_has_method(doubled_scene, '_on_Art_mouse_exited')
		assert_has_method(doubled_scene, '_on_Art_mouse_entered')
		assert_has_method(doubled_scene, '_on_player_turn_started')
		assert_has_method(doubled_scene, '_on_player_turn_ended')
		assert_has_method(doubled_scene, '_on_enemy_turn_started')
		assert_has_method(doubled_scene, '_on_enemy_turn_ended')
		assert_setget(CE, 'damage', 'set_damage')
		assert_setget(CE, 'health', 'set_health')
		assert_setget(CE, 'defence', 'set_defence')

class TestHealth:
	extends "res://tests/UTCommon.gd"
	const CE = preload("res://src/dreamscape/CombatElements/CombatEntity.tscn")
	var ce: CombatEntity
	
	func before_each() -> void:
		ce = add_child_autofree(CE.instance())
		ce.health = 100
		watch_signals(ce)

	func test_health_label():
		ce.damage += 30
		assert_eq(ce.health_label.text, '30/100')
		
	func test_die():
		ce.damage += 100
		yield(yield_to(ce, "entity killed", 0.1), YIELD)
		assert_true(ce.is_dead, "entity killed")
		assert_signal_emitted(ce, "entity_killed")
		
	func test_modify_damage():
# warning-ignore:return_value_discarded
		ce.modify_damage(30)
		assert_signal_emitted(ce, "entity_damaged")
		
	func test_attack():
		ce.health = 100
# warning-ignore:return_value_discarded
		ce.modify_damage(30, false, ["Attack"])
		assert_signal_emitted(ce, "entity_damaged")
		assert_signal_emitted(ce, "entity_attacked")

	func test_heal():
# warning-ignore:shadowed_variable
		var ce = add_child_autofree(CE.instance())
		ce.health = 100
		ce.damage = 30
		watch_signals(ce)
		ce.modify_damage(-10)
		assert_signal_emitted(ce, "entity_healed")

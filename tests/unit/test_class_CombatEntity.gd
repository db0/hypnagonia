extends "res://tests/UTCommon.gd"


class TestCombatEntity:
	extends "res://tests/UTCommon.gd"
	const CE = preload("res://src/dreamscape/CombatElements/CombatEntity.tscn")

	func test_double():
		var Doubled = double(CE)
		var doubled_scene = Doubled.instance()
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

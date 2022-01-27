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
		
	func test_get_class():
		var ce = add_child_autofree(CE.instance())
		assert_eq(ce.get_class(),"CombatEntity")

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
		assert_signal_emitted_with_parameters(ce, "entity_killed", [100])

	func test_modify_damage():
		# warning-ignore:return_value_discarded
		assert_ret_changed(ce.modify_damage(30))
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 30, null, ["Manual"]])
		assert_signal_not_emitted(ce, "entity_attacked")
		assert_eq(ce.health_label.text, '30/100')

	func test_modify_damage_0_input():
		# warning-ignore:return_value_discarded
		assert_ret_changed(ce.modify_damage(0, false, ["Attack"]))
		assert_signal_not_emitted(ce, "entity_damaged")
		assert_signal_not_emitted(ce, "entity_healed")
		assert_signal_not_emitted(ce, "entity_killed")
		assert_signal_not_emitted(ce, "entity_attacked")


	func test_modify_damage_attack():
		assert_ret_changed(ce.modify_damage(30, false, ["Attack"]))
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 30, null, ["Attack"]])
		assert_signal_emitted_with_parameters(ce, "entity_attacked", [ce, 30, null, ["Attack"]])

	func test_modify_damage_heal():
		ce.damage = 30
		assert_ret_changed(ce.modify_damage(-10))
		assert_signal_emitted_with_parameters(ce, "entity_healed", [ce, -10, null, ["Manual"]])

	func test_modify_damage_blocked():
		ce.defence = 50
		assert_ret_changed(ce.modify_damage(30, false, ["Blockable"]))
		assert_signal_not_emitted(ce, "entity_damaged")
		assert_signal_emitted_with_parameters(ce, "entity_damage_blocked", [ce, 30, null, ["Blockable"]])

	func test_modify_damage_partially_blocked():
		ce.defence = 20
		assert_ret_changed(ce.modify_damage(30, false, ["Blockable"]))
		assert_signal_emitted_with_parameters(ce, "entity_damage_blocked", [ce, 20, null, ["Blockable"]])
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 10, null, ["Blockable"]])
		assert_signal_not_emitted(ce, "entity_attacked")

	func test_modify_attack_blocked():
		ce.defence = 50
		assert_ret_changed(ce.modify_damage(30, false, ["Attack"]))
		assert_signal_not_emitted(ce, "entity_damaged")
		assert_signal_emitted_with_parameters(ce, "entity_damage_blocked", [ce, 30, null, ["Attack"]])

	func test_modify_attack_partially_blocked():
		ce.defence = 20
		assert_ret_changed(ce.modify_damage(30, false, ["Attack"]))
		assert_signal_emitted_with_parameters(ce, "entity_damage_blocked", [ce, 20, null, ["Attack"]])
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 10, null, ["Attack"]])
		assert_signal_emitted_with_parameters(ce, "entity_attacked", [ce, 30, null, ["Attack"]])

	func test_modify_damage_unblockable_attack():
		ce.defence = 50
		assert_ret_changed(ce.modify_damage(30, false, ["Attack", "Unblockable"]))
		assert_signal_not_emitted(ce, "entity_damage_blocked")
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 30, null, ["Attack", "Unblockable"]])
		assert_signal_emitted_with_parameters(ce, "entity_attacked", [ce, 30, null, ["Attack", "Unblockable"]])

	# Should function as Attack + Unblockable
	func test_modify_bloclable_unblockable_interaction():
		ce.defence = 50
		assert_ret_changed(ce.modify_damage(30, false, ["Blockable", "Unblockable"]))
		assert_signal_not_emitted(ce, "entity_damage_blocked")
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 30, null, ["Blockable", "Unblockable"]])
		assert_signal_not_emitted(ce, "entity_attacked")

	func test_modify_damage_unblockable_damage():
		ce.defence = 50
		assert_ret_changed(ce.modify_damage(30))
		assert_signal_not_emitted(ce, "entity_damage_blocked")
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 30, null, ["Manual"]])

	func test_modify_damage_return_failed():
		ce.damage += 20
		assert_ret_failed(ce.modify_damage(-30, true))
		assert_signal_not_emitted(ce, "entity_damaged")
		assert_signal_not_emitted(ce, "entity_healed")
		assert_signal_not_emitted(ce, "entity_killed")
		assert_signal_not_emitted(ce, "entity_attacked")
		
	func test_modify_damage_on_defence_return_failed():
		ce.defence += 20
		assert_ret_failed(ce.modify_damage(-30, true))
		assert_signal_not_emitted(ce, "entity_damaged")
		assert_signal_not_emitted(ce, "entity_healed")
		assert_signal_not_emitted(ce, "entity_killed")
		assert_signal_not_emitted(ce, "entity_attacked")

	func test_modify_damage_return_ok():
		assert_ret_ok(ce.modify_damage(0, true))
		assert_signal_not_emitted(ce, "entity_damaged")
		assert_signal_not_emitted(ce, "entity_healed")
		assert_signal_not_emitted(ce, "entity_killed")
		assert_signal_not_emitted(ce, "entity_attacked")
		
	func test_die_through_defence():
		ce.defence = 50
		assert_ret_changed(ce.modify_damage(150, false, ["Attack"]))
		yield(yield_to(ce, "entity killed", 0.1), YIELD)
		assert_true(ce.is_dead, "entity killed")
		assert_signal_emitted_with_parameters(ce, "entity_killed", [100])
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 100, null, ["Attack"]])
		assert_signal_emitted_with_parameters(ce, "entity_attacked", [ce, 150, null, ["Attack"]])		
		assert_signal_emitted_with_parameters(ce, "entity_damage_blocked", [ce, 50, null, ["Attack"]])
		
	func test_live_through_defence():
		ce.defence = 100
		assert_ret_changed(ce.modify_damage(150, false, ["Attack"]))
		yield(yield_to(ce, "entity killed", 0.1), YIELD)
		assert_false(ce.is_dead, "entity killed")
		assert_signal_not_emitted(ce, "entity_killed")
		assert_signal_emitted_with_parameters(ce, "entity_damaged", [ce, 50, null, ["Attack"]])
		assert_signal_emitted_with_parameters(ce, "entity_attacked", [ce, 150, null, ["Attack"]])
		assert_signal_emitted_with_parameters(ce, "entity_damage_blocked", [ce, 100, null, ["Attack"]])
		
	func test_modify_defence_positive():
		assert_ret_changed(ce.modify_defence(30, false, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_defence_modified", [ce, 30, null, ["Scripted"]])

	func test_modify_defence_negative():
		ce.defence = 40
		assert_ret_changed(ce.modify_defence(-30, false, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_defence_modified", [ce, -30, null, ["Scripted"]])

	func test_modify_defence_negative_to_0():
		ce.defence = 10
		assert_ret_failed(ce.modify_defence(-30, false, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_defence_modified", [ce, -10, null, ["Scripted"]])

	func test_modify_defence_set_to_mod():
		ce.defence = 40
		assert_ret_changed(ce.modify_defence(60, true, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_defence_modified", [ce, 20, null, ["Scripted"]])

	func test_modify_defence_set_to_mod_negative():
		ce.defence = 40
		assert_ret_changed(ce.modify_defence(20, true, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_defence_modified", [ce, -20, null, ["Scripted"]])

	func test_modify_defence_set_to_mod_negative_to_0():
		ce.defence = 40
		assert_ret_failed(ce.modify_defence(-20, true, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_defence_modified", [ce, -40, null, ["Scripted"]])

	func test_modify_defence_return_ok():
		ce.defence = 40
		assert_ret_ok(ce.modify_defence(40, true, false, ["Scripted"]))
		assert_signal_not_emitted(ce, "entity_defence_modified")

	func test_modify_health_positive():
		assert_ret_changed(ce.modify_health(30, false, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_health_modified", [ce, 30, null, ["Scripted"]])

	func test_modify_health_negative():
		ce.health = 40
		assert_ret_changed(ce.modify_health(-30, false, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_health_modified", [ce, -30, null, ["Scripted"]])

	func test_modify_health_negative_to_0():
		ce.health = 10
		assert_ret_failed(ce.modify_health(-30, false, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_health_modified", [ce, -10, null, ["Scripted"]])

	func test_modify_health_set_to_mod():
		ce.health = 40
		assert_ret_changed(ce.modify_health(60, true, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_health_modified", [ce, 20, null, ["Scripted"]])

	func test_modify_health_set_to_mod_negative():
		ce.health = 40
		assert_ret_changed(ce.modify_health(20, true, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_health_modified", [ce, -20, null, ["Scripted"]])

	func test_modify_health_set_to_mod_negative_to_0():
		ce.health = 40
		assert_ret_failed(ce.modify_health(-20, true, false, ["Scripted"]))
		assert_signal_emitted_with_parameters(ce, "entity_health_modified", [ce, -40, null, ["Scripted"]])

	func test_modify_health_return_ok():
		ce.health = 40
		assert_ret_ok(ce.modify_health(40, true, false, ["Scripted"]))
		assert_signal_not_emitted(ce, "entity_health_modified")


class TestTurnTriggers:
	extends "res://tests/UTCommon.gd"
	const CE = preload("res://src/dreamscape/CombatElements/CombatEntity.tscn")
	var ce: CombatEntity

	func before_each() -> void:
		ce = add_child_autofree(CE.instance())
#		ce = double(CE).instance()

	func test_player_defence_wipe_on_turn_start():
		ce.entity_type = Terms.PLAYER
		ce.defence = 100
		ce._on_player_turn_started(null)
		assert_eq(ce.defence, 0)

	func test_player_stay_with_fortify():
		ce.entity_type = Terms.PLAYER
		ce.defence = 100
		ce.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.fortify.name, 1)
		ce._on_player_turn_started(null)
		assert_eq(ce.defence, 100)

	func test_player_defence_stay_on_enemy_start():
		ce.entity_type = Terms.PLAYER
		ce.defence = 100
		ce._on_enemy_turn_started(null)
		assert_eq(ce.defence, 100)

	func test_enemy_defence_stay_on_turn_start():
		ce.entity_type = Terms.ENEMY
		ce.defence = 100
		ce._on_player_turn_started(null)
		assert_eq(ce.defence, 100)

	func test_enemy_defence_wipe_on_enemy_start():
		ce.entity_type = Terms.ENEMY
		ce.defence = 100
		ce._on_enemy_turn_started(null)
		assert_eq(ce.defence, 0)

	func test_enemy_stay_with_fortify():
		ce.entity_type = Terms.ENEMY
		ce.defence = 100
		ce.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.fortify.name, 1)
		ce._on_enemy_turn_started(null)
		assert_eq(ce.defence, 100)

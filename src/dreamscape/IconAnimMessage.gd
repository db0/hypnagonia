class_name IconAnimMessage
extends Reference

signal payload_executed

var icon: ImageTexture
var start_pos: Vector2
var end_pos: Vector2
var thing: String
var extra_classification
var originator
var target
var tags: Array
var starting_position_node
var executor: ScEngExecutor
var async: bool

func _init(
		_executor: ScEngExecutor,
		_extra_classification := '',
		_async := cfc.game_settings.get('async_icon_animations', false)) -> void:
	executor = _executor
	thing = executor.task_name
	originator = executor.owner
	tags = executor.tags
	starting_position_node = executor.script_task.get_property("starting_position_node")
	extra_classification = _extra_classification
	async = _async
	# For testing, we want to go fast always
	if cfc.is_testing:
		async = true
	_set_icon()
	_set_start_pos()
	_set_end_pos()
	cfc.NMAP.board.icon_anims.effects_queue.append(self)
	if async:
		exec_payload()


func animation_started() -> void:
	if "Intent" in tags and is_instance_valid(starting_position_node):
		starting_position_node.modulate.a = 0


func animation_finished() -> void:
	if not async:
		exec_payload()


# Called when the animation finishes playing
# If an animation is waiting to deploy it's payload, we call it now
func exec_payload() -> void:
	executor.exec()
	emit_signal("payload_executed")




func _set_icon() -> void:
	var texture = "res://icon.png"
	match thing:
		"modify_damage":
			target = executor.combat_entity
			if "Attack" in tags:
				if originator is Card:
					texture = Terms.get_term_value("attack", "icon")
				elif originator is PlayerEntity:
					texture = Terms.get_term_value("attack", "icon")
				elif originator is Artifact:
					texture = Terms.get_term_value("attack", "icon")
				elif originator is EnemyEntity:
					texture = Terms.get_term_value("enemy_attack", "icon")
#			elif "Poison" in tags:
#				texture = Terms.get_term_value("poison", "icon")
#			elif "Burn" in tags:
#				texture = Terms.get_term_value("burn", "icon")
			elif target is EnemyEntity:
				texture = Terms.get_term_value("enemy_health", "icon")
			else:
				texture = Terms.get_term_value("player_health", "icon")
		"assign_defence":
			target = executor.combat_entity
			texture = Terms.get_term_value("defence", "icon")
		"apply_effect":
			target = executor.combat_entity
			texture = Terms.get_term_value(executor.effect_name, "icon")
		"modify_pathos":
			texture = Terms.get_term_value('Pathos', "icon")
		"mod_counter":
			texture = Terms.get_term_value('energy', "icon")
		"modify_health":
			target = executor.combat_entity
			if target is EnemyEntity:
				texture = Terms.get_term_value("enemy_health", "icon")
			else:
				texture = Terms.get_term_value("player_health", "icon")
		"custom_script":
			if originator is EnemyEntity:
				match extra_classification:
					"check_browser_history":
						texture = Terms.get_term_value("defence", "icon")
	if not texture:
		texture = "res://icon.png"
	icon = CFUtils.convert_texture_to_image(texture)


func _set_start_pos() -> void:
	if starting_position_node:
		start_pos = starting_position_node.rect_global_position
	elif originator is DreamCard:
		start_pos = originator.global_position
	elif originator is EnemyEntity:
		match extra_classification:
			_:
				start_pos = originator.art.rect_global_position
	else:
		start_pos = originator.rect_global_position


func _set_end_pos() -> void:
	match thing:
		"modify_damage":
			if extra_classification == "Unblocked":
				end_pos = target.health_bar.rect_global_position + target.health_bar.rect_size / 2
			else:
				end_pos = target.defence_icon.rect_global_position
		"modify_health":
			end_pos = target.health_bar.rect_global_position + target.health_bar.rect_size / 2
		"assign_defence":
			end_pos = target.defence_icon.rect_global_position
		"apply_effect":
			end_pos = target.active_effects.rect_global_position
		"modify_pathos":
			end_pos = cfc.NMAP.board.player_info._pathos_button.rect_global_position
		"mod_counter":
			end_pos = cfc.NMAP.board.counters.rect_global_position
		"custom_script":
			if originator is EnemyEntity:
				match extra_classification:
					"check_browser_history":
						end_pos = originator.health_bar.rect_global_position + originator.health_bar.rect_size / 2
			

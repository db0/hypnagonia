class_name IconAnimMessage
extends Reference

var icon: ImageTexture
var start_pos: Vector2
var end_pos: Vector2
var thing: String
var type
var originator
var target
var tags: Array
var starting_position_node

func _init(_thing: String, _type, _originator, _target, _tags: Array, _starting_position_node = null) -> void:
	thing = _thing
	type = _type
	originator = _originator
	target = _target
	tags = _tags
	starting_position_node = _starting_position_node
	_set_icon()
	_set_start_pos()
	_set_end_pos()
	cfc.NMAP.board.icon_anims.effects_queue.append(self)
	


func _set_icon() -> void:
	var texture = "res://icon.png"
	match thing:
		"modify_damage":
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
			texture = Terms.get_term_value("defence", "icon")
		"apply_effect":
			texture = Terms.get_term_value(type, "icon")
		"modify_pathos":
			texture = Terms.get_term_value('Pathos', "icon")
		"mod_counter":
			texture = Terms.get_term_value('energy', "icon")
		"modify_health":
			if target is EnemyEntity:
				texture = Terms.get_term_value("enemy_health", "icon")
			else:
				texture = Terms.get_term_value("player_health", "icon")
	if not texture:
		texture = "res://icon.png"
	icon = CFUtils.convert_texture_to_image(texture)


func _set_start_pos() -> void:
	if starting_position_node:
		start_pos = starting_position_node.rect_global_position
	elif originator is DreamCard:
		start_pos = originator.global_position
	elif originator is EnemyEntity:
		start_pos = originator.art.rect_global_position
	else:
		start_pos = originator.rect_global_position


func _set_end_pos() -> void:
	if thing == "modify_damage":
		if type == "Unblocked":
			end_pos = target.health_bar.rect_global_position + target.health_bar.rect_size / 2
		else:
			end_pos = target.defence_icon.rect_global_position 
	if thing == "modify_health":
		end_pos = target.health_bar.rect_global_position + target.health_bar.rect_size / 2
	if thing == "assign_defence":
		end_pos = target.defence_icon.rect_global_position 
	if thing == "apply_effect":
		end_pos = target.active_effects.rect_global_position 
	if thing == "modify_pathos":
		end_pos = cfc.NMAP.board.player_info._pathos_button.rect_global_position 
	if thing == "mod_counter":
		end_pos = cfc.NMAP.board.counters.rect_global_position 

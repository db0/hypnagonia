class_name AnimatedEnemy
extends Control

onready var animation_player:= $AnimationPlayer
onready var enemy_polygon = $EnemyPolygon


func act(animation_name: String) -> void:
	if animation_player.has_animation(animation_name):
		animation_player.play(animation_name)
	elif animation_player.has_animation("acting"):
		animation_player.play("acting")


func defeat() -> void:
	if animation_player.has_animation("defeated"):
		animation_player.play("defeated")

func set_highlight(requestedFocus: bool,
		hoverColour = CFConst.HOST_HOVER_COLOUR) -> void:
	enemy_polygon.has_outline = requestedFocus
	enemy_polygon.outLine = hoverColour

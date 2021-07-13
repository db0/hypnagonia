class_name AnimatedEnemy
extends Control

onready var animation_player:= $AnimationPlayer
onready var enemy_polygon = $EnemyPolygon


func act() -> void:
	if animation_player.has_animation("acting"):
		animation_player.play("acting")


func defeat() -> void:
	if animation_player.has_animation("defeated"):
		animation_player.play("defeated")

func set_highlight(requestedFocus: bool,
		hoverColour = CFConst.HOST_HOVER_COLOUR) -> void:
	enemy_polygon.has_outline = requestedFocus
	enemy_polygon.outLine = hoverColour

# This timer constantly runs and checks if there's animations to play
# If there are, they are fired every 0.1 seconds in FIFO order.
extends Timer

var effects_queue: Array
var fast_icon_speed := {
	false: 0.5,
	true: 0.2,
}

func _ready():
	connect("timeout",self,"_next_icon_animation")


# Creates an animation based on the provided ImageTexture and animates it between start and end global positions
func send_icon_to_texturerect(next_anim_msg: IconAnimMessage) -> void:
	var tween := Tween.new()
	# I use TextureRect, as it will resize the icon to the size I need.
	var sprite := TextureRect.new()
	sprite.texture = next_anim_msg.icon
	sprite.rect_min_size = Vector2(32,32)
	sprite.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	sprite.expand = true
	add_child(tween)
	add_child(sprite)
	# warning-ignore:return_value_discarded
	tween.connect("tween_all_completed",self,"_anim_completed", [tween, sprite, next_anim_msg])
	# warning-ignore:return_value_discarded
	var icon_speed = fast_icon_speed[cfc.game_settings.get('fast_icon_speed', false)]
	tween.interpolate_property(
			sprite,"rect_global_position", 
			next_anim_msg.start_pos, 
			next_anim_msg.end_pos, 
			icon_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	# warning-ignore:return_value_discarded
	tween.start()


# Cleans up tween and icon
func _anim_completed(tween: Tween, sprite, next_anim_msg: IconAnimMessage) -> void:
	tween.call_deferred("queue_free")
	sprite.call_deferred("queue_free")
	next_anim_msg.animation_finished()


# Triggers every timer timeout. Extracts the next icon from the message and initiates animation
func _next_icon_animation() -> void:
	if effects_queue.size():
		var next_anim_msg: IconAnimMessage = effects_queue.pop_front()
		next_anim_msg.animation_started()
		send_icon_to_texturerect(next_anim_msg)

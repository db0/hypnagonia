extends ColorRect

signal fade_finished

onready var _tween := $Tween

func fade_to_black() -> void:
	visible = true
	_tween.interpolate_property(self,
			'modulate:a', 0, 1, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()

func fade_from_black() -> void:
	_tween.interpolate_property(self,
			'modulate:a', 1, 0, 1,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()
	yield(_tween, "tween_all_completed")
	self.visible = false


func _on_Tween_tween_all_completed() -> void:
	emit_signal("fade_finished")

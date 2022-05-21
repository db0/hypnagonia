extends ColorRect

const WAIT_MODE = 0.1
onready var _timer  := $Timer

func take_damage() -> void:
	visible = true
	_timer.start(WAIT_MODE)

func _on_Timer_timeout():
	visible = false

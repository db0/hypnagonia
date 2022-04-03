extends DifficultyOption

onready var checkbox := $CheckBox

func _ready() -> void:
	checkbox.pressed = globals.difficulty[difficulty_key]

func _on_CheckBox_toggled(button_pressed: bool) -> void:
	globals.difficulty[difficulty_key] = button_pressed

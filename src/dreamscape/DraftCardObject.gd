extends DBGridCardObject

signal card_selected(option)
const info_panel_scene = preload("res://src/dreamscape/InfoPanel.tscn")

var index : int

func _ready() -> void:
	preview_popup.focus_info.info_panel_scene = info_panel_scene
	preview_popup.focus_info.setup()


func on_gui_input(event) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.get_button_index() == 1:
			emit_signal("card_selected", index)

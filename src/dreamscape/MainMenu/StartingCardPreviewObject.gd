extends DBGridCardObject

const info_panel_scene = preload("res://src/dreamscape/InfoPanel.tscn")


func _ready() -> void:
	preview_popup.focus_info.info_panel_scene = info_panel_scene
	preview_popup.focus_info.setup()


func on_gui_input(event) -> void:
	pass

func add_child(node, _legible_unique_name=false) -> void:
	.add_child(node)
	rect_min_size.y = node._control.rect_min_size.y + 100

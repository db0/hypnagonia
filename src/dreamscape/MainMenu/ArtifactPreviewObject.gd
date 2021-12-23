extends CVGridCardObject

const info_panel_scene = preload("res://src/dreamscape/InfoPanel.tscn")


func _ready() -> void:
	preview_popup.focus_info.info_panel_scene = info_panel_scene
	preview_popup.focus_info.setup()

func on_gui_input(_event) -> void:
	pass

func add_child(node, _legible_unique_name=false) -> void:
	.add_child(node)
	rect_min_size.y = node._control.rect_min_size.y + 100


func _on_GridCardObject_mouse_entered() -> void:
	preview_popup.show_preview_card(display_card.canonical_name)
	preview_popup.preview_card.deck_card_entry = display_card.deck_card_entry
	cfc.ov_utils.populate_info_panels(preview_popup.preview_card,preview_popup.focus_info)

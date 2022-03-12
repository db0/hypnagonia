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
	if preview_popup.has_preview_card():
		preview_popup.show_preview_card(display_card.canonical_name)
	elif "deck_card_entry" in display_card and display_card.deck_card_entry:
		preview_popup.show_preview_card(display_card.deck_card_entry.instance_self(true))
	else:
		preview_popup.show_preview_card(display_card.canonical_name)
	preview_popup.preview_card.deck_card_entry = display_card.deck_card_entry
	cfc.ov_utils.populate_info_panels(preview_popup.preview_card,preview_popup.focus_info)


func _on_StartingCardPreview_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.get_button_index() == 2:
		var upgrade_options = cfc.card_definitions[display_card.canonical_name].get("_upgrades", [])
		var select_return = cfc.ov_utils.select_card(
				upgrade_options, 0, "display", false, cfc.get_tree().get_root())
		if select_return is GDScriptFunctionState: # Still working.
			select_return = yield(select_return, "completed")

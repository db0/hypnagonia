extends CVGridCardObject

signal card_selected(option)
const info_panel_scene = preload("res://src/dreamscape/InfoPanel.tscn")

var is_disabled := false
var index

func _ready() -> void:
	preview_popup.focus_info.info_panel_scene = info_panel_scene
	preview_popup.focus_info.setup()

func _process(_delta: float) -> void:
	pass
#	rect_size = rect_min_size
#	print_debug(rect_size)

func setup(card) -> Card:
	var display_card = .setup(card)
	if display_card is GDScriptFunctionState:
		display_card = yield(display_card, "completed")
	return(display_card)

func _on_DraftCardObject_gui_input(event: InputEvent) -> void:
	if not is_disabled and event is InputEventMouseButton and event.is_pressed():
		if event.get_button_index() == 1:
			emit_signal("card_selected", index)


func refresh_preview_card() -> void:
	cfc.ov_utils.populate_info_panels(preview_popup.preview_card,preview_popup.focus_info)


func _on_GridCardObject_mouse_entered() -> void:
	if is_disabled:
		return
	if "deck_card_entry" in display_card and display_card.deck_card_entry:
		preview_popup.show_preview_card(display_card.deck_card_entry.instance_self(true))
	else:
		preview_popup.show_preview_card(display_card.canonical_name)		
		preview_popup.preview_card.deck_card_entry = display_card.deck_card_entry
	cfc.ov_utils.populate_info_panels(preview_popup.preview_card, preview_popup.focus_info)

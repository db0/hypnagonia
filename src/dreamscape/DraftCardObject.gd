extends DBGridCardObject

signal card_selected(option)
const info_panel_scene = preload("res://src/dreamscape/InfoPanel.tscn")

var index : int

func _ready() -> void:
	preview_popup.focus_info.info_panel_scene = info_panel_scene
	preview_popup.focus_info.setup()

func _process(_delta: float) -> void:
	pass
#	rect_size = rect_min_size
#	print_debug(rect_size)


func on_gui_input(event) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.get_button_index() == 1:
			emit_signal("card_selected", index)

func setup(card_name) -> Card:
	var display_card = .setup(card_name)
	if display_card is GDScriptFunctionState:
		display_card = yield(display_card, "completed")	
	return(display_card)

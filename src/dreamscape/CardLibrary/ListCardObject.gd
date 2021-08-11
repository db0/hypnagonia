extends CLListCardObject

var abilities_label : RichTextLabel

func _ready() -> void:
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed",self,"_on_viewport_resized")

func setup(_card_name: String) -> void:
	.setup(_card_name)
	abilities_label = get_node("Abilities")
	abilities_label.rect_min_size.x = get_viewport().size.x / 2

# Resizes the abilities to match the window size.
# So that the abilities have the most space to show.
func _on_viewport_resized() -> void:
	abilities_label.rect_min_size.x = get_viewport().size.x / 2


func _get_bbcode_format() -> Dictionary:
	var basic_bbcode_formats := Terms.get_bbcode_formats()
	var amounts_format := CardConfig.get_amounts_format(cfc.card_definitions[card_name])
	for amount in amounts_format:
		basic_bbcode_formats[amount] = amounts_format[amount]
	return(basic_bbcode_formats)


func _on_ListCardObject_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.get_button_index() == 1:
		var upgrade_options = cfc.card_definitions[card_name].get("_upgrades", [])
		var select_return = cfc.ov_utils.select_card(
				upgrade_options, 0, "display", false, card_viewer)
		if select_return is GDScriptFunctionState: # Still working.
			select_return = yield(select_return, "completed")

func setup_grid_card_object() -> void:
	.setup_grid_card_object()
	grid_card_object.connect("gui_input", self, "_on_ListCardObject_gui_input")

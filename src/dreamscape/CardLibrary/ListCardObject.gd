extends CLListCardObject

var abilities_label : RichTextLabel

func _ready() -> void:
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

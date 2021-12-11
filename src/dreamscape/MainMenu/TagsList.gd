class_name TagsList
extends ObjectInfoList

const TAG_ICON_SCENE = preload("res://src/dreamscape/MainMenu/TagRepresentation.tscn")

func _ready() -> void:
	list_description.text = "Card Pool Mechanics:"

func _show_description_popup(tag: String, popup_anchor: Node) -> void:
	var description_text : String = Terms.get_term_value(tag, 'generic_description', true)
	_display_popup(popup_anchor, description_text)


func populate_tags(list: Array) -> void:
	populate_list(list, TAG_ICON_SCENE)

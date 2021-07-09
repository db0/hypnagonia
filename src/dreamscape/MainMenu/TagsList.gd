class_name TagsList
extends HBoxContainer

const TAG_ICON_SCENE = preload("res://src/dreamscape/MainMenu/TagRepresentation.tscn")

onready var _tag_description := $DescriptionPopup/TagDescription
onready var description_popup := $DescriptionPopup

func _show_description_popup(tag: String, popup_anchor: Node) -> void:
	var description_text : String = Terms.get_term_value(tag, 'generic_description')
	if description_text:
		_tag_description.text = description_text
		description_popup.visible = true
		description_popup.rect_size = Vector2(0,0)
		description_popup.rect_global_position = popup_anchor.rect_global_position + Vector2(20,-50)

func populate_tags(tag_list: Array) -> void:
	for node in get_children():
		if not node in [description_popup, $Label]:
			node.queue_free()
	# To allow nodes to remove themselves
	yield(get_tree().create_timer(0.05), "timeout")
	for tag in tag_list:
		var tag_scene : TagRepresentation = TAG_ICON_SCENE.instance()
		add_child(tag_scene)
		tag_scene.setup(tag)
		tag_scene.connect("mouse_entered", self, "_on_tag_mouse_enterred", [tag_scene])
		tag_scene.connect("mouse_exited", self, "_on_tag_mouse_exited")

func _on_tag_mouse_enterred(tag_node: TagRepresentation) -> void:
	_show_description_popup(tag_node.name, tag_node)

func _on_tag_mouse_exited() -> void:
	description_popup.visible = false

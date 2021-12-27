class_name ObjectInfoList
extends HBoxContainer

# Stores the current objects we should be showing to the player
var objects_list := []

onready var _object_description := $DescriptionPopup/TagDescription
onready var description_popup := $DescriptionPopup
onready var list_description := $Label


func populate_list(list: Array, scene: PackedScene) -> void:
	objects_list = list
	clear()
	yield(get_tree().create_timer(0.05), "timeout")
	for object_name in objects_list:
		var all_object_names := []
		for node in get_children():
			if not node in [description_popup, $Label]:
				all_object_names.append(node.name)
		if object_name in all_object_names:
			continue
		var representation_scene = scene.instance()
		add_child(representation_scene)
		representation_scene.setup(object_name)
		# warning-ignore:return_value_discarded
		representation_scene.connect("mouse_entered", self, "_on_object_mouse_enterred", [representation_scene])
		# warning-ignore:return_value_discarded
		representation_scene.connect("mouse_exited", self, "_on_object_mouse_exited")
	yield(get_tree(), "idle_frame")
	clear()


func _on_object_mouse_enterred(object_node) -> void:
	_show_description_popup(object_node.name, object_node)


func _on_object_mouse_exited() -> void:
	description_popup.visible = false


func clear(force := false) -> void:
	for node in get_children():
		if not node in [description_popup, $Label] and (not node.name in objects_list or force):
			node.queue_free()


# This should be overriden
func _show_description_popup(_description_text, popup_anchor: Node) -> void:
	_display_popup(popup_anchor, '')


func _display_popup(popup_anchor: Node, description_text: String) -> void:
	_object_description.bbcode_text = description_text.format(Terms.get_bbcode_formats(18))
	description_popup.visible = true
	description_popup.rect_size = Vector2(0,0)
	description_popup.rect_global_position = popup_anchor.rect_global_position + Vector2(20,-50)

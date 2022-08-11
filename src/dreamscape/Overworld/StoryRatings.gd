extends VBoxContainer

signal button_pressed(liked)

onready var _description_label = $"%RichTextLabel"
onready var _description_popup = $"%DescriptionPopup"
onready var dislike = $"%Dislike"
onready var like = $"%Like"



func _on_Dislike_mouse_entered():
	if dislike.disabled:
		return
	show_description_popup("This is a KoboldAI-generated story. Click on this button if you disliked this story for any reason. "\
			+ "For example, if it wasn't coherent, if it ended abrupty, if it wasn't fitting the story etc."\
			+ "This will help us train the AI system to avoid such stories and provide better generations.")


func _on_Like_mouse_entered():
	if like.disabled:
		return
	show_description_popup("This is a KoboldAI-generated story. Click on this button if you liked this story in this context. "\
			+ "This will help us train the AI system to favour such stories and provide better generations.")


func _on_button_mouse_exited():
	_description_popup.visible = false


func show_description_popup(description_text: String) -> void:
	_description_label.bbcode_text = description_text
	_description_popup.visible = true
	_description_popup.rect_size = Vector2(0,0)
	_description_popup.rect_global_position = get_global_mouse_position()\
			+ Vector2(-_description_popup.rect_size.x - 30,-_description_popup.rect_size.y - 20)
#	if _description_popup.rect_global_position.x + _description_popup.rect_size.x > get_viewport().size.x:
#		_description_popup.rect_global_position.x = get_viewport().size.x - _description_popup.rect_size.x



func _on_Like_pressed():
#	_disable_buttons()
	like.modulate = Color(0,1,0)
	dislike.modulate = Color(1,1,1)
	emit_signal("button_pressed", true)


func _on_Dislike_pressed():
#	_disable_buttons()
	dislike.modulate = Color(1,0,0)
	like.modulate = Color(1,1,1)
	emit_signal("button_pressed", false)


	
func _disable_buttons() -> void:
	like.disabled = true
	dislike.disabled = true


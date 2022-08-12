extends Control

signal button_pressed(type)

onready var _description_label = $"%RichTextLabel"
onready var _description_popup = $"%DescriptionPopup"
onready var dislike = $"%Dislike"
onready var surreal = $"%Surreal"
onready var comedy = $"%Comedy"
onready var horror = $"%Horror"
onready var all_buttons = [
	dislike,
	surreal,
	comedy,
	horror,
]


func _on_Dislike_mouse_entered():
	if dislike.disabled:
		return
	show_description_popup("This is a KoboldAI-generated story. Click on this button if you [color=red]disliked[/color] this story for any reason. "\
			+ "For example, if it wasn't coherent, if it ended abrupty, if it wasn't fitting the story etc."\
			+ "This will help us train the AI system to avoid such stories and provide better generations.")


func _on_Surreal_mouse_entered():
	if surreal.disabled:
		return
	show_description_popup("This is a KoboldAI-generated story. "\
			+ "Click on this button if you [color=green]liked[/color] this story and you think it has a [color=yellow][b]Surrealist[/b][/color] context. "\
			+ "This will provide better stories for everyone and "\
			+ "help us train the AI system to distinguish such stories and provide better generations.")


func _on_Comedy_mouse_entered():
	if comedy.disabled:
		return
	show_description_popup("This is a KoboldAI-generated story. "\
			+ "Click on this button if you [color=green]liked[/color] this story and you think it has a [color=yellow][b]Comedy[/b][/color] context. "\
			+ "This will provide better stories for everyone and "\
			+ "help us train the AI system to distinguish such stories and provide better generations.")

func _on_Horror_mouse_entered():
	if horror.disabled:
		return
	show_description_popup("This is a KoboldAI-generated story. "\
			+ "Click on this button if you [color=green]liked[/color] this story and you think it has a [color=yellow][b]Horror[/b][/color] context. "\
			+ "This will provide better stories for everyone and "\
			+ "help us train the AI system to distinguish such stories and provide better generations.")

func _on_button_mouse_exited():
	_description_popup.visible = false


func show_description_popup(description_text: String) -> void:
	_description_label.bbcode_text = description_text
	_description_popup.visible = true
	_description_popup.rect_size = Vector2(0,0)
	_description_popup.rect_global_position = get_global_mouse_position()\
			+ Vector2(-_description_popup.rect_size.x - 30,-_description_popup.rect_size.y - 20)
	if _description_popup.rect_global_position.y < 0:
		_description_popup.rect_global_position.y = 0
		_description_popup.rect_global_position.x -= 10


func _on_Surreal_pressed():
#	_disable_buttons()
	surreal.modulate = Color(0,1,0)
	_whiten_all_but(surreal)
	emit_signal("button_pressed", HConst.AIGenres.SURREALISM)


func _on_Dislike_pressed():
#	_disable_buttons()
	dislike.modulate = Color(1,0,0)
	_whiten_all_but(dislike)
	emit_signal("button_pressed", HConst.AIGenres.DISLIKE)


func _on_Horror_pressed():
#	_disable_buttons()
	horror.modulate = Color(0,1,0)
	_whiten_all_but(horror)
	emit_signal("button_pressed", HConst.AIGenres.HORROR)


func _on_Comedy_pressed():
#	_disable_buttons()
	comedy.modulate = Color(0,1,0)
	_whiten_all_but(comedy)
	emit_signal("button_pressed", HConst.AIGenres.COMEDY)


func _disable_buttons() -> void:
	for b in all_buttons:
		b.disabled = true


func _whiten_all_but(button: Button) -> void:
	for b in all_buttons:
		if b != button:
			b.modulate = Color(1,1,1)

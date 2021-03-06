class_name ArchetypeButton
extends MarginContainer

onready var button := $Button
onready var icon := $Icon
onready var _tween := $Tween

var archetype_texture: ImageTexture

func setup(archetype: String, type: String) -> void:
	button.name = type
	button.text = type
	archetype_texture = retrieve_icon(archetype, type)
	if archetype_texture:
		icon.texture = archetype_texture
		icon.visible = true
	button.rect_min_size.x = get_viewport().size.x * 0.185
	button.rect_min_size.y = get_viewport().size.y * 0.43

func _on_Button_mouse_entered() -> void:
	_tween.remove_all()
	_tween.interpolate_property(icon, 'modulate:a',
			icon.modulate.a, 0.20, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()


func _on_Button_mouse_exited() -> void:
	_tween.remove_all()
	_tween.interpolate_property(icon, 'modulate:a',
			icon.modulate.a, 1, 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN)
	_tween.start()


static func retrieve_icon(archetype: String, type: String) -> ImageTexture:
	var archetype_button_icon = Aspects[archetype.to_upper()][type].get("Icon")
	if archetype_button_icon:
		var archetype_tex := ImageTexture.new();
		var image = archetype_button_icon.get_data()
		archetype_tex.create_from_image(image)
		return(archetype_tex)
	return(null)

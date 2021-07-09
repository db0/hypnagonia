class_name TagRepresentation
extends CenterContainer

onready var _tag_icon:= $TagIcon

func setup(tag: String) -> void:
	name = tag
	var tex : StreamTexture = Terms.get_term_value(tag, 'icon')
	# This means there's no dedicated texture for that tag specified.
	if tex:
		var new_texture = ImageTexture.new();
		var image = tex.get_data()
		new_texture.create_from_image(image)
		_tag_icon.texture = new_texture

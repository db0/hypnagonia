class_name TagRepresentation
extends CenterContainer

onready var _tag_icon:= $TagIcon

func setup(tag: String) -> void:
	name = tag
	var tex : StreamTexture = Terms.get_term_value(tag, 'icon')
	# This means there's no dedicated texture for that tag specified.
	if tex:
		_tag_icon.texture = CFUtils.convert_texture_to_image(tex)

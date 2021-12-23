extends HBoxContainer

export(StreamTexture) var icon_texture: StreamTexture

func _ready() -> void:
	$Icon.texture = CFUtils.convert_texture_to_image(icon_texture)

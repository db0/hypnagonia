extends HBoxContainer

export(StreamTexture) var icon_texture: StreamTexture

func _ready() -> void:
	var new_texture = ImageTexture.new();
	var image = icon_texture.get_data()
	new_texture.create_from_image(image)
	$Icon.texture = new_texture

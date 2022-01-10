extends HBoxContainer

export(StreamTexture) var icon_texture: StreamTexture

onready var signifier_amount := $Label

func _ready() -> void:
	$Icon.texture = CFUtils.convert_texture_to_image(icon_texture)

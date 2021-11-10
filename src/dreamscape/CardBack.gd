class_name HypnagoniaCardBack
extends CardBackTexture

const TEXTURES_AMOUNT := 6

export(StreamTexture) var back_texture1: StreamTexture
export(StreamTexture) var back_texture2: StreamTexture
export(StreamTexture) var back_texture3: StreamTexture
export(StreamTexture) var back_texture4: StreamTexture
export(StreamTexture) var back_texture5: StreamTexture
export(StreamTexture) var back_texture6: StreamTexture



func _prepare_back_from_texture(true_random := false) -> void:
	var all_textures := [
		back_texture1,
		back_texture2,
		back_texture3,
		back_texture4,
		back_texture5,
		back_texture6
	]
	if true_random:
		var idx = CFUtils.randi_range(0,all_textures.size() - 1)
		card_texture.texture = CFUtils.convert_texture_to_image(
				all_textures[idx], true)
	elif all_textures[globals.card_back_texture_selection]:
		card_texture.texture = CFUtils.convert_texture_to_image(
				all_textures[globals.card_back_texture_selection], true)
	else:
		._prepare_back_from_texture()



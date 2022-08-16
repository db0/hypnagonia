class_name HypnagoniaCardBack
extends CardBackTexture

func _prepare_back_from_texture(_true_random := false) -> void:
	card_texture.texture = CFUtils.convert_texture_to_image(globals.encounters.card_back_texture, true)

static func get_random_card_back() -> String:
	var all_options = CFUtils.list_imported_in_directory("res://assets/card_backs/random/", true)
	CFUtils.shuffle_array(all_options, true)
	return(all_options[0])


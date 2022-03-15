class_name HUtils
extends Reference


# Returns a Dictionary with the combined Script definitions of all set files
static func grab_random_texture(specific_dir: String = '') -> ImageTexture:
	# The higher the number, the more likely the textures in that directory
	# to be chosen
	
	var directories := {
		"res://shaders/textures/cc0textures/": 1,
		"res://shaders/textures/pixabay/": 2,
	}
	if specific_dir != '':
		directories = {"res://shaders/textures/" + specific_dir + "/": 1}
	var random_dir := []
	for dir in directories:
		for _iter in range(directories[dir]):
			random_dir.append(dir)
	var rng = CFUtils.randi_range(0,random_dir.size() - 1)
	var directory = random_dir[rng]
	var textures := CFUtils.list_imported_in_directory(directory)
	CFUtils.shuffle_array(textures)
	var new_texture := ImageTexture.new();
	var tex = load(directory + textures[0])
	var image = tex.get_data()
	new_texture.create_from_image(image)
	return(new_texture)
	
static func grab_texture(path: String) -> ImageTexture:
	var new_texture := ImageTexture.new();
	var tex = load(path)
	var image = tex.get_data()
	new_texture.create_from_image(image)
	return(new_texture)

static func rnd_color(single_color := false, base : float = 1) -> Vector3:
	var r := 1.0 * base
	var g := 1.0 * base
	var b := 1.0 * base
	while r > 0.7 * base and g > 0.7 * base and b > 0.7 * base:
		r = CFUtils.randf_range(0.0,0.9 * base)
		g = CFUtils.randf_range(0.0,0.9 * base)
		b = CFUtils.randf_range(0.0,0.9 * base)
	var final_color := Vector3(r,g,b)
	if single_color:
		var solid_color = CFUtils.randi_range(0,2)
		for rgb in [0,1,2]:
			if rgb != solid_color:
				final_color[rgb] *= 0.2
			else:
				final_color[rgb] = CFUtils.randf_range(0.7 * base,1.0 * base)
	return(final_color)


# This method is used for scripts which want to modify a specific amount on a card's 
# scripts, which relates to a specific purpose
# This is used for example, when a card applies two different effects, but we
# want to modify just one of them.
# As the effects would be typically using the _amounts keys "effect_stacks"
# and "effect_stacks2", we wouldn't know which of these keys maps to which effect
# Therefore we use the "_amount_purpose_map" key to determine which _amounts key
# maps to which purpose.
static func get_amount_key_by_purpose(purpose: String, card_properties: Dictionary) -> Array:
	var matching_keys := []
	if not card_properties.has("_amounts"):
		return(matching_keys)
	# If the card properties do not have an "_amount_purpose_map" key
	# Then we consider all "effect_stacks" keys to match the purpose 
	# (assuming there's only one effect being applied and the purpose is an effect)
	if not card_properties.has("_amount_purpose_map"):
		for key in card_properties["_amounts"]:
			if "effect_stacks" in key:
				matching_keys.append(key)
	# If the card has an "_amount_purpose_map" key, its contents map each 
	# _amount key to specific effects. 
	# By comparing the key to the effect we want, we can discover which of the 
	# amounts key correspond to which effect.
	else:
		for key in card_properties["_amount_purpose_map"]:
			if card_properties["_amount_purpose_map"][key] == purpose:
				matching_keys.append(key)
	return(matching_keys)

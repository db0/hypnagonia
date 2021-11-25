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

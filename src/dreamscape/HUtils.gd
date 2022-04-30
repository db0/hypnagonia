class_name HUtils
extends Reference


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
	var rng = rand_range(0,random_dir.size() - 1)
	var directory = random_dir[rng]
	var textures := CFUtils.list_imported_in_directory(directory)
	CFUtils.shuffle_array(textures, true)
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
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	while r > 0.7 * base and g > 0.7 * base and b > 0.7 * base:
		r = rng.randf_range(0.0,0.9 * base)
		g = rng.randf_range(0.0,0.9 * base)
		b = rng.randf_range(0.0,0.9 * base)
	var final_color := Vector3(r,g,b)
	if single_color:
		var solid_color = rng.randi_range(0,2)
		for rgb in [0,1,2]:
			if rgb != solid_color:
				final_color[rgb] *= 0.2
			else:
				final_color[rgb] = rng.randf_range(0.7 * base,1.0 * base)
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

# Modifies the provided card properties _amounts dictionary with the specified modifications
# String values modify the existing value in-place through addition/multiplication
# Interget values replace the existing value completely
# For a CardEntry's properties, this function should only be called from modify_property()
# to ensure the changes survive card upgrades
static func modify_amounts(properties: Dictionary, amount_name: String, value, purpose := '') -> void:
	if not properties.has("_amounts"):
		properties["_amounts"] = {}
	if amount_name == 'discover_purpose':
		var amount_keys : Array = get_amount_key_by_purpose(purpose, properties)
		# when using a purpose seek, there may be multiple amount keys matching it
		# in which care, we'll do some recursion to loop through all of them
		for amount_key in amount_keys:
			modify_amounts(properties, amount_key, value)
			return
	var current_value = properties["_amounts"].get(amount_name)
	var new_value
	if typeof(value) == TYPE_STRING\
			and value.lstrip("*").is_valid_float()\
			and typeof(current_value) in [TYPE_INT, TYPE_REAL]:
		if value.begins_with("*"):
			# We reduce floats to a single decimal
			var step := 0.1
			if 'percentage' in amount_name:
				step = 0.01
			new_value = stepify(float(current_value) * float(value.lstrip("*")), step)
		else:
			new_value = current_value + float(value)
			# For now, I assume no amounts will be negative
			# (They should use is_inverted instead)
			if new_value < 0:
				new_value = 0
		if typeof(current_value) == TYPE_INT:
			# Decreases are rounded down
			if float(value.lstrip("*")) < 1:
				new_value = int(floor(new_value))
			if float(value.lstrip("*")) >= 1:
				new_value = int(ceil(new_value))
	else:
		new_value = value
	properties["_amounts"][amount_name] = new_value

# Creates the format dictionary to convert strings pointing to amounts
# text in the card abilities, into rich text numbers.
static func get_amounts_format(properties_dict: Dictionary, printed_properties_dict := {}) -> Dictionary:
	var amounts_format = properties_dict.get("_amounts", {}).duplicate(true)
	var printed_amounts_format = printed_properties_dict.get("_amounts", {}).duplicate(true)
	for amount in amounts_format:
		var amount_color = "yellow"
		if printed_amounts_format.has(amount):
			if amounts_format[amount] > printed_amounts_format[amount]:
				if amount in HConst.DETRIMENTAL_INTEGERS + HConst.DETRIMENTAL_FLOATS:
					amount_color = "red"
				else:
					amount_color = "green"
			elif amounts_format[amount] < printed_amounts_format[amount]:
				if amount in HConst.DETRIMENTAL_INTEGERS + HConst.DETRIMENTAL_FLOATS:
					amount_color = "green"
				else:
					amount_color = "red"
		var fmt := {
			"color": amount_color,
			"amount": amounts_format[amount],
		}
		if 'percentage' in amount:
			fmt.amount = str(amounts_format[amount] * 100) + '%'
		amounts_format[amount] = "[color={color}]{amount}[/color]".format(fmt)
	return(amounts_format)

static func get_all_card_variants(card_name: String) -> Array:
	var all_variants := [card_name]
	if cfc.card_definitions[card_name].has("_upgrades"):
		all_variants += cfc.card_definitions[card_name]["_upgrades"]
	elif cfc.card_definitions[card_name].get("_is_upgrade", false):
		var upgrade_parent = find_upgrade_parent(card_name)
		all_variants.append(upgrade_parent)
		for variant in get_all_card_variants(upgrade_parent):
			if not all_variants.has(variant):
				all_variants.append(variant)
	return(all_variants)


static func get_all_list_variants(card_list: Array) -> Array:
	var all_variants := card_list.duplicate()
	for card_name in card_list:
		for variant_name in get_all_card_variants(card_name):
			if not all_variants.has(variant_name):
				all_variants.append(variant_name)
	return(all_variants)

static func find_upgrade_parent(card_name: String):
	for cn in cfc.card_definitions:
		var upgrades = cfc.card_definitions[cn].get("_upgrades", [])
		if upgrades.has(card_name):
			return(cn)
	return(false)


# Shuffles all possible backgrounds in the game and selects one at random
# Retuns a dictionary  with 2 keys
# * image (ImageTexture): The image texture as the first element
# * is_bright (bool): Whether that background is considered bright or dark
# The type of background to return can also be specified through the "type" var
# * 'any': Return either dark or bright bg
# * 'dark': Return only dark bg
# * 'bright': Return only bright bg
static func get_random_background(type := 'any') -> Dictionary:
	var dark_backgrounds := []
	var bright_backgrounds := []
	if type != 'bright':
		dark_backgrounds = CFUtils.list_imported_in_directory("res://assets/backgrounds/dark/")
	if type != 'dark':
		bright_backgrounds = CFUtils.list_imported_in_directory("res://assets/backgrounds/bright/")
	var all_backgrounds := bright_backgrounds + dark_backgrounds
	CFUtils.shuffle_array(all_backgrounds,true)
	var selected_background :String = all_backgrounds[0]
	var bpath: String
	if selected_background in bright_backgrounds:
		bpath = "res://assets/backgrounds/bright/"
	else:
		bpath = "res://assets/backgrounds/dark/"
	var return_res := {
		"image": CFUtils.convert_texture_to_image(bpath + selected_background),
		"is_bright": selected_background in bright_backgrounds
	}
	return(return_res)

extends CardFront


onready var cost_container := $CostContainer
onready var tag_container1 := $TagContainer1
onready var tag_container2 := $TagContainer2
onready var tag_icon1 := $TagContainer1/TagIcon
onready var tag_icon2 := $TagContainer2/TagIcon
onready var card_design := $CardDesign
onready var shader_effect := $ShaderEffect
onready var art := $Art

func _ready() -> void:
#	text_expansion_multiplier = {
#		"Name": 2,
#		"Tags": 1.2,
#	}
#	compensation_label = "Abilities"
	_card_text = $CardText
	# Map your card text label layout here. We use this when scaling
	# The card or filling up its text
	card_labels["Name"] = $"CardText/ArtLayover/MC/Name"
	card_labels["Type"] = $"CardText/MC/Type"
	card_labels["Tags"] = $"CardText/Tags"
	card_labels["Abilities"] = $"CardText/OutsideArt/Abilities"
	card_labels["Cost"] = $CostContainer/Cost


	# These set te max size of each label. This is used to calculate how much
	# To shrink the font when it doesn't fit in the rect.
#	card_label_min_sizes["Name"] = Vector2(CFConst.CARD_SIZE.x - 4, 16)
#	card_label_min_sizes["Type"] = Vector2(CFConst.CARD_SIZE.x - 4, 14)
#	card_label_min_sizes["Tags"] = Vector2(CFConst.CARD_SIZE.x - 4, 10)
#	card_label_min_sizes["Abilities"] = Vector2(CFConst.CARD_SIZE.x - 32, 50)
#	card_label_min_sizes["Cost"] = Vector2(30, 30)

	# This is not strictly necessary, but it allows us to change
	# the card label sizes without editing the scene
	for l in card_label_min_sizes:
		card_labels[l].rect_min_size = card_label_min_sizes[l]

	# This stores the maximum size for each label, when the card is at its
	# standard size.
	# This is multiplied when the card is resized in the viewport.
	for label in card_labels:
		match label:
			"Cost":
				original_font_sizes[label] = 20
			"Abilities":
				original_font_sizes[label] = 20
			_:
				original_font_sizes[label] = 22


func set_tag_icon(tags: Array) -> void:
	for tag in tags:
		var tex : StreamTexture = Terms.get_term_value(tag, 'icon')
		# This means there's no dedicated texture for that tag specified.
		if not tex:
			continue
		var new_texture = ImageTexture.new();
		var image = tex.get_data()
		new_texture.create_from_image(image)
		if not tag_container1.visible:
			tag_icon1.texture = new_texture
			tag_container1.visible = true
		elif not tag_container2.visible:
			tag_icon2.texture = new_texture
			tag_container2.visible = true

func apply_sharer(shader_path: String) -> void:
	shader_effect.visible = true
	shader_effect.material = ShaderMaterial.new()
	shader_effect.material.shader = load(shader_path)


func _get_bbcode_format() -> Dictionary:
	return(Terms.get_bbcode_formats())

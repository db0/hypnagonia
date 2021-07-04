extends CardFront

onready var cost_container := $CostContainer
func _ready() -> void:
	text_expansion_multiplier = {
		"Name": 2,
		"Tags": 1.2,
	}
	compensation_label = "Abilities"
	_card_text = $CardText
	# Map your card text label layout here. We use this when scaling
	# The card or filling up its text
	card_labels["Name"] = $"CardText/ArtLayover/PanelContainer/VBoxContainer/Name"
	card_labels["Type"] = $"CardText/ArtLayover/Type"
	card_labels["Tags"] = $"CardText/ArtLayover/Tags"
	card_labels["Abilities"] = $"CardText/OutsideArt/Abilities"
	card_labels["Cost"] = $CostContainer/Cost


	# These set te max size of each label. This is used to calculate how much
	# To shrink the font when it doesn't fit in the rect.
	card_label_min_sizes["Name"] = Vector2(CFConst.CARD_SIZE.x - 34, 19)
	card_label_min_sizes["Type"] = Vector2(CFConst.CARD_SIZE.x - 4, 14)
	card_label_min_sizes["Tags"] = Vector2(CFConst.CARD_SIZE.x - 4, 12)
	card_label_min_sizes["Abilities"] = Vector2(CFConst.CARD_SIZE.x - 4, 100)
	card_label_min_sizes["Cost"] = Vector2(30, 30)

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
				original_font_sizes[label] = 30
			_:
				original_font_sizes[label] = 16


# We use this as an alternative to scaling the card using the "scale" property.
# This is typically used in the viewport focus only, to keep the text legible
# because scaling the card starts distoring the font.
#
# For gameplay purposes (i.e. scaling on the table etc), we keep using the
# .scale property, as that handles the Area2D size as well.
func scale_to(scale_multiplier: float) -> void:
	for l in card_labels:
		var label : Label = card_labels[l]
		if label.rect_min_size != card_label_min_sizes[l] * scale_multiplier:
			label.rect_min_size = card_label_min_sizes[l] * scale_multiplier
			font_sizes[l] = original_font_sizes.get(l) * scale_multiplier
	$Art.rect_min_size =\
			Vector2(170,100) * scale_multiplier
	$Art.rect_position.y =\
			30 * scale_multiplier
	$CardText.rect_min_size =\
			Vector2(170,240) * scale_multiplier
	$CardText/ArtLayover.rect_min_size =\
			Vector2(170,130) * scale_multiplier
	$CostContainer.rect_min_size = \
			Vector2(30,30) * scale_multiplier
	$CostContainer/CostIcon.rect_min_size = \
			Vector2(30,30) * scale_multiplier
	$CostContainer.rect_position =\
			Vector2(-7,-7) * scale_multiplier
	for l in card_labels:
		if scaled_fonts.get(l) != scale_multiplier:
			var label : Label = card_labels[l]
			set_label_text(label, label.text)
			scaled_fonts[l] = scale_multiplier

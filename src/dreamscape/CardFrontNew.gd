extends CardFront

const TEXT_BACKGROUND_COLOURS := {
	"Action": Color(0.15,0,0),
	"Control": Color(0,0,0.15),
	"Concentration": Color(0,0.15,0),
	"Perturbation": Color(0,0,0),
	"Understanding": Color(0.38,0,0.65),
}
const SHADER_BACKGROUND_COLOURS := {
	"Action": Color(0,0,0),
	"Control": Color(0,0,0.1),
	"Concentration": Color(0,0.1,0),
	"Perturbation": Color(0,0,0),
	"Understanding": Color(0.22,0,0.35),
}

onready var cost_container := $CostContainer
onready var tag_container1 := $TagContainer1
onready var tag_container2 := $TagContainer2
onready var tag_container3 := $TagContainer3
onready var tag_container4 := $TagContainer4
onready var tag_icon1 := $TagContainer1/TagIcon
onready var tag_icon2 := $TagContainer2/TagIcon
onready var tag_icon3 := $TagContainer3/TagIcon
onready var tag_icon4 := $TagContainer4/TagIcon
onready var card_design := $CardDesign
onready var shader_effect := $ShaderEffect
onready var text_shader := $TextShader
onready var bbc := $BackBufferCopy
onready var art := $Art
onready var animation := $Animation
onready var text_background := $TextBackground
onready var title_background := $TitleBackground
onready var title := $Title
onready var rarity_top := $RarityTop
onready var rarity_middle := $RarityMiddle
onready var cost_container_background := $CostContainer/CostIcon
onready var scarred := $Scarred
onready var enhanced := $Enhanced
onready var text_style : StyleBoxFlat = text_background.get("custom_styles/panel/StyleBoxFlat")
onready var placeholder := $Placeholder

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
	card_labels["Type"] = $"CardText/ArtLayover/MC2/Type"
	card_labels["Abilities"] = $"CardText/OutsideArt/Abilities"
	card_labels["Tags"] = $Tags
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
				original_font_sizes[label] = 25
			"Abilities":
				original_font_sizes[label] = 20
			_:
				original_font_sizes[label] = 18
	if cfc.game_settings.get('anim_text_backgrounds'):
		toggle_text_shader_visible(true)
	else:
		toggle_text_shader_visible(false)


func set_tag_icon(tags: Array) -> void:
	# This allow this function to be reused during the game as well
	tag_container1.visible = false
	tag_container2.visible = false
	tag_container3.visible = false
	tag_container4.visible = false
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
		elif not tag_container3.visible:
			tag_icon3.texture = new_texture
			tag_container3.visible = true
		elif not tag_container4.visible:
			tag_icon4.texture = new_texture
			tag_container4.visible = true


func apply_shader(shader_path: String) -> void:
	bbc.visible = true
	shader_effect.visible = true
	shader_effect.material = ShaderMaterial.new()
	shader_effect.material.shader = load(shader_path)


func set_card_art(filename, is_placeholder := false) -> void:
	var new_texture = CFUtils.convert_texture_to_image(filename)
	art.texture = new_texture
	art.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	# In case the generic art has been modulated, se switch it back to normal colour
	art.self_modulate = Color(1,1,1)
	placeholder.visible = is_placeholder
	
func set_card_animation(filename, is_placeholder := false) -> void:
	var anim = VideoStreamTheora.new()
	anim.set_file(filename)
	animation.stream = anim
	animation.autoplay = true
	animation.visible = true
	animation.play()
	animation.connect("finished",self,"_on_animation_finished")
	# In case the generic art has been modulated, se switch it back to normal colour
	animation.self_modulate = Color(1,1,1)
	placeholder.visible = is_placeholder
	
func _on_animation_finished():
	animation.play()

func _get_bbcode_format(font_size = null) -> Dictionary:
	return(Terms.get_bbcode_formats(font_size))


func set_rarity() -> void:
	var rarity_color := theme.get_color(
			card_owner.get_property("_rarity"), "Label")
	title_background.color = rarity_color * 0.8
	title_background.color.a = 1
	var glow_multiplier := 1.0
	if card_owner.get_property("_is_upgrade"):
		glow_multiplier = 1.4
	rarity_top.modulate = rarity_color * glow_multiplier
	rarity_middle.modulate = rarity_color * glow_multiplier
#	var card_name_label : Label = card_front.card_labels["Name"]
#	card_name_label.add_color_override("font_color", rarity_color)

func toggle_text_shader_visible(set_visible = null) -> void:
	if typeof(set_visible) == TYPE_NIL:
		text_shader.visible = !text_shader.visible
	else:
		text_shader.visible = set_visible
	if card_owner.get_property("Type"):
		if not text_shader.visible:
			text_style.set_bg_color(TEXT_BACKGROUND_COLOURS[card_owner.get_property("Type")])
		else:
			text_style.set_bg_color(SHADER_BACKGROUND_COLOURS[card_owner.get_property("Type")])

func _add_title_bbcode(rtlabel: RichTextLabel):
	rtlabel.push_color("#FFFFFF")
	var label_fonts := _get_card_rtl_fonts(rtlabel)
	rtlabel.push_font(label_fonts["title_font"])

func _pop_title_bbcode(rtlabel: RichTextLabel):
	rtlabel.pop()
	rtlabel.pop()

# Sets parameters for the shader, and also stores them in a dictionary to be
# reused by the viewport duplicate.
func _set_shader_param(parameter: String, value) -> void:
	material.set_shader_param(parameter, value)

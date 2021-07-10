class_name JournalChoice
extends RichTextLabel

const ENEMY_CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")
const TORMENT_META_DICT := {
	"torment": '',
	"meta_type": "torment_card",
}
var journal

func _ready() -> void:
	bbcode_enabled = true


func _init(_journal: Node, choice: Dictionary) -> void:
	journal = _journal
	name = choice["meta_tag"]
	var torment_tag = TORMENT_META_DICT.duplicate(true)
	var torment_name : String = choice["torment"]
	torment_tag["torment"] = torment_name
	var torment_card = ENEMY_CARD_PREVIEW_SCENE.instance()
	journal.card_storage.add_child(torment_card)
	torment_card.setup(torment_name)
	journal.enemy_cards[torment_name] = torment_card
	var tag_format = {"torment_tag": JSON.print(torment_tag)}
	var description = choice["description"].format(tag_format)
	set_bbcode(description)
	connect("meta_clicked", journal, "on_meta_clicked")
	connect("meta_hover_started", journal, "_on_meta_hover_started")
	connect("meta_hover_ended", journal, "_on_meta_hover_ended")
	

# Otherwise the label won't appear
func set_bbcode(value):
	.set_bbcode(value)
	rect_min_size.y = get_min_height() + 5
	
func get_min_height() -> float:
	var theme : Theme = journal.theme
	var label_font : Font
	if theme:
		label_font = theme.get_font("font", "RichTextLabel").duplicate()
	else:
		label_font = get("custom_fonts/normal_font").duplicate()
	return(label_font.get_height())

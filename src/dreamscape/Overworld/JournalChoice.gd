class_name JournalChoice
extends RichTextLabel

signal pressed

const ENEMY_CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")
const TORMENT_META_DICT := {
	"name": '',
	"meta_type": "torment_card",
}
var journal
var formated_description : String


func _ready() -> void:
	bbcode_enabled = true


func _init(_journal: Node, choice: Dictionary) -> void:
	journal = _journal
	fit_content_height = true
	name = choice["meta_tag"]
	if choice["meta_tag"] == 'torment':
		var unique_enemy_tags := []
		var rtag_index = 1
		var tag_format := {}
		for iter in range(choice["enemies"].size()):
			var torment_name : String = choice['enemies'][iter]
			if torment_name in unique_enemy_tags:
				continue
			var rich_text_format_tag = "torment_tag" + str(rtag_index)
			rtag_index += 1
			var torment_tag = TORMENT_META_DICT.duplicate(true)
			torment_tag["name"] = torment_name
			tag_format[rich_text_format_tag] = JSON.print(torment_tag)
			if not journal.enemy_cards.has(torment_name):
				var torment_card = ENEMY_CARD_PREVIEW_SCENE.instance()
				journal.card_storage.add_child(torment_card)
				torment_card.setup(torment_name)
				journal.enemy_cards[torment_name] = torment_card
		formated_description = choice["description"].format(tag_format)
		print_debug(tag_format)
		print_debug(formated_description)
		bbcode_text = formated_description
	# We don't want to create multiple cards for the same Torment.
	# warning-ignore:return_value_discarded
	connect("meta_clicked", journal, "on_meta_clicked")
	# warning-ignore:return_value_discarded
	connect("meta_hover_started", journal, "_on_meta_hover_started")
	# warning-ignore:return_value_discarded
	connect("meta_hover_ended", journal, "_on_meta_hover_ended")
	# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")
	# warning-ignore:return_value_discarded
	connect("gui_input", self, "_on_gui_input")


func _on_mouse_entered() -> void:
	bbcode_text = "[color=yellow]" + formated_description + "[/color]"


func _on_mouse_exited() -> void:
	bbcode_text = formated_description


func _on_gui_input(event) -> void:
	if event.is_pressed() and event.get_button_index() == 1:
		emit_signal("pressed")

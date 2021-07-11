class_name JournalChoice
extends RichTextLabel

signal pressed

const ENEMY_CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")

var journal
var formated_description : String


func _ready() -> void:
	bbcode_enabled = true


func _init(_journal: Node, encounter: SingleEncounter) -> void:
	modulate.a = 0
	journal = _journal
	fit_content_height = true
	name = encounter.type
	if encounter.type == 'torment':
		var enemy_encounter: EnemyEncounter = encounter
		for torment_name in enemy_encounter.get_unique_enemies():
			if not journal.enemy_cards.has(torment_name):
				var torment_card = ENEMY_CARD_PREVIEW_SCENE.instance()
				journal.card_storage.add_child(torment_card)
				torment_card.setup(torment_name)
				journal.enemy_cards[torment_name] = torment_card
		formated_description = enemy_encounter.get_formated_description()
		bbcode_text = formated_description
	if encounter.type == 'boss':
		var boss_encounter: BossEncounter = encounter
		formated_description = boss_encounter.description
		bbcode_text = formated_description
	# We don't want to create multiple cards for the same Torment.
	# warning-ignore:return_value_discarded
	connect("meta_clicked", journal, "_on_meta_clicked")
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
		bbcode_text = "[color=grey]" + formated_description + "[/color]"
		disconnect("mouse_entered", self, "_on_mouse_entered")
		disconnect("mouse_exited", self, "_on_mouse_exited")
		disconnect("gui_input", self, "_on_gui_input")
		disconnect("meta_hover_started", journal, "_on_meta_hover_started")
		disconnect("meta_hover_ended", journal, "_on_meta_hover_ended")

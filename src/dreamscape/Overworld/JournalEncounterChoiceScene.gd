extends HBoxContainer

var pathos_released: String

onready var journal_choice : JournalEncounterChoice
onready var pathos_icon = $PathosIcon

func setup(_journal, encounter: SingleEncounter) -> void:
	journal_choice = JournalEncounterChoice.new(_journal, encounter)
	pathos_released = encounter.pathos_released
	add_child(journal_choice)
	# In the future maybe we'll have one icon per pathos type
	pathos_icon.texture = CFUtils.convert_texture_to_image("res://assets/icons/GUI/drama-masks.png")

func _on_PathosIcon_mouse_entered() -> void:
	var pathos_desc := "Choosing this encounter, will release {pathos_amount} {pathos_name}"
	var desc_format := {
		"pathos_amount": globals.player.pathos.get_final_release_amount(pathos_released),
		"pathos_name": pathos_released,
	}
	journal_choice.journal.show_description_popup(pathos_desc.format(desc_format))


func _on_PathosIcon_mouse_exited() -> void:
	journal_choice.journal._description_popup.visible = false


func disable_mouse_inputs() -> void:
	pathos_icon.disconnect("mouse_entered", self, "_on_PathosIcon_mouse_entered")
	pathos_icon.disconnect("mouse_exited", self, "_on_PathosIcon_mouse_exited")

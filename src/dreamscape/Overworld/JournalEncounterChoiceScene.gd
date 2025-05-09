extends HBoxContainer

var pathos_released: String

onready var journal_choice : JournalEncounterChoice
onready var pathos_icon = $"%PathosIcon"
onready var story_ratings = $"%StoryRatings"


func setup(_journal, encounter: SingleEncounter) -> void:
	journal_choice = JournalEncounterChoice.new(_journal, encounter)
	pathos_released = encounter.pathos_released
	add_child(journal_choice)
	# In the future maybe we'll have one icon per pathos type
	pathos_icon.texture = CFUtils.convert_texture_to_image("res://assets/icons/GUI/drama-masks.png")
	if encounter is BossEncounter:
		pathos_icon.self_modulate = Color(1,0,0)
	if encounter.introduction.is_generated and cfc.game_settings.judge_ai:
		story_ratings.visible = true
		story_ratings.connect("button_pressed", journal_choice.submit_rating, "story_rated")
	

func _on_PathosIcon_mouse_entered() -> void:
	var pathos_desc := "Choosing this encounter, will release %s.\n\n"\
			% [pathos_released]\
			+ "Next journal entry's encounter will be adjusted as follows:"
	var pathos_type: PathosType = globals.player.pathos.pathi[pathos_released]
	var pathos_dict := { 
		pathos_released: {
			"release_mod": pathos_type.get_final_release_amount(),
			"repress_mod": -pathos_type.get_final_release_amount(),
		}
	}
	for pathos in Terms.RUN_ACCUMULATION_NAMES.values():
		if pathos != pathos_released:
			pathos_dict[pathos] = {
					"release_mod": 0,
					"repress_mod": 0,
				}
	journal_choice.journal.show_pathos_popup(pathos_desc, pathos_dict)


func _on_PathosIcon_mouse_exited() -> void:
	journal_choice.journal.pathos_details_popup.visible = false


func disable_mouse_inputs() -> void:
	pathos_icon.disconnect("mouse_entered", self, "_on_PathosIcon_mouse_entered")
	pathos_icon.disconnect("mouse_exited", self, "_on_PathosIcon_mouse_exited")

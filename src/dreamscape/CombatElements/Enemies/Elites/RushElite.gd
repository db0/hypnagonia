extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "The Labyrinth",
	"Health": 85,
	"Type": "Context",
	"Damage": 0,
	"_texture_size_x": 180,
	"_texture_size_y": 180,
	"_character_art": 'Artbreeder.com',
	"_is_ordered": false,
	"_health_variability": 3,
}

func _on_Art_mouse_exited() -> void:
	description_popup.visible = false


func _on_Art_mouse_entered() -> void:
	var art_text := "{entity_name}\n"\
			+ "Character art by: {character_art}"
	var art_fmt = {
		"entity_name": canonical_name,
		"character_art": character_art,
	}
	_show_description_popup(art_text.format(art_fmt), art)

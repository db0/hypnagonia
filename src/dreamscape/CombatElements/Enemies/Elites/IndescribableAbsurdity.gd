extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "Indescribable Absurdity",
	"Health": 180,
	"Type": "Absurdity",
	"Damage": 0,
	"_texture_size_x": 160,
	"_texture_size_y": 160,
	"_character_art": 'Nobody',
	"_is_ordered": false,
	"_health_variability": 5,
}


func _ready() -> void:
	active_effects.mod_effect(Terms.ACTIVE_EFFECTS.self_cleaning.name, 1, false, false, ["Init"])

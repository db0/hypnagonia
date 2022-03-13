extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "Jumbletron",
	"Health": 90,
	"Type": "Absurdity",
	"Damage": 0,
	"_texture_size_x": 200,
	"_texture_size_y": 200,
	"_character_art": 'Nobody',
	"_is_ordered": false,
	"_health_variability": 10,
}


func _ready() -> void:
	active_effects.mod_effect(Terms.ACTIVE_EFFECTS.jumbletron.name, 1, false, false, ["Init"])

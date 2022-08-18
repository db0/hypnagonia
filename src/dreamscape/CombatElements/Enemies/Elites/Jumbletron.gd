extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "Jumbletron",
	"Rank": "Elite",
	"Health": 90,
	"Type": "Absurdity",
	"Damage": 0,
	"_texture_size_x": 180,
	"_texture_size_y": 180,
	"_character_art": 'Db0 via midjourney.com',
	"_is_ordered": false,
	"_health_variability": 10,
}


func _ready() -> void:
	active_effects.mod_effect(Terms.ACTIVE_EFFECTS.jumbletron.name, 1, false, false, ["Init"])

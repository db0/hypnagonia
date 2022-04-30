extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "Indescribable Absurdity",
	"Health": 180,
	"Type": "Absurdity",
	"Damage": 0,
	"_texture_size_x": 180,
	"_texture_size_y": 180,
	"_character_art": 'Artbreeder.com',
	"_is_ordered": false,
	"_health_variability": 5,
}


func _ready() -> void:
	var stacks: int
	match get_property("_difficulty"):
		"easy":
			stacks = 1
		"medium":
			stacks = 2
		"hard":
			stacks = 3
	active_effects.call_deferred("mod_effect", Terms.ACTIVE_EFFECTS.self_cleaning.name, stacks, false, false, ["Init"])

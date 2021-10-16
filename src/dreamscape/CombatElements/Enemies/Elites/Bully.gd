extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "The Bully",
	"Health": 80,
	"Type": "Context",
	"Damage": 0,
	"_texture_size_x": 150,
	"_texture_size_y": 150,
	"_character_art": 'Nobody',
	"_is_ordered": false,
	"_health_variability": 5,
}

func _ready() -> void:
	._ready()
	yield(get_tree().create_timer(0.1), "timeout")
	intents.prepare_intents(0)

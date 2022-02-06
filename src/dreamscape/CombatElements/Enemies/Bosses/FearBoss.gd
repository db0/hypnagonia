extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "Deepest Fear",
	"Health": 255,
	"Type": "Fear",
	"Damage": 0,
	"_texture_size_x": 160,
	"_texture_size_y": 160,
	"_character_art": 'Nobody',
	"_health_variability": 5,
}

func _ready() -> void:
	._ready()
	yield(get_tree().create_timer(0.1), "timeout")
	# warning-ignore:return_value_discarded
	intents.prepare_intents(0)

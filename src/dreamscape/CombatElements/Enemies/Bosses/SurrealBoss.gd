extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "Surreality",
	"Health": 400,
	"Type": "Absurdity",
	"Damage": 0,
	"_texture_size_x": 160,
	"_texture_size_y": 160,
	"_character_art": 'Silberfarben via Artbreeder.com',
	"_health_variability": 5,
}

func _ready() -> void:
	active_effects.mod_effect(Terms.ACTIVE_EFFECTS.surreal_boss.name, 1, false, false, ["Init"])
	# warning-ignore:return_value_discarded
	connect("entity_damaged",self, "on_damage_taken")
	
func on_damage_taken(_entity, amount, _trigger, _tags):
	if amount >= 10:
		active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, 1, false, false, ["Scripted"]) 

func _on_enemy_turn_started(_turn: Turn) -> void:
	._on_enemy_turn_started(_turn)


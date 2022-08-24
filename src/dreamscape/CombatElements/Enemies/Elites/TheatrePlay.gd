extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "Theatre Play",
	"Rank": "Elite",
	"Health": 168,
	"Type": "Fear",
	"Damage": 0,
	"_texture_size_x": 180,
	"_texture_size_y": 180,
	"_character_art": 'Delapouite',
	"_is_ordered": true,
	"_health_variability": 8,
}


func _ready() -> void:
	cfc.NMAP.board.connect("enemy_spawned", self, "_on_enemy_spawned")
	var spawn_act = [
		{
			"name": "spawn_enemy",
			"enemy": EnemyDefinitions.THEATRE_ACT,
			"object_count": 2,
			"starting_effects": [
				{
					"name": Terms.ACTIVE_EFFECTS.act_length.name,
					"stacks": 3,
				},
			],
			"set_spawn_as_minion": true,
			"tags": ['init'],
		}
	]
	intents.execute_special_script(spawn_act, self, self)
	
func _on_enemy_spawned(torment: CombatEntity) -> void:
	if not torment.canonical_name == 'Theatre Act':
		return
	# warning-ignore:return_value_discarded
	torment.connect("entity_killed", self, "_on_theatre_act_overcome")

func _on_theatre_act_overcome(final_damage: int, final_health: int) -> void:
	if final_damage >= final_health:
		set_damage(damage + 10)

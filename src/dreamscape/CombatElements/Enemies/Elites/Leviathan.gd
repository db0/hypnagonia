extends AdvancedEnemyEntity

const PROPERTIES := {
	"name": "Leviathan",
	"Rank": "Elite",
	"Health": 70,
	"Type": "Existential",
	"Damage": 0,
	"_texture_size_x": 160,
	"_texture_size_y": 160,
	"_character_art": 'Silberfarben via midjourney.com',
	"_is_ordered": true,
	"_health_variability": 7,
}

func _ready() -> void:
#	._ready()
	match get_property("_difficulty"):
		"easy":
			health -= 20
		"hard":
			health += 20
	cfc.NMAP.board.connect("enemy_spawned", self, "_on_enemy_spawned")
	var spawn_act = [
		{
			"name": "spawn_enemy",
			"enemy": EnemyDefinitions.IMMOBILITY,
			"object_count": 2,
			"set_spawn_as_minion": true,
			"tags": ['init'],
		}
	]
	intents.execute_special_script(spawn_act, self, self)

func _on_enemy_spawned(torment: CombatEntity) -> void:
	cfc.NMAP.board.disconnect("enemy_spawned", self, "_on_enemy_spawned")
	get_parent().move_child(self, 1)

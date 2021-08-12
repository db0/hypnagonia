extends CombatEffect

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		enemy.connect("effect_modified", self, "on_enemy_effect_added")
	
func on_enemy_effect_added(_entity: CombatEntity, _trigger: String, details: Dictionary) -> void:
	if details["effect_name"] == Terms.ACTIVE_EFFECTS.poison.name\
		and details[SP.TRIGGER_PREV_COUNT] < details[SP.TRIGGER_NEW_COUNT]:
			var multiplier := 2
			if upgrade == "completely":
				multiplier = 3
			cfc.NMAP.board.dreamer.defence += stacks * multiplier

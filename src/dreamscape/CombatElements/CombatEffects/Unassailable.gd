extends CombatEffect

const _description_string := "{effect_name}: Whenever you apply Doubt, gain 1 {defence}."


func _ready() -> void:
	description_string = _description_string
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		enemy.connect("effect_modified", self, "on_enemy_effect_added")
	
func on_enemy_effect_added(entity: CombatEntity, trigger: String, details: Dictionary) -> void:
	if details["effect_name"] == Terms.ACTIVE_EFFECTS.poison\
		and details[SP.TRIGGER_PREV_COUNT] < details[SP.TRIGGER_NEW_COUNT]:
			cfc.NMAP.board.dreamer.defence += 1

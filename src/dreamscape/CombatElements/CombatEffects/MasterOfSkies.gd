extends CombatEffect

const _description_string := "{effect_name}: Whenever you Gain Untouchable, gain 1 {energy}."


func _ready() -> void:
	description_string = _description_string
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		cfc.NMAP.board.dreamer.connect("effect_modified", self, "on_dreamer_effect_added")
	
func on_dreamer_effect_added(entity: CombatEntity, trigger: String, details: Dictionary) -> void:
	if details["effect_name"] == Terms.ACTIVE_EFFECTS.impervious\
		and details[SP.TRIGGER_PREV_COUNT] < details[SP.TRIGGER_NEW_COUNT]:
			cfc.NMAP.board.counters.mod_counter("immersion", 1, false, false, self, ["Effect"])

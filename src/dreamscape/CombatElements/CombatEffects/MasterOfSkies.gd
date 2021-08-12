extends CombatEffect

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		cfc.NMAP.board.dreamer.connect("effect_modified", self, "on_dreamer_effect_added")
	
func on_dreamer_effect_added(_entity: CombatEntity, _trigger: String, details: Dictionary) -> void:
	if details["effect_name"] == Terms.ACTIVE_EFFECTS.impervious.name\
		and details[SP.TRIGGER_PREV_COUNT] < details[SP.TRIGGER_NEW_COUNT]:
			var amount = stacks
			if upgrade == 'glorious':
				amount *= 2
			cfc.NMAP.board.counters.mod_counter("immersion", amount, false, false, self, ["Effect"])

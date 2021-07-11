extends CombatEffect

func _ready() -> void:
	cfc.NMAP.board.dreamer.connect("entity_attacked", self, "_on_dreamer_attacked")
	
func _on_dreamer_attacked(_dreamer, _amount, trigger: CombatEntity) -> void:
	if trigger and trigger.is_in_group("EnemyEntities"):
		trigger.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison.name, 1)

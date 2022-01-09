extends CombatEffect

func _ready() -> void:
	cfc.NMAP.board.dreamer.connect("entity_attacked", self, "_on_dreamer_attacked")
	
func _on_dreamer_attacked(_dreamer, _amount, trigger: CombatEntity, _tags: Array) -> void:
	if trigger and trigger.is_in_group("EnemyEntities"):
		var multiplier : int = cfc.card_definitions[name]\
				.get("_amounts",{}).get("concentration_stacks")
		var amount = stacks * multiplier
		trigger.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison.name, amount)

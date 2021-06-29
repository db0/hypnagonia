extends CombatEffect

const _description_string := "{effect_name}: After a {enemy} {opponent_attack} the {entity}, it gains 1 Doubt."


func _ready() -> void:
	description_string = _description_string
	cfc.NMAP.board.dreamer.connect("entity_attacked", self, "_on_dreamer_attacked")
	
func _on_dreamer_attacked(dreamer, amount, trigger: CombatEntity) -> void:
	if trigger and trigger.is_in_group("EnemyEntities"):
		trigger.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.poison, 1)

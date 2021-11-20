extends Artifact

func _ready() -> void:
	cfc.NMAP.board.dreamer.connect("effect_modified", self, "_on_effect_modified")

func _on_effect_modified(
		_entity, _trigger: String, details: Dictionary) -> void:
	if details.get("effect_name") == Terms.ACTIVE_EFFECTS.impervious.name\
			and details.get(SP.TRIGGER_NEW_COUNT) > 0:
		details.effect_node.decrease_type = CombatEffect.DECREASE_TYPE.HALVE

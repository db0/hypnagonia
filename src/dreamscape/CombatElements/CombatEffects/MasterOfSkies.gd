extends CombatEffect

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		cfc.NMAP.board.dreamer.connect("effect_modified", self, "on_dreamer_effect_added")
	
func on_dreamer_effect_added(entity: CombatEntity, _trigger: String, details: Dictionary) -> void:
	if details["effect_name"] == Terms.ACTIVE_EFFECTS.impervious.name\
		and details[SP.TRIGGER_PREV_COUNT] < details[SP.TRIGGER_NEW_COUNT]:
			var amount = stacks
			var mastery = [
				{
					"name": "apply_effect",
					"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
					"subject": "dreamer",
					"modification": stacks * cfc.card_definitions[name]\
					.get("_amounts",{}).get("effect_stacks", 1),
				},
			]
			execute_script(mastery, entity)

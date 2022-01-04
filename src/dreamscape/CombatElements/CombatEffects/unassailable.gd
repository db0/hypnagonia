extends CombatEffect

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		enemy.connect("effect_modified", self, "on_enemy_effect_added")
	
func on_enemy_effect_added(_entity: CombatEntity, _trigger: String, details: Dictionary) -> void:
	if details["effect_name"] == Terms.ACTIVE_EFFECTS.poison.name\
		and details[SP.TRIGGER_PREV_COUNT] < details[SP.TRIGGER_NEW_COUNT]:
			var multiplier : int = cfc.card_definitions[name]\
					.get("_amounts",{}).get("effect_defence")
			var unassailable = [{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": stacks * multiplier,
						"tags": ["Combat Effect", "Concentration"],
					}]
			execute_script(unassailable)

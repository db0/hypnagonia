extends CombatEffect

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		enemy.connect("effect_modified", self, "on_enemy_effect_added")
	
func on_enemy_effect_added(entity: CombatEntity, _trigger: String, details: Dictionary) -> void:
	if details["effect_name"] == Terms.ACTIVE_EFFECTS.disempower.name\
		and details[SP.TRIGGER_PREV_COUNT] < details[SP.TRIGGER_NEW_COUNT]:
			var base_amount = 4
			if upgrade == "total":
				base_amount = 6
			var absurdity = [{
				"name": "modify_damage",
				"subject": "trigger",
				"amount": base_amount * stacks,
				"tags": ["Attack"],
			}]
			execute_script(absurdity, entity)

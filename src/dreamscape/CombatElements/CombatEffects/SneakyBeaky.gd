extends CombatEffect

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		enemy.connect("entity_damaged", self, "_on_entity_damaged")
	
func _on_entity_damaged(entity, _amount, _trigger: Node, tags: Array) -> void:
	
	if entity.type == Terms.PLAYER:
		return
	if not "Attack" in tags:
		return
	var beak = [{
		"name": "apply_effect",
		"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
		"subject": "trigger",
		"modification": cfc.card_definitions[name]\
			.get("_amounts",{}).get("effect_stacks") * stacks,
	}]
	execute_script(beak, entity)

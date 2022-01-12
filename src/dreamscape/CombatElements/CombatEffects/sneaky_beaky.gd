extends CombatEffect

func _ready() -> void:
	for enemy in get_tree().get_nodes_in_group("EnemyEntities"):
		_connect_entity_signals(enemy)
	cfc.NMAP.board.connect("enemy_spawned", self, "_connect_entity_signals")
	
func _on_entity_damaged(entity, _amount, _trigger: Node, tags: Array) -> void:
	if entity.type == Terms.PLAYER:
		return
	if not ("Attack" in tags and ("Card" in tags or "Memory" in tags)):
		return
	var beak = [{
		"name": "apply_effect",
		"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
		"subject": "trigger",
		"modification": cfc.card_definitions[name]\
			.get("_amounts",{}).get("concentration_stacks") * stacks,
		"tags": ["Combat Effect", "Concentration"],
	}]
	execute_script(beak, entity)


func _connect_entity_signals(enemy: EnemyEntity) -> void:
	# warning-ignore:return_value_discarded
	enemy.connect("entity_damaged", self, "_on_entity_damaged")

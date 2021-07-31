extends CombatEffect

func _ready():
	owning_entity.connect("entity_attacked", self, "_on_entity_attacked")

func _on_entity_attacked(_entity, _amount, trigger: Node, _tags: Array) -> void:
	if trigger.is_in_group("cards"):
		trigger = cfc.NMAP.board.dreamer
	if (entity_type == Terms.PLAYER 
			and trigger 
			and trigger.is_in_group("EnemyEntities"))\
	or (entity_type == Terms.ENEMY 
			and trigger 
			and trigger.is_in_group("PlayerEntities")):
		trigger.modify_damage(stacks, false, ["Effect", "Blockable", "Thorns"], owning_entity)

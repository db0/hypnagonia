extends CombatEffect

var trigger_count := 0

func _ready():
# warning-ignore:return_value_discarded
	owning_entity.connect("entity_attacked", self, "_on_entity_attacked")

func _on_entity_attacked(entity, _amount, _trigger: Node, _tags: Array) -> void:
	trigger_count += 1
	var plushiness = [
		{
			"name": "assign_defence",
			"subject": "trigger",
			"amount": stacks * trigger_count,
			"tags": ["Combat Effect", "Concentration"],
		},
	]
	execute_script(plushiness, entity)

func _on_player_turn_started(_turn: Turn) -> void:
	trigger_count = 0

func _on_enemy_turn_started(_turn: Turn) -> void:
	trigger_count = 0

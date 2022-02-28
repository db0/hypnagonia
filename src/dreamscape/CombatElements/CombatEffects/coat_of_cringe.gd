extends CombatEffect

func _ready() -> void:
	owning_entity.connect("entity_attacked", self, "_on_entity_attacked")
	
func _on_entity_attacked(_dreamer, _amount, trigger: CombatEntity, _tags: Array) -> void:
	var perturb_task := [{
			"name": "perturb",
			"card_name": "Cringeworthy Memory",
			"dest_container": "deck",
			"object_count": stacks,
			"tags": ["Intent"],
	}]
	execute_script(perturb_task, trigger)

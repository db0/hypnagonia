extends CombatEffect


func _ready() -> void:
	scripting_bus.connect("scripting_event_triggered", self, "_on_scripting_event_triggered")



func _on_scripting_event_triggered(trigger_card, trigger, _details) -> void:
	if trigger == "card_played"\
			and trigger_card.get_property("Type") == "Understanding":
		var perturb_task := [{
				"name": "perturb",
				"card_name": "Lacuna",
				"dest_container": "discard",
				"object_count": stacks,
				"tags": ["Intent"],
		}]
		execute_script(perturb_task, trigger_card)

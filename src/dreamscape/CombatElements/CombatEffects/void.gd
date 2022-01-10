extends CombatEffect


func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")



func _on_cfc_signal_received(trigger_card, trigger, _details) -> void:
	if trigger == "card_played"\
			and trigger_card.get_property("Type") == "Understanding":
		var perturb_task := [{
				"name": "perturb",
				"card_name": "Lacuna",
				"dest_container": "discard",
				"object_count": 2,
				"tags": ["Intent"],
		}]
		execute_script(perturb_task, trigger_card)

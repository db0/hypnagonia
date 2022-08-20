extends CombatEffect

func _ready() -> void:
	scripting_bus.connect("scripting_event_triggered", self, "_on_scripting_event_triggered")

func _on_scripting_event_triggered(trigger_card, trigger, _details) -> void:
	if trigger == "card_played"\
			and trigger_card.get_property("Type") == "Understanding"\
			and trigger_card.deck_card_entry:
		trigger_card.deck_card_entry.scar()

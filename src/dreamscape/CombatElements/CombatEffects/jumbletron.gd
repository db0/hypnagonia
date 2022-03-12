extends CombatEffect

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")

func _on_cfc_signal_received(trigger_card, trigger, _details) -> void:
	if trigger == "card_played"\
			and trigger_card.get_property("Type") == "Understanding"\
			and trigger_card.deck_card_entry:
		trigger_card.deck_card_entry.scar()

extends CombatEffect

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")

func _on_cfc_signal_received(
		trigger_card: Card, trigger: String, _details: Dictionary) -> void:
	if trigger == "card_played" and trigger_card.get_property("Type") == "Control":
		var amount = stacks
		owning_entity.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, amount)

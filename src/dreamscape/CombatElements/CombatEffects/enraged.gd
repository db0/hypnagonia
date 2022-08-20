extends CombatEffect

func _ready() -> void:
	scripting_bus.connect("scripting_event_triggered", self, "_on_scripting_event_triggered")

func _on_scripting_event_triggered(
		trigger_card: Card, trigger: String, _details: Dictionary) -> void:
	if trigger == "card_played" and trigger_card.get_property("Type") == "Control":
		var amount = stacks
		owning_entity.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, amount)

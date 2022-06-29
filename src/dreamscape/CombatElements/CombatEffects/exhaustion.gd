extends CombatEffect

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")

func _on_cfc_signal_received(trigger_card, trigger, details) -> void:
	if stacks <= 0:
		return
	if trigger != "card_moved_to_pile":
		return
	if details.destination.to_lower() != "discard":
		return
	if not "Played" in details.tags:
		return
	if "Exhaustion" in details.tags:
		return
	var script := [
		{
			"name": "autoplay_card",
			"subject": "trigger",
			"tags": ["Combat Effect", "Concentration", "Exhaustion"],
		},
		{
			"name": "move_card_to_container",
			"subject": "trigger",
			"dest_container": "forgotten",
			"tags": ["Combat Effect", "Concentration"],
		},
	]
	execute_script(script,trigger_card)
	set_stacks(stacks - 1)

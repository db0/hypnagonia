extends CombatEffect


func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")



func _on_cfc_signal_received(trigger_card, trigger, details) -> void:
	if trigger != "counter_modified":
		return
	if "New Turn" in details.tags:
		return
	if details.previous_count >= details.new_count:
		return
	var diff = details.new_count - details.previous_count
	var script := [
		{
			"name": "assign_defence",
			"tags": ["Card"],
			"subject": "self",
			"amount": 10 * diff,
		},
		{
			"name": "apply_effect",
			"tags": ["Card"],
			"effect_name": Terms.ACTIVE_EFFECTS.strengthen.name,
			"subject": "self",
			"modification":  stacks,
		},
	]
	execute_script(script, trigger_card)

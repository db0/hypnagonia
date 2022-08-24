extends CombatEffect


func _ready() -> void:
	scripting_bus.connect("scripting_event_triggered", self, "_on_scripting_event_triggered")



func _on_scripting_event_triggered(trigger_card, trigger, details) -> void:
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

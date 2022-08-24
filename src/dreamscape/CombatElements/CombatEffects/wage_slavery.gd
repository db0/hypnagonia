extends CombatEffect

var filter := DreamCardFilter.new("Type", "Control")

func _ready() -> void:
	add_to_group("scriptables")
	scripting_bus.connect("scripting_event_triggered", self, "_on_scripting_event_triggered")

func _on_scripting_event_triggered(trigger_card, trigger, details) -> void:
	if trigger != "card_moved_to_pile":
		return
	if not "Played" in details.tags:
		return
	if not filter.check_card(trigger_card.properties):
		return
	var script := [
		{
			"name": "move_card_to_container",
			"subject": "trigger",
			"dest_container": "forgotten",
			"tags": ["Combat Effect", "Concentration", "Wage Slavery"],
		},
	]
	execute_script(script,trigger_card)


func retrieve_scripts(trigger: String) -> Dictionary:
	if trigger != SP.KEY_ALTERANTS:
		return({})
	var alterant := {
		"discount": [
			{
				"filter_task": "get_property",
				"filter_property_name": "Cost",
				"alteration": -3,
				"filter_state_trigger": [
					{"filter_cardfilters": [filter]}
				],
			},
		]
	}
	return(alterant)


func get_state_exec() -> String:
	return("discount")


func execute_scripts(_trigger_card,_trigger,_details) -> void:
	return

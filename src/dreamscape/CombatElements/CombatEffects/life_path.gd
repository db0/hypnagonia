extends CombatEffect

func _ready() -> void:
	cfc.signal_propagator.connect("signal_received", self, "_on_cfc_signal_received")

func _get_effect_description() -> String:
	var default_desc : String
	match upgrade:
		'Active':
			default_desc = "{effect_name}: Any time the dreamer plays an {action} card, they take {amount} {anxiety}"
		'Controlling':
			default_desc = "{effect_name}: Any time the dreamer plays a {control} card, all torments decrease their {interpretation} by {amount} and this torment gains {amount} {protection}."
		'Focused':
			default_desc = "{effect_name}: Any time the dreamer plays a {concentration} card, this tormen gains {amount} {strengthen}"
	return(default_desc)

func _on_cfc_signal_received(
		trigger_card: Card, trigger: String, _details: Dictionary) -> void:
	if trigger == "card_played":
		var amount = stacks
		if trigger_card.get_property("Type") == "Action" and upgrade == "Active":
			var script = [{
						"name": "modify_damage",
						"subject": "dreamer",
						"amount": stacks,
						"tags": ["Combat Effect", "Blockable"],
					}]
			execute_script(script)
		elif trigger_card.get_property("Type") == "Control" and upgrade == "Controlling":
			owning_entity.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.protection.name, amount)
			var script = [{
						"name": "modify_damage",
						"subject": "boardseek",
						"subject_count": "all",
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						},],
						"amount": -stacks,
						"tags": ["Combat Effect", "Healing"],
					}]
			execute_script(script)
		elif trigger_card.get_property("Type") == "Concentration" and upgrade == "Focused":
			owning_entity.active_effects.mod_effect(Terms.ACTIVE_EFFECTS.strengthen.name, amount)

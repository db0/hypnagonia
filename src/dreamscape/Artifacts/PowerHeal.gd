extends Artifact


func execute_scripts(
		trigger_card: Card = null,
		trigger: String = "manual",
		trigger_details: Dictionary = {},
		only_cost_check := false):
	if is_active\
			and effect_context == ArtifactDefinitions.EffectContext.BATTLE\
			and trigger == "card_played"\
			and trigger_card.get_property("Type") == "Concentration":
		var script = [
			{
				"name": "modify_damage",
				"subject": "dreamer",
				"amount": -ArtifactDefinitions.PowerHeal.amounts.healing_amount,
				"tags": ["Healing", "Curio"],
			},
		]
		execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

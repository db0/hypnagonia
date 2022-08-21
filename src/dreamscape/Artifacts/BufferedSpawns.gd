extends Artifact

func execute_scripts(
		trigger_card: Card = null,
		trigger: String = "manual",
		trigger_details: Dictionary = {},
		only_cost_check := false):
	if is_active\
			and effect_context == ArtifactDefinitions.EffectContext.BATTLE\
			and trigger == "card_spawned"\
			and trigger_card.get_property("Type") == "Perturbation":
		print_debug(trigger_details)
		var script = [
			{
				"name": "apply_effect",
				"tags": ["Card"],
				"effect_name": Terms.ACTIVE_EFFECTS.buffer.name,
				"subject": "dreamer",
				"modification": ArtifactDefinitions.BufferedSpawns.amounts.effect_stacks,
			}
		]
		execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

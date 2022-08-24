extends Artifact

func execute_scripts(
		trigger_card: Card = null,
		trigger: String = "manual",
		trigger_details: Dictionary = {},
		only_cost_check := false):
	if is_active\
			and effect_context == ArtifactDefinitions.EffectContext.BATTLE\
			and trigger == "card_played"\
			and Terms.GENERIC_TAGS.startup.name in trigger_card.get_property("Tags"):
		var script = [
			{
				"name": "draw_cards",
				"card_count": ArtifactDefinitions.StartupDraw.amounts.draw_amount,
				"tags": ["Curio"],
			},
		]
		execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

extends Artifact

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		scripting_bus.connect("battle_begun", self, "_on_battle_start")

func setup(signifier_details: Dictionary, signifier_name: String):
	.setup(signifier_details,signifier_name)
	update_amount(artifact_object.counter)

func _on_battle_start():
	if not _activate():
		return
	var script = [
		{
			"name": "apply_effect",
			"effect_name": Terms.ACTIVE_EFFECTS.quicken.name,
			"subject": "dreamer",
			"modification": amount,
			"tags": ["Curio"],
		},
	]
	execute_script(script)


func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

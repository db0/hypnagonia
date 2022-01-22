extends Artifact

func _on_artifact_added() -> void:
	globals.player.pathos.repress_pathos(
			Terms.RUN_ACCUMULATION_NAMES.nce,
			ArtifactDefinitions.AccumulateNCE.amounts.pathos_amount)
	_send_trigger_signal()

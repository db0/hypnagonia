extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]
	pathos_type.repressed += ArtifactDefinitions.AccumulateArtifact.amounts.pathos_amount
	_send_trigger_signal()

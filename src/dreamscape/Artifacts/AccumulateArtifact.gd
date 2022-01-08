extends Artifact

func _on_artifact_added() -> void:
	globals.player.pathos.repress_pathos(
			Terms.RUN_ACCUMULATION_NAMES.artifact,
			ArtifactDefinitions.AccumulateArtifact.amounts.pathos_amount)

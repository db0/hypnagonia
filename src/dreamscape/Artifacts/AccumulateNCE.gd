extends Artifact

func _on_artifact_added() -> void:
	globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.nce] +=\
			ArtifactDefinitions.AccumulateNCE.amounts.pathos_amount

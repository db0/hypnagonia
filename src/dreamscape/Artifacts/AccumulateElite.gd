extends Artifact

func _on_artifact_added() -> void:
	globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.elite] +=\
			ArtifactDefinitions.AccumulateElite.amounts.pathos_amount

extends Artifact

func _on_artifact_added() -> void:
	globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.shop] +=\
			ArtifactDefinitions.AccumulateShop.amounts.pathos_amount

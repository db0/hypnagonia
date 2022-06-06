extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]
	pathos_type.repressed += ArtifactDefinitions.AccumulateNCE.amounts.pathos_amount
	globals.player.health += ArtifactDefinitions.AccumulateNCE.amounts.anxiety_amount
	_send_trigger_signal()

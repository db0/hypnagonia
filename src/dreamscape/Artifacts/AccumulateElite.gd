extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]
	pathos_type.repressed += ArtifactDefinitions.AccumulateElite.amounts.pathos_amount
	globals.player.health += ArtifactDefinitions.AccumulateElite.amounts.anxiety_amount
	_send_trigger_signal()

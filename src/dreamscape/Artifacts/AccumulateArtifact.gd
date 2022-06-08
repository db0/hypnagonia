extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]
	pathos_type.repressed += pathos_type.get_progression_average()\
			* ArtifactDefinitions.AccumulateArtifact.amounts.pathos_avg_multiplier
	_send_trigger_signal()

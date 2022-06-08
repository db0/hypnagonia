extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.rest]
	pathos_type.repressed += pathos_type.get_progression_average()\
			* ArtifactDefinitions.AccumulateRest.amounts.pathos_avg_multiplier
	_send_trigger_signal()

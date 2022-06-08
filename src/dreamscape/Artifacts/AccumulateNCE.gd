extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]
	pathos_type.repressed += pathos_type.get_progression_average()\
			* ArtifactDefinitions.AccumulateNCE.amounts.pathos_avg_multiplier
	globals.player.health += ArtifactDefinitions.AccumulateNCE.amounts.anxiety_amount
	_send_trigger_signal()

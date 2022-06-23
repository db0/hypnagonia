extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]
	pathos_type.masteries_when_chosen +=  ArtifactDefinitions.FasterArtifactLevelUp.amounts.masteries_amount
	_send_trigger_signal()

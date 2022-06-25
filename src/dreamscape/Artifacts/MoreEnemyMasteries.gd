extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]
	pathos_type.masteries_when_chosen +=  ArtifactDefinitions.MoreEnemyMasteries.amounts.masteries_amount
	_send_trigger_signal()

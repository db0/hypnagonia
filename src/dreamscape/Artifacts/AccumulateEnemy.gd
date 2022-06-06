extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]
	pathos_type.repressed += ArtifactDefinitions.AccumulateEnemy.amounts.pathos_amount
	globals.player.damage -= ArtifactDefinitions.AccumulateEnemy.amounts.relax_amount
	_send_trigger_signal()

extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.shop]
	pathos_type.repressed += ArtifactDefinitions.AccumulateShop.amounts.pathos_amount
	_send_trigger_signal()

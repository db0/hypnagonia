extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.shop]
	pathos_type.masteries_when_chosen +=  ArtifactDefinitions.FasterShopLevelUp.amounts.masteries_amount
	_send_trigger_signal()

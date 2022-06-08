extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]
	pathos_type.perm_modify_requirements_for_level(
			ArtifactDefinitions.FasterArtifactLevelUp.amounts.level_req_amount)
	_send_trigger_signal()
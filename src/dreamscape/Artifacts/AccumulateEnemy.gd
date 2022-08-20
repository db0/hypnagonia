extends Artifact

func _on_artifact_added() -> void:
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]
	pathos_type.repressed += pathos_type.get_progression_average()\
			* ArtifactDefinitions.AccumulateEnemy.amounts.pathos_avg_multiplier
	globals.player.damage -= ArtifactDefinitions.AccumulateEnemy.amounts.heal_amount
	_send_trigger_signal()

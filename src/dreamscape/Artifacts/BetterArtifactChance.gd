extends Artifact

func get_global_alterant(_value, alterant_type: int):
	if is_active:
		if alterant_type == HConst.AlterantTypes.ARTIFACT_RARE_CHANCE:
			return(ArtifactDefinitions.BetterArtifactChance.amounts.rare_multiplier)
		if alterant_type == HConst.AlterantTypes.ARTIFACT_UNCOMMON_CHANCE:
			return(ArtifactDefinitions.BetterArtifactChance.amounts.uncommon_multiplier)

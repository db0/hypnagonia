extends Artifact

func get_global_alterant(_value, alterant_type: int):
	if is_active and alterant_type == HConst.AlterantTypes.CARD_RARE_CHANCE:
		return(ArtifactDefinitions.BetterRareChance.amounts.rare_multiplier)

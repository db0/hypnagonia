extends Artifact

func get_global_alterant(_value, alterant_type: int):
	if is_active and alterant_type == HConst.AlterantTypes.CARD_UPGRADE_CHANCE:
		return(ArtifactDefinitions.IncreaseUpgradedDraftChance.amounts.chance_multiplier)

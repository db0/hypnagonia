extends Memory

func execute_memory_effect():
	var pathos_type : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.boss]
	pathos_type.repressed += ArtifactDefinitions.BossFaster.amounts.pathos_amount
	_send_trigger_signal()

func get_global_alterant(_value, alterant_type: int):
	if artifact_object.is_ready:
		return
	if not alterant_type in [HConst.AlterantTypes.CARD_RARE_CHANCE, HConst.AlterantTypes.ARTIFACT_RARE_CHANCE]:
		return
	return(MemoryDefinitions.BossFaster.amounts.rare_multiplier)

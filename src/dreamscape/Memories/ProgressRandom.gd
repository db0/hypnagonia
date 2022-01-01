extends Memory

func execute_memory_effect():
	var upgrades = artifact_object.upgrades_amount * MemoryDefinitions.ProgressRandom.amounts.upgrade_multiplier
	var progressing_cards = globals.player.deck.get_progressing_cards()
	CFUtils.shuffle_array(progressing_cards)
	if progressing_cards.size():
		progressing_cards[0].upgrade_progress += 2 + upgrades

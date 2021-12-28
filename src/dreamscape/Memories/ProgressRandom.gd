extends Memory

func execute_memory_effect() -> void:
	var progressing_cards = globals.player.deck.get_progressing_cards()
	CFUtils.shuffle_array(progressing_cards)
	progressing_cards[0].upgrade_progress += 2

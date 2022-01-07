extends Memory

func execute_memory_effect():
	var all_perturbations := globals.player.deck.filter_cards(CardFilter.new("Type","Perturbation"))
	if all_perturbations.size() > 0:
		CFUtils.shuffle_array(all_perturbations)
		globals.player.deck.remove_card(all_perturbations.pop_back())
	

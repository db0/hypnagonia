extends Memory

func execute_memory_effect():
	var card_filters := [
		CardFilter.new("Type","Perturbation"),
		CardFilter.new("_is_unremovable", false),
	]
	var all_perturbations := globals.player.deck.filter_cards(card_filters)
	if all_perturbations.size() > 0:
		CFUtils.shuffle_array(all_perturbations)
		globals.player.deck.remove_card(all_perturbations.pop_back())
	_send_trigger_signal()

extends Artifact

func _on_artifact_added() -> void:
	var costly_cards = globals.player.deck.filter_cards('Cost', 1, 'ge')
	if costly_cards.size() > 0:
		CFUtils.shuffle_array(costly_cards)
		var chosen_card : CardEntry = costly_cards.pop_back()
		chosen_card.modify_property('Cost', 0)

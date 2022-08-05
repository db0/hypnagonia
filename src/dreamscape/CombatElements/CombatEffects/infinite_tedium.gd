extends CombatEffect

func _ready() -> void:
	for c in cfc.get_tree().get_nodes_in_group("cards"):
		var card: DreamCard = c
		if card.state == card.CardState.PREVIEW:
			continue
		if card.state == card.CardState.DECKBUILDER_GRID:
			continue
		if card.state == card.ExtendedCardState.REMOVE_FROM_GAME:
			continue
		if card.get_property("_rarity") != "Basic":
			card.modify_property("Tags", Terms.GENERIC_TAGS.once_off.name)
			card.refresh_card_front()

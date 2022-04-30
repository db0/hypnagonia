extends CombatEffect

func _ready() -> void:
	for card in cfc.get_tree().get_nodes_in_group("cards"):
		if card.get_property("_rarity") != "Basic":
			card.modify_property("Tags", Terms.GENERIC_TAGS.once_off.name)
			card.refresh_card_front()

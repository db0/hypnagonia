extends Artifact

var modified_card: CardEntry

func _on_artifact_added() -> void:
	var costly_cards = globals.player.deck.filter_cards('Cost', 1, 'ge')
	if costly_cards.size() > 0:
		CFUtils.shuffle_array(costly_cards)
		modified_card = costly_cards.pop_back()
		modified_card.modify_property('Cost', 0)
		modified_card.upgrade_progress = modified_card.upgrade_threshold
#	globals.player.deck.connect("card_upgrade_started", self, "on_card_upgrade_started")
	globals.player.deck.connect("card_upgrade_ended", self, "on_card_upgrade_ended")

func on_card_upgrade_ended(old_card: CardEntry, new_card: CardEntry) -> void:
	if old_card == modified_card:
		modified_card = new_card
		modified_card.modify_property('Cost', 0)
		

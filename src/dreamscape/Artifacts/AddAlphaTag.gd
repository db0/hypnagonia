extends Artifact

func _on_artifact_added() -> void:
	var costly_cards = globals.player.deck.cards
	var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
	selection_deck.connect("operation_performed", self, "_on_card_selected")
	selection_deck.auto_close = true
	selection_deck.initiate_card_selection(0)
	selection_deck.update_header("Choose card which should always start at the top of the deck."\
			.format(Terms.get_bbcode_formats(18)))
	selection_deck.update_color(Color(0,1,0))

func _on_card_selected(operation_details: Dictionary) -> void:
	var chosen_card: CardEntry = operation_details.card_entry
	chosen_card.modify_property('Tags', Terms.GENERIC_TAGS.alpha.name)

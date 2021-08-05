extends ViewportCardFocus

# Overridable function for games to extend preprocessing of dupe card
# before adding it to the scene
func _extra_dupe_preparation(dupe_focus: Card, card: Card) -> void:
	._extra_dupe_preparation(dupe_focus, card)
	dupe_focus.deck_card_entry = card.deck_card_entry

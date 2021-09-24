extends DreamPile

# We use this for effects which care about the amount of cards
# we had in the discard pile before we reshuffled it
var last_amount_pre_reshuffle

func reshuffle_in_deck():
	last_amount_pre_reshuffle = get_card_count()
	var deck : Pile = cfc.NMAP.deck
	for c in get_all_cards():
		c.move_to(deck)
		yield(get_tree().create_timer(0.05), "timeout")
	# Last card in, is the top card of the pile
	var last_card : Card = deck.get_top_card()
	if last_card and last_card._tween.is_active():
		yield(last_card._tween, "tween_all_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	deck.shuffle_cards()

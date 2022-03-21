extends Artifact

func _on_player_turn_started(_turn: Turn = null) -> void:
	if not _activate():
		return
	var card_filter = CardFilter.new("Tags", Terms.GENERIC_TAGS.startup.name)
	var startup_cards = globals.player.deck.filter_cards(card_filter)
	if not startup_cards.size():
		return
	CFUtils.shuffle_array(startup_cards)
	startup_cards.back().card_object.execute_scripts(self, 'battle_begun', {})
	_send_trigger_signal()

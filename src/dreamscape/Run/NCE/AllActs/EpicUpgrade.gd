extends NonCombatEncounter

const MAX_ANXIETY_LOSS := 30
const EPIC_AMOUNT = 4
const GAMBLE_AMOUNT = 4

var secondary_choices := {
		'epic': "[Epic Upgrade]: Lose {anxiety_loss} max {anxiety}. Choose a non-{concentration} card and Enhance it {epic_amount} times. (Enhancing randomly improves a card.)",
		'gamble': "[Gamble]: Choose a non-{concentration} card. Enhance it {gamble_amount} times then Scar it {gamble_amount} times (Scarring randomly degrades a card.).",
		'skip': "[Skip]: Release a random card from your deck.",
	}

var nce_result_fluff := {
		'epic': "",
		'gamble': "",
		'skip': "Card Removed: {selected_card}",
	}
var existing_memory

func _init():
	description = "<Epic Upgrade - Story Fluff to be Done>. Select one Option...."
#	prepare_journal_art(preload("res://assets/journal/nce/potted_plant.jpeg"))

func begin() -> void:
	.begin()
	var disabled_choices = []
	var scformat = {
		"anxiety_loss": MAX_ANXIETY_LOSS,
		"epic_amount": EPIC_AMOUNT,
		"gamble_amount": GAMBLE_AMOUNT,
	}
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	var ftformat = {}
	match key:
		"epic", "gamble":
			var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
			selection_deck.popup_exclusive = true
			# warning-ignore:return_value_discarded
			var card_filters = [CardFilter.new('Type', 'Concentration', 'ne')]
			selection_deck.card_filters = card_filters
			selection_deck.connect("operation_performed", self, "_on_card_selected", [key])
			selection_deck.auto_close = true
			selection_deck.initiate_card_selection(0)
			var select_blurb: String
			if key == "epic":
				select_blurb = "(Epically Enhance card)"
			else:
				select_blurb = "(Enhance and Scar card)"
			selection_deck.update_header(select_blurb)
			selection_deck.update_color(Color(0,1,0))
		"skip":
			var rng_card: CardEntry = globals.player.deck.get_random_card()
			ftformat["selected_card"] = _prepare_card_popup_bbcode(rng_card, rng_card.card_name)
			globals.player.deck.remove_card(rng_card)
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key].format(ftformat))


func _on_card_selected(operation_details: Dictionary, key: String) -> void:
	var chosen_card: CardEntry = operation_details.card_entry
	if key == "epic":
		globals.player.health -= MAX_ANXIETY_LOSS
		for iter in EPIC_AMOUNT:
			chosen_card.enhance()
	else:
		for iter in GAMBLE_AMOUNT:
			chosen_card.enhance()
			chosen_card.scar()

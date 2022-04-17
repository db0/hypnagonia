extends NonCombatEncounter

const MAX_ANXIETY_LOSS := 30
const EPIC_AMOUNT = 4
const GAMBLE_AMOUNT = 4

var secondary_choices := {
		'epic': '[Grow]: Lose {anxiety_loss} max {anxiety}. Choose a non-{concentration} card and [url={"definition": "enhance","meta_type": "definition"}]Enhance[/url] it {epic_amount} times.',
		'gamble': '[Dance]: Choose a non-{concentration} card. Enhance it {gamble_amount} times then [url={"definition": "scar","meta_type": "definition"}]Scar[/url] it {gamble_amount} times.',
		'skip': "[Skip]: Release a random card from your deck.",
	}

var nce_result_fluff := {
		'epic': "As I winced and looked past the hard times, I saw light in our future.",
		'gamble': "Scars are a testament to values of the past. Time is of the essence.",
		'skip': "I rejected my longing for oblivion and the strive for power. Mortality is a virtue.\n"\
				+ "Card Removed: {selected_card}",
	}
var existing_memory

func _init():
	description = """
The rays of energy surrounded me as I was swimming in the void. 
Each of them passesed right above my head, pressing me to make a choice for better or for worse.
I struggled to concentrate as the soft and electrifying colors dance around me within the darkness while I tasted their power dancing across my soul.
"""
#	prepare_journal_art(load("res://assets/journal/nce/potted_plant.jpeg"))

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
			selection_deck.initiate_card_selection()
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

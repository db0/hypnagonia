extends NonCombatEncounter

const COST_REDUCTION := 1

var secondary_choices := {
		'recipe': '[Troubleshoot recipe]: Remove an upgraded card. Gain a random uncommon or rare card fully progressed.',
		'map': '[Troubleshoot map]: Remove an upgraded card. Choose a card in your deck and gain an extra copy.',
		'ground': '[Troubleshoot ground]: Remove an upgraded card. Choose a card in your deck and reduce its cost by {cost_reduction}.',
		'support': '[Leave]: Nothing happens.',
	}

var nce_result_fluff := {
		'recipe': "I'm no cook, but I could at least check if there is a mistake in the recipe...\nAha! She used lead instead of sugar.",
		'map': "I'm no geographer, but I could at least check if she went to the wrong place...\nAha! She was holding it upside down.",
		'ground': "I'm no geologist, but I could at least check the ground consistency...\nAha! There was no ground, we were in free fall!",
		'support': "I checked the printer I came for and left. I told her to raise a ticket with the helpdesk for her cake issue.",
	}


func _init():
	description = "Her fist came down on the cupcake, squashing it flat.\n"\
			+ '"It\'s not good enough!" she yelled, not at me, but at the situation.\n'\
			+ "The maps on her desk showed that this part of the ground should have kept her cupcake warm, but it was cold.\n"\
			+ "Why on Earth was I here? I'm just the tech support."
#	prepare_journal_art(preload("res://assets/journal/nce/cockroach.jpeg"))

func begin() -> void:
	.begin()
	var scformat = {
		"cost_reduction": COST_REDUCTION,
	}
	var disabled_choices = []
	if globals.player.deck.count_upgraded_cards() == 0:
		disabled_choices.append('recipe')
		disabled_choices.append('map')
		disabled_choices.append('ground')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	if key != 'support':
		var card_filters = [CardFilter.new('_is_upgrade', true)]
		var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
		selection_deck.popup_exclusive = true
		# warning-ignore:return_value_discarded
		selection_deck.connect("operation_performed", self, "_on_upgraded_card_selected", [key])
		selection_deck.auto_close = true
		selection_deck.card_filters = card_filters
		selection_deck.initiate_card_selection(0)
		selection_deck.update_color(Color(0,1,0))
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

func _on_upgraded_card_selected(operation_details: Dictionary, key: String) -> void:
	var chosen_card: CardEntry = operation_details.card_entry
	globals.player.deck.remove_card(chosen_card)
	match key:
		"recipe":
			var rares := globals.player.compile_rarity_cards("Rare")
			var uncommon := globals.player.compile_rarity_cards("Uncommon")
			var both = rares + uncommon
			CFUtils.shuffle_array(both)
			var new_card : CardEntry = global.player.deck.add_card(both[0])
			new_card.upgrade_progress = new_card.upgrade_threshold
		"map", "ground":
			if key == "map":
				var select_blurb = "(Duplicate Card)"
			else:
				var select_blurb = "(Reduce cost by 1)"
			var selection_deck = globals.journal.spawn_selection_deck()
			selection_deck.auto_close = true
			selection_deck.initiate_card_selection(0)
			selection_deck.update_header(select_blurb)
			selection_deck.update_color(Color(0,1,0))
			selection_deck.connect("operation_performed", self, "_on_card_selected", [key])

func _on_card_selected(operation_details: Dictionary) -> void:
	var chosen_card: CardEntry = operation_details.card_entry
	if key == "map":
		global.player.deck.duplicate_card(chosen_card)
	else:
		chosen_card.modify_property("Cost", "-1", true)

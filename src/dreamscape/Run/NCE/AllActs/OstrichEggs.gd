extends NonCombatEncounter

const HUNGRY_AMOUNT = 2

var secondary_choices := {
		'scramble': "[Scrambled]: Enhance all basic {action} cards. Scar all basic {control} cards (Enhancing randomly improves a card. Scarring randomly degrades a card.)",
		'omelette': "[Omelette]: Enhance all basic {control} cards. Scar all basic {action} cards",
		'hungry': "[Hungry]: Scar {hungry_amount} random cards.",
	}

var nce_result_fluff := {
		'scramble': "I was in the mood for a risk. I threw in every pepper and chilli I could find. Little phoenix ostriches grew out of it and started kicking me!",
		'omelette': "As I started spreading the egg for an omelette, I realized those eggs were endless. In the end, I simply jumped in for a warm swim.",
		'hungry': "I couldn't bear to eat such a majestic embryo. My hunger made me jumpy and affected my future experiences. (Card Scarred: {selected_card0}. {selected_card1}.)",
	}
var existing_memory

func _init():
	description = "I was hungry but all I had was giant Ostrich eggs. I could not decide how to cook them."
	prepare_journal_art(load("res://assets/journal/nce/ostrich_eggs.jpeg"))

func begin() -> void:
	.begin()
	var disabled_choices = []
	var scformat = {
		"hungry_amount": HUNGRY_AMOUNT,
	}
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	var ftformat = {}
	var action_filters = [
		CardFilter.new('_rarity', 'Basic'),
		CardFilter.new('Type', 'Action'),
	]
	var control_filters = [
		CardFilter.new('_rarity', 'Basic'),
		CardFilter.new('Type', 'Control'),
	]
	var enhance_filters : Array
	var scar_filters : Array
	match key:
		"scramble", "omelette":
			if key == 'scramble':
				enhance_filters = action_filters
				scar_filters = control_filters
			else:
				enhance_filters = control_filters
				scar_filters = action_filters
			for card_entry in globals.player.deck.filter_cards(enhance_filters):
				card_entry.enhance()
			for card_entry in globals.player.deck.filter_cards(scar_filters):
				card_entry.scar()
		"hungry":
			for iter in HUNGRY_AMOUNT:
				var rng_card: CardEntry = globals.player.deck.get_random_card()
				ftformat["selected_card" + str(iter)] = _prepare_card_popup_bbcode(rng_card, rng_card.card_name)
				rng_card.scar()
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key].format(ftformat))

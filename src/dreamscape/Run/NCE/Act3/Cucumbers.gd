extends NonCombatEncounter

const RELAX_AMOUNT := 20
const journal_description = "I'd reached the pit of floating cucumbers again, "\
			+ 'but the rollerskate chickens were making good progress on their treadmills.'\
			+ 'There was no time to go around.\n'\
			+ "It would be an easy choice to jump in, if only I wasn't stark naked."


var secondary_choices := {
		'jump': '[Jump]: {bcolor:Scar a random card.:} {gcolor:{relax} for {relax_amount}:}.',
		'stand': '[Stand]: {bcolor:Scar a random card:}. {gcolor:Remove a card:}.',
	}

var nce_result_fluff := {
		'jump': "I cleched tight and decided to brave the slow fall through.",
		'stand': "As the clucking sounds were drowned by the sound of ceramic on hard plastic, I turned slowly and raised by fists.",
	}


func _init():
	introduction.setup_with_vars("Cucumbers",journal_description, "Into the Pit of Phallic Vegetables")
	prepare_journal_art(load("res://assets/journal/nce/Cucumbers.jpg"))

func begin() -> void:
	.begin()
	var scformat = {
		"relax_amount": RELAX_AMOUNT,
	}
	var disabled_choices = []
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	var rng_card = globals.player.deck.get_random_card()
	rng_card.scar()
	if key == 'stand':
		var selection_deck = globals.journal.spawn_selection_deck()
		selection_deck.auto_close = true
		selection_deck.initiate_card_removal(0)
		selection_deck.update_header("(Free Removal)")
		selection_deck.update_color(Color(0,1,0))
	else:
		globals.player.damage -= RELAX_AMOUNT
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

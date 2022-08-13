extends NonCombatEncounter

const CONTINUE_HEALTH_LOSS = -25
const journal_description = "I found a peculiar mirror that appeared to show me in various animal forms."\
			+ "The longer I looked at myself, the more I forgot what I really looked like."

var secondary_choices := {
		'continue': '[Continue looking]: {bcolor:-{loss_amount} max {anxiety}:}. {gcolor:Gain {beast}:}.',
		#TODO: Add another option to exchange a special curio for the card, if the player has it
		'leave': '[Leave]: Nothing Happens.',
	}

var nce_result_fluff := {
		'continue': "My mind accepted this new form. I felt more powerful, but not as comfortable in this skin",
		'leave': "This view started churning my stomach. I left quickly.",
	}


func _init():
	introduction.setup_with_vars("Beast Mirror",journal_description, "The Beastly Form of Myself")
	prepare_journal_art(load("res://assets/journal/nce/Beast Mirror.jpg"))
	
func begin() -> void:
	.begin()
	var scformat = {
		"beast": _prepare_card_popup_bbcode("Beast Mode", "a special card"),
		"loss_amount": abs(CONTINUE_HEALTH_LOSS),
	}
	_prepare_secondary_choices(secondary_choices,scformat)

func continue_encounter(key) -> void:
	match key:
		"continue":
			# warning-ignore:return_value_discarded
			globals.player.deck.add_new_card("Beast Mode")
			globals.player.health += CONTINUE_HEALTH_LOSS
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

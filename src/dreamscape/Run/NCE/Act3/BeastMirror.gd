extends NonCombatEncounter

const CONTINUE_HEALTH_LOSS = -25

var secondary_choices := {
		'continue': '[Continue looking]: Lose {loss_amount} max {anxiety}. Gain {beast}.',
		#TODO: Add another option to exchange a special curio for the card, if the player has it
		'leave': '[Leave]: Nothing Happens.',
	}

var nce_result_fluff := {
		'continue': "My mind accepted this new form. I felt more powerful, but not as comfortable in this skin",
		'leave': "This view started churning my stomach. I left quickly.",
	}


func _init():
	description = "I found a peculiar mirror that appeared to show me in various animal forms."\
			+ "The longer I looked at myself, the more I forgot what I really looked like."
	prepare_journal_art(load("res://assets/journal/nce/beast_mirror.jpeg"))
	
func begin() -> void:
	.begin()
	var scformat = {
		"beast": _prepare_card_popup_bbcode("Beast Mode", "a special card"),
		"loss_amount": abs(CONTINUE_HEALTH_LOSS),
	}
	for c in secondary_choices:
		secondary_choices[c] = secondary_choices[c].format(scformat).format(Terms.get_bbcode_formats(18))
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	match key:
		"continue":
			# warning-ignore:return_value_discarded
			globals.player.deck.add_new_card("Beast Mode")
			globals.player.health += CONTINUE_HEALTH_LOSS
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

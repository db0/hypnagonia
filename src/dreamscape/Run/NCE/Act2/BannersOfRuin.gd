extends NonCombatEncounter

var secondary_choices := {
		'mouse': '[Mouse]: {bcolor:-10% max {anxiety}:}. {gcolor:Find {curio}:}.',
		'bear': '[Bear]: {gcolor:+10% max {anxiety}:}.',
		'hyena': '[Hyena]: Gain {gcolor:a {hyena}:}.',
	}

var nce_result_fluff := {
		'mouse': "I was the smallest of the bunch, and as such I had to rely on other skills."\
			+ ", I played the role of the tracker.",
		'bear': "As the largest in the resistance, I was the shield which protected my mates.",
		'hyena': "I relied on my keen skills to disrupt and pilfer what we needed",
	}


func _init():
	description = "I was in a anthropomorphic mammal in some sort of medieval fantasy world."\
			+ "I was part of the resistance and I had to break into a fortified city.\n"\
			+ "I am trying to recall what mammal exactly I was.."
	prepare_journal_art(load("res://assets/journal/nce/Banners of Ruin.jpg"))
	
func begin() -> void:
	.begin()
	var scformat = {
		"hyena": _prepare_card_popup_bbcode("Hyena", "a special card"),
		"curio": _prepare_artifact_popup_bbcode("BetterRareChance", "some interesting cheese")
	}
	_prepare_secondary_choices(secondary_choices,scformat)

func continue_encounter(key) -> void:
	match key:
		"mouse":
			# warning-ignore:narrowing_conversion
			globals.player.health *= 0.9
			# warning-ignore:return_value_discarded
			globals.player.add_artifact("BetterRareChance")
		"bear":
			# warning-ignore:narrowing_conversion
			globals.player.health *= 1.1
		"hyena":
			# warning-ignore:return_value_discarded
			globals.player.deck.add_new_card("Hyena")
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

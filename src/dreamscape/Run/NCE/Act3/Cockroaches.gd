extends NonCombatEncounter

const PERTURBATION := "Cockroach Infestation"
const DAMAGE_PCT_REDUCE := 0.5
const STOMP_DAMAGE := 3

var secondary_choices := {
		'ignore': '[Ignore]:{gcolor:{relax} for {pct}% of your max {anxiety}:}. {bcolor:Become {infested}:}.',
		'stomp': '[Stomp]: {bcolor:+{damage_amount} {anxiety_up}:}.',
	}

var nce_result_fluff := {
		'ignore': "I pushed the critters out of my mind. They were still there of course, but they couldn't hurt me.",
		'stomp': "I couldn't tolerate the things. I dreamt a whole sequence of bug stomping with extreme prejudice.",
	}


func _init():
	description = "On tiny, scuttling legs they cross the dining room table, "\
			+ "each leg shaped like the hands of time. Fruit they touch goes mouldy, "\
			+ "old coasters suddenly become new. "\
			+ "The ear always is confused as the tick-tocking sound shouldn't move, the clock is on the wall, "\
			+ "but now I hear it down the sides of the cupboards... "
	prepare_journal_art(load("res://assets/journal/nce/Cockroaches.jpg"))
	
func begin() -> void:
	.begin()
	var scformat = {
		"infested": _prepare_card_popup_bbcode(PERTURBATION, "infected"),
		"pct": DAMAGE_PCT_REDUCE * 100,
		"damage_amount": STOMP_DAMAGE,
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"ignore":
			# warning-ignore:return_value_discarded
			globals.player.deck.add_new_card(PERTURBATION)
			globals.player.damage *= DAMAGE_PCT_REDUCE
		"stomp":
			globals.player.damage += STOMP_DAMAGE
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

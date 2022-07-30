extends NonCombatEncounter

var secondary_choices := {
		'eat': '[Eat the spider]: {gcolor:-10 {anxiety_down}:}. Gain {bcolor:{boss_amount} {boss_pathos}:}',
		'wave': '[Wave at the spider]: {gcolor:+10 max {anxiety}:}. Gain {bcolor:{boss_amount} {boss_pathos}:}. Gain {bcolor:{elite_amount} {elite_pathos}:}',
		'offer': '[Offer yourself to the spider]: {bcolor:+10 {anxiety_up}:}.',
	}

var nce_result_fluff := {
		'eat': 'The meal calmed me, but I felt as if I was going nowhere.',
		'wave': 'The spider waved back at me hesitantly. I felt more prepared to deal with whatever lay ahead... But would I ever meet the spider again? And Would it be as friendly?',
		'offer': 'As soon as I bowed to the spider, my hand sprouted a million eyes and scuttled away. I can still feel my heart thundering.',
	}


var pathos_type_boss: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.boss]
var pathos_type_elite: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.elite]

func _init():
	description = "A spider was looking at me with a thousand eyes. Its intentions are unfathomable."
	prepare_journal_art(load("res://assets/journal/nce/Spider.jpg"))

func begin() -> void:
	.begin()
	var scformat = {
		"boss_pathos": '{repressed_%s}' % [Terms.RUN_ACCUMULATION_NAMES.boss],
		"boss_amount": "some",
		"elite_pathos": '{repressed_%s}' % [Terms.RUN_ACCUMULATION_NAMES.elite],
		"elite_amount": "some",
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	if key == "eat":
		globals.player.damage -= 10
		pathos_type_boss.modify_repressed(pathos_type_boss.get_progression_average() * 2)
	elif key == "wave":
		globals.player.health += 10
		pathos_type_boss.modify_repressed(pathos_type_boss.get_progression_average() * 2)
		pathos_type_elite.modify_repressed(pathos_type_elite.get_progression_average() * 2) 
	elif key == "offer":
		globals.player.damage += 10
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'eat': '[Eat the spider]: Recover 10 {anxiety}. Gain {boss_amount} {boss_pathos}',
		'wave': '[Wave at the spider]: Gain 10 max {anxiety}. Gain {boss_amount} {boss_pathos}. Gain {elite_amount} {elite_pathos}',
		'offer': '[Offer yourself to the spider]: Take 10 {anxiety}.',
	}

var nce_result_fluff := {
		'eat': 'The meal calmed me, but I felt as if I was going nowhere.',
		'wave': 'The spider waved back at me hesitantly. I felt more prepared to deal with whatever lay ahead... But would I ever meet the spider again? And Would it be as friendly?',
		'offer': 'As soon as I bowed to the spider, my hand sprouted a million eyes and scuttled away. I can still feel my heart thundering.',
	}

func _init():
	description = "A spider was looking at me with a thousand eyes. Its intentions are unfathomable."
	prepare_journal_art(load("res://assets/journal/nce/spider.jpeg"))

func begin() -> void:
	.begin()
	var scformat = {
		"boss_pathos": '{repressed_%s}' % [Terms.RUN_ACCUMULATION_NAMES.boss],
		"boss_amount": round(globals.player.pathos.get_progression_average(
				Terms.RUN_ACCUMULATION_NAMES.boss) * 2),
		"elite_pathos": '{repressed_%s}' % [Terms.RUN_ACCUMULATION_NAMES.elite],
		"elite_amount": round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.elite) * 2),
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	if key == "eat":
		globals.player.damage -= 10
		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.boss, round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.boss) * 2)) 
	elif key == "wave":
		globals.player.health += 10
		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.boss, round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.boss) * 2)) 
		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.elite, round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.elite) * 2)) 
	elif key == "offer":
		globals.player.damage += 10
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

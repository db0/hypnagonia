# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'eat': '[Eat the spider]: Recover 10 {anxiety}. Gain {boss_amount} repressed {boss_pathos}',
		'wave': '[Wave at the spider]: Gain 10 {anxiety} threshold. Gain {boss_amount} repressed {boss_pathos}. Gain {elite_amount} represed {elite_pathos}',
		'offer': '[Offer yourself to the spider]: Take 10 {anxiety}.',
	}

var nce_result_fluff := {
		'eat': 'The meal calms me, but I feel as if I am going nowhere.',
		'wave': 'The spider waved back at me hesitantly. I feel more prepared to deal with whatever lies ahead... But will you ever meet the spider again? And will it be as friendly?',
		'offer': 'As soon as I bow to the spider, my hand sprouts a million eyes and scuttles away. I can still feel my heart thundering.',
	}

func _init():
	description = "A spider was looking at me with a thousand eyes. Its intentions are unfathomable."
	prepare_journal_art(preload("res://assets/journal/nce/spider.jpeg"))

func begin() -> void:
	.begin()
	var scformat = {
		"boss_pathos": Terms.RUN_ACCUMULATION_NAMES.boss,
		"boss_amount": round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.boss) * 2),
		"elite_pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
		"elite_amount": round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.elite) * 2),
	}
	secondary_choices['eat'] = secondary_choices['eat'].format(scformat).format(Terms.get_bbcode_formats(18))
	secondary_choices['wave'] = secondary_choices['wave'].format(scformat).format(Terms.get_bbcode_formats(18))
	secondary_choices['offer'] = secondary_choices['offer'].format(scformat).format(Terms.get_bbcode_formats(18))
	globals.journal.add_nested_choices(secondary_choices, [])
	
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

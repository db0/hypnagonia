# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'option1': '[Eat the spider]: Recover 10 {anxiety}. Gain {boss_amount} repressed {boss_pathos}',
		'option2': '[Wave at the spider]: Gain 10 {anxiety} threshold. Gain {boss_amount} repressed {boss_pathos}. Gain {elite_amount} represed {elite_pathos}',
		'option3': '[Offer yourself to the spider]: Take 10 {anxiety}.',
	}

var nce_result_fluff := {
		'option1': 'The meal calms me, but I feel as if I am going nowhere.',
		'option2': 'The spider waved back at me hesitantly. I feel more prepared to deal with whatever lies ahead... But will you ever meet the spider again? And will it be as friendly?',
		'option3': 'As soon as I bow to the spider, my hand sprouts a million eyes and scuttles away. I can still feel my heart thundering.',
	}

func _init():
	description = "A spider was looking at me with a thousand eyes. Its intentions are unfathomable."

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
	secondary_choices['option1'] = secondary_choices['option1'].format(scformat).format(Terms.get_bbcode_formats(18))
	secondary_choices['option2'] = secondary_choices['option2'].format(scformat).format(Terms.get_bbcode_formats(18))
	secondary_choices['option3'] = secondary_choices['option3'].format(scformat).format(Terms.get_bbcode_formats(18))
	globals.journal.add_nested_choices(secondary_choices, [])
	
func continue_encounter(key) -> void:
	if key == "option1":
		globals.player.damage -= 10
		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.boss, round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.boss) * 2)) 
	elif key == "option2":
		globals.player.health += 10
		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.boss, round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.boss) * 2)) 
		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.elite, round(globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.elite) * 2)) 
	elif key == "option3":
		globals.player.damage += 10
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

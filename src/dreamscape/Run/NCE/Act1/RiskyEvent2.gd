# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'option1': '[Option1]: Recover 10 {anxiety}. Gain {boss_amount} repressed {boss_pathos}',
		'option2': '[Option2]: Gain 10 {anxiety} threshold. Gain {boss_amount} repressed {boss_pathos}. Gain {elite_amount} represed {elite_pathos}',
		'option3': '[Option3]: Take 10 {anxiety}.',
	}

var nce_result_fluff := {
		'option1': 'I felt I was close to whoever was behind this dream...',
		'option2': 'A sense of dread was surrounding me.',
		'option3': 'This was getting way too stressful.',
	}

func _init():
	# TODO: Add story
	description = "<Risky Dream 2 - Story Fluff to be Done>. Select one Option...."

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

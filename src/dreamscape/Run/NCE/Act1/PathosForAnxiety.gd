# Gives three choices to gain pathos. Each with increasing amount of anxiety gained

extends NonCombatEncounter

var secondary_choices := {
		'calm': '[Calm]: Gain {calm_random_pathos_amount} repressed {calm_random_pathos}.',
		'stress': '[Stress]: Take {stress_amount} anxiety. Gain {stress_random_pathos_amount} repressed {stress_random_pathos}.',
		'fear': '[Fear]: Take {fear_amount} anxiety. Gain {fear_random_pathos_amount} repressed {fear_random_pathos}.',
	}
	
var nce_resul_fluff := {
		'calm': '<Calm Choice - Story Fluff to be Done>',
		'stress': '<Stress Choice - Story Fluff to be Done>',
		'fear': '<Fear Choice - Story Fluff to be Done>',
	}
	
var choices := {}

func _init():
	description = "<Pathos For Anxiety - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.nce)
	.begin()
	var calm_choice = globals.player.pathos.grab_random_pathos()
	var stress_choice = globals.player.pathos.grab_random_pathos()
	var fear_choice = globals.player.pathos.grab_random_pathos()
#	print_debug(pathos_org)
	var calm_choice_amount = round(
			globals.player.pathos.get_progression_average(calm_choice)
			* 2 * CFUtils.randf_range(0.9,1.1)
		)
	var stress_choice_amount =  round(
			globals.player.pathos.get_progression_average(stress_choice)
			* 3 * CFUtils.randf_range(0.9,1.1)
		)
	var fear_choice_amount = round(
				globals.player.pathos.get_progression_average(fear_choice)
				* 5 * CFUtils.randf_range(0.9,1.1)
			)
	var stress_amount = CFUtils.randi_range(9,11)
	var fear_amount = CFUtils.randi_range(18,22)
	var scformat = {
		"calm_random_pathos": calm_choice,
		"calm_random_pathos_amount":  calm_choice_amount,
		"stress_random_pathos": stress_choice,
		"stress_random_pathos_amount":  stress_choice_amount,
		"stress_amount":  stress_amount,
		"fear_random_pathos": fear_choice,
		"fear_random_pathos_amount":  fear_choice_amount,
		"fear_amount":  fear_amount,
	}
	choices["calm"]  = {
		"pathos": calm_choice,
		"reward": calm_choice_amount,
		"anxiety": 0,
	}
	choices["stress"] = {
		"pathos": stress_choice,
		"reward": stress_choice_amount,
		"anxiety": stress_amount,
	}
	choices["fear"] = {
		"pathos": fear_choice,
		"reward": fear_choice_amount,
		"anxiety": fear_amount,
	}
	secondary_choices['calm'] = secondary_choices['calm'].format(scformat)
	secondary_choices['stress'] = secondary_choices['stress'].format(scformat)
	secondary_choices['fear'] = secondary_choices['fear'].format(scformat)
	for type in ['calm', 'stress', 'fear']:
		secondary_choices[type] = secondary_choices[type].format(scformat)
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	globals.player.pathos.repress_pathos(choices[key]["pathos"], choices[key]["reward"])
	globals.player.damage += choices[key]["anxiety"]
	globals.journal.display_nce_rewards(nce_resul_fluff[key])

# Gives three choices to gain pathos. Each with increasing amount of anxiety gained

extends NonCombatEncounter

var secondary_choices := {
		'calm': '[Songbird]: Gain {gcolor:{calm_random_pathos_amount} {calm_random_pathos}:}.',
		'stress': '[Peacock]: {bcolor:+{stress_amount}:} {anxiety_up}. Gain {gcolor:{stress_random_pathos_amount} {stress_random_pathos}:}.',
		'fear': '[Lion]: {bcolor:+{fear_amount} {anxiety_up}:}. Gain {gcolor:{fear_random_pathos_amount} {fear_random_pathos}:}.',
	}
	
var nce_result_fluff := {
		'calm': 'The bananas showered me with praise, absolutely peeling before my eyes.',
		'stress': 'The apples cheered for me until their cores exploded.',
		'fear': "All the blueberries cried in their seats as they slowly melted away.",
	}
	
var choices := {}

func _init():
	description = """
My mind was in a haze and there was a ringing in my ears. 
My nervoussness was continuing to grow, yet I was determined to impress my fruity audience. 
They pointed the cameras directly at me. It was time to let out the inner animal inside me.
"""

func begin() -> void:
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
		"calm_random_pathos": '{released_%s}' % [calm_choice],
		"calm_random_pathos_amount":  calm_choice_amount,
		"stress_random_pathos": '{released_%s}' % [stress_choice],
		"stress_random_pathos_amount":  stress_choice_amount,
		"stress_amount":  stress_amount,
		"fear_random_pathos": '{released_%s}' % [fear_choice],
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
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	globals.player.pathos.modify_released_pathos(choices[key]["pathos"], choices[key]["reward"])
	globals.player.damage += choices[key]["anxiety"]
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

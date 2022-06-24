# Gives three choices to gain pathos. Each with increasing amount of anxiety gained

extends NonCombatEncounter

const MASTERY_AMOUNTS := {
	"calm": round(Pathos.MASTERY_BASELINE * 0.6),
	"stress": round(Pathos.MASTERY_BASELINE * 1.3),
	"fear": round(Pathos.MASTERY_BASELINE * 2.5),
}

var secondary_choices := {
		'calm': '[Songbird]: Gain {gcolor:{calm_mastery_amount} {mastery}:}.',
		'stress': '[Peacock]: {bcolor:+{stress_amount}:} {anxiety_up}. Gain {gcolor:{stress_mastery_amount} {masteries}:}.',
		'fear': '[Lion]: {bcolor:+{fear_amount} {anxiety_up}:}. Gain {gcolor:{fear_mastery_amount} {masteries}:}.',
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
	var stress_amount = CFUtils.randi_range(9,11)
	var fear_amount = CFUtils.randi_range(18,22)
	var scformat = {
		"calm_mastery_amount":  MASTERY_AMOUNTS['calm'],
		"stress_mastery_amount":  MASTERY_AMOUNTS['stress'],
		"stress_amount":  stress_amount,
		"fear_mastery_amount":  MASTERY_AMOUNTS['fear'],
		"fear_amount":  fear_amount,
	}
	choices["calm"]  = {
		"reward": MASTERY_AMOUNTS['calm'],
		"anxiety": 0,
	}
	choices["stress"] = {
		"reward": MASTERY_AMOUNTS['stress'],
		"anxiety": stress_amount,
	}
	choices["fear"] = {
		"reward": MASTERY_AMOUNTS['fear'],
		"anxiety": fear_amount,
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	globals.player.pathos.available_masteries += choices[key]["reward"]
	globals.player.damage += choices[key]["anxiety"]
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

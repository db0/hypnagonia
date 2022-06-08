extends NonCombatEncounter

const SLAY_PCT := 0.6
const LEAVE_PCT := 0.3

var secondary_choices := {
		'slay': '[Slay]: {bcolor:+10 {anxiety_up}:}. Gain some {bcolor:{repressed_enemy}:}. Increase {gcolor:{released_nce} by {slay_amount}%:}',
		'leave': '[Leave]: Gain some {bcolor:{repressed_nce}:}. Decrease {bcolor:{released_enemy} by {leave_amount}%:}.',
	}

var nce_result_fluff := {
		'slay': "I started climbing. One horror after the next appeared before me until, "\
			+ "inenvitably I was slain myself. My vision of the spire faded and as I "\
			+ "felt into the next dream, I wondered if I could ever reach the top...",
		'leave': 'I am are not in the mood for whatever dark fantasy this is.',
	}


func _init():
	description = "I dreamt of a long spire, disappearing into the pregnant clouds above. "\
			+ "I realized I was now holding a weapon and could feel the need to slay whatever is within..."

var pathos_type_enemy : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]
var pathos_type_nce : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]

func begin() -> void:
	.begin()
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	scformat["slay_amount"] = SLAY_PCT * 100
	scformat["leave_amount"] = LEAVE_PCT * 100
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"slay":
			globals.player.damage += 10
			pathos_type_nce.released += pathos_type_nce.convert_pct_to_released(SLAY_PCT)
			pathos_type_enemy.repressed += pathos_type_enemy.get_progression_average() * 2
		"leave":
			pathos_type_enemy.lose_released_pathos(pathos_type_nce.convert_pct_to_released(LEAVE_PCT))
			pathos_type_nce.repressed += pathos_type_enemy.get_progression_average() * 2
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

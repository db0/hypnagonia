extends NonCombatEncounter

var secondary_choices := {
		'slay': '[Slay]: {bcolor:+10 {anxiety_up}:}. Gain {bcolor:{slay_amount} {repressed_enemy}:}. Gain some {gcolor:{released_nce}:}',
		'leave': '[Leave]: Gain {bcolor:{leave_amount} {repressed_nce}:}. Lose some {bcolor:{released_enemy}:}.',
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

var pathos_type_nce : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.nce]
var pathos_type_enemy : PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.enemy]

func begin() -> void:
	.begin()
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	scformat["slay_amount"] = pathos_type_nce.get_progression_average() * 2
	scformat["leave_amount"] = pathos_type_enemy.get_progression_average() * 2
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"slay":
			globals.player.damage += 10
			var released_reward = round(
					pathos_type_nce.get_progression_average() * 3 * CFUtils.randf_range(0.8,1.2)
				)
			pathos_type_nce.released += released_reward
			pathos_type_enemy.repressed += pathos_type_enemy.get_progression_average() * 2
		"leave":
			var released_penaly = round(
					pathos_type_enemy.get_progression_average() * 3 * CFUtils.randf_range(0.5,1.5)
				)
			pathos_type_enemy.lose_released_pathos(released_penaly)
			pathos_type_enemy.repressed += pathos_type_enemy.get_progression_average() * 2
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

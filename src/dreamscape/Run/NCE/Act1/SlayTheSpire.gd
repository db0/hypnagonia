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


func begin() -> void:
	.begin()
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	scformat["slay_amount"] = globals.player.pathos.get_progression_average(
			Terms.RUN_ACCUMULATION_NAMES.enemy) * 2
	scformat["leave_amount"] = globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.nce) * 2
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"slay":
			globals.player.damage += 10
			var released_reward = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.nce)
					* 3 * CFUtils.randf_range(0.8,1.2)
				)
			globals.player.pathos.modify_released_pathos(Terms.RUN_ACCUMULATION_NAMES.nce, released_reward)
			globals.player.pathos.repress_pathos(
					Terms.RUN_ACCUMULATION_NAMES.enemy, 
					int(globals.player.pathos.get_progression_average(
						Terms.RUN_ACCUMULATION_NAMES.enemy) * 2))
		"leave":
			var released_penaly = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.enemy)
					* 3 * CFUtils.randf_range(0.5,1.5)
				)
			globals.player.pathos.lose_released_pathos(Terms.RUN_ACCUMULATION_NAMES.enemy, released_penaly)
			globals.player.pathos.repress_pathos(
					Terms.RUN_ACCUMULATION_NAMES.nce, 
					int(globals.player.pathos.get_progression_average(
						Terms.RUN_ACCUMULATION_NAMES.nce) * 2))
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

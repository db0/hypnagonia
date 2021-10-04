extends NonCombatEncounter

var secondary_choices := {
		'slay': '[Slay]: Take 10 anxiety. Gain {slay_amount} repressed {enemy}. Gain some released {nce}',
		'leave': '[Leave]: Gain {leave_amount} repressed {nce}. Lose some released {enemy}.',
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
	globals.player.pathos.release(Terms.RUN_ACCUMULATION_NAMES.nce)
	.begin()
	var scformat := Terms.RUN_ACCUMULATION_NAMES.duplicate()
	scformat["slay_amount"] = globals.player.pathos.get_progression_average(
			Terms.RUN_ACCUMULATION_NAMES.enemy) * 2
	scformat["leave_amount"] = globals.player.pathos.get_progression_average(
		Terms.RUN_ACCUMULATION_NAMES.nce) * 2
	secondary_choices['slay'] = secondary_choices['slay'].format(scformat)
	secondary_choices['leave'] = secondary_choices['leave'].format(scformat)
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	match key:
		"slay":
			globals.player.damage += 10
			var released_reward = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.nce)
					* 3 * CFUtils.randf_range(0.8,1.2)
				)
			globals.player.pathos.release_pathos(Terms.RUN_ACCUMULATION_NAMES.nce, released_reward)
			globals.player.pathos.repress_pathos(
					Terms.RUN_ACCUMULATION_NAMES.enemy, 
					globals.player.pathos.get_progression_average(
						Terms.RUN_ACCUMULATION_NAMES.enemy) * 2)
		"leave":
			var released_penaly = round(
					globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.enemy)
					* 3 * CFUtils.randf_range(0.5,1.5)
				)
			globals.player.pathos.release_pathos(Terms.RUN_ACCUMULATION_NAMES.enemy, -released_penaly)
			globals.player.pathos.repress_pathos(
					Terms.RUN_ACCUMULATION_NAMES.nce, 
					globals.player.pathos.get_progression_average(
						Terms.RUN_ACCUMULATION_NAMES.nce) * 2)
	globals.journal.display_nce_rewards(nce_result_fluff[key])

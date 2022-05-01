extends NonCombatEncounter

var secondary_choices := {
		'allow': '[Allow]: {bcolor:Lose a random curio:}. {gcolor:Gain a {special_curio}:}',
		'deny': '[Deny]: Deny their request. Nothing Happens. ',
	}

var nce_result_fluff := {
		'deny': 'The stuffed toys were beyond consolation, tearing their stuffing in anguish. I left in a hurry.',
		'allow': 'They looked through my stuff {lost_curio} '\
				+ 'One of them graciously offered to join me and provide their soft emotional support.',
	}


func _init():
	description = "I was in the dark, surrounded by a variety of plushie toys. "\
			+ "They requested I let them take something I have that they've never seen before."


func begin() -> void:
	# warning-ignore:return_value_discarded
	.begin()
	var scformat = {
		"special_curio": _prepare_artifact_popup_bbcode("BetterArtifactChance", "special curio")
	}
	var disabled_choices := []
	if globals.player.artifacts.size() == 0:
		disabled_choices.append('allow')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)


func continue_encounter(key) -> void:
	match key:
		"allow":
			var lost_curio = globals.player.get_random_artifact()
			var fmt = {"lost_curio": _prepare_artifact_popup_bbcode(
					lost_curio.canonical_name, 
					"and chose something I did not expect.")}
			nce_result_fluff[key] = nce_result_fluff[key].format(fmt)
			globals.player.remove_artifact(lost_curio)
			globals.player.add_artifact("BetterArtifactChance")
	globals.journal.display_nce_rewards(nce_result_fluff[key])
	end()

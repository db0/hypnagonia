# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

const PATHOS_USED = Terms.RUN_ACCUMULATION_NAMES.artifact
var artifact_prep: ArtifactPrep

var secondary_choices := {
		'accept': '[Accept]: 40% chance to gain a random curio. [color=#FF3333]Become {perturbation}[/color].',
		'decline': '[Decline]: [color=#FF3333]+10[/color] {anxiety_up}. [color=#FF3333]Lose some {repressed_pathos}.',
	}

var nce_result_fluff := {
		'accept_success': 'I made it across, and found {curio} at the other size.',
		'accept_fail': 'A clown distracted me and I began to fall. Was there a safety net?',
		'decline': 'The crowd groaned as I climbed down from the platform.',
	}
	
# For controlling chances during testing
var _testing_rng = -1

func _init():
	# TODO: Add story
	description = "I found myself on a small platform atop a circus tent with only a tightrope ahead of me. The crowd below was cheering me on."

func begin() -> void:
	.begin()
	var scformat = {
		"perturbation": _prepare_card_popup_bbcode("Terror", "terrified"),
		"repressed_pathos": '{repressed_%s}' % [PATHOS_USED],
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	var result: String
	if key == "accept":
		result = nce_result_fluff['accept_fail']
		var rngesus = CFUtils.randi_range(1,100)
		if _testing_rng >= 0:
			rngesus = _testing_rng
		if rngesus <= 40:
			var accumulated = globals.player.pathos.repressed[Terms.RUN_ACCUMULATION_NAMES.nce] / 4
			artifact_prep = ArtifactPrep.new(accumulated/2, accumulated, 1)
# warning-ignore:return_value_discarded
			globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
			var fmt = {"curio": _prepare_artifact_popup_bbcode(artifact_prep.selected_artifacts[0].canonical_name, artifact_prep.selected_artifacts[0].name)}
			result = nce_result_fluff['accept_success'].format(fmt)
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Terror")
	else:
		result = nce_result_fluff['decline']
		globals.player.damage += 10
		var amount_lost =\
				globals.player.pathos.get_progression_average(Terms.RUN_ACCUMULATION_NAMES.artifact)\
				* CFUtils.randf_range(0.8,1.2)
		globals.player.pathos.modify_repressed_pathos(Terms.RUN_ACCUMULATION_NAMES.artifact, -amount_lost, true)
	end()
	globals.journal.display_nce_rewards(result)

# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var artifact_prep: ArtifactPrep

var secondary_choices := {
		'accept': '[Accept]: 40% chance to gain a random curio. Become {perturbation}.',
		'decline': '[Decline]: Gain 10 {anxiety}. Lose some repressed {pathos}.',
	}

var nce_result_fluff := {
		'accept_success': 'I made it across, and found {curio} at the other size.',
		'accept_fail': 'A clown distracted me and I began to fall. Was there a safety net?',
		'decline': 'The crowd groaned as I climbed down from the platform.',
	}

func _init():
	# TODO: Add story
	description = "I found myself on a small platform atop a circus tent with only a tightrope ahead of me. The crowd below was cheering me on."

func begin() -> void:
	.begin()
	var scformat = {
		"perturbation": _prepare_card_popup_bbcode("Terror", "terrified"),
		"pathos": Terms.RUN_ACCUMULATION_NAMES.artifact,
	}
	secondary_choices['accept'] = secondary_choices['accept'].format(scformat)
	secondary_choices['decline'] = secondary_choices['decline'].format(scformat).format(Terms.get_bbcode_formats(18))
	globals.journal.add_nested_choices(secondary_choices, [])

func continue_encounter(key) -> void:
	var result: String
	if key == "accept":
		result = nce_result_fluff['accept_fail']
		var rngesus = CFUtils.randf_range(0.0,1.0)
		if rngesus <= 0.4:
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

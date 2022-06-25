extends NonCombatEncounter

const MASTERIES_AMOUNT := round(Pathos.MASTERY_BASELINE * 4)
	
var artifact_prep: ArtifactPrep

var secondary_choices := {
		'help': '[Help]: Pay {bcolor:Lose all your {masteries}:}. {gcolor:Gain a random curio:} with rarity based on how many masteries you had.',
		'ignore': '[Ignore]: {bcolor:Gain {masteries_amount} masteries:} . {gcolor:Gain a random curio:}. {bcolor:Become {perturbation}:}.',
	}

# TODO Result fluff
var nce_result_fluff := {
		'help': 'Helped: {curio}',
		'ignore': 'Ignored: {curio}',
	}


func _init():
	# TODO: Add story
	description = "<Risky Dream 4 - Story Fluff to be Done>. Select one Option...."


func begin() -> void:
	.begin()
	var scformat = {
		"perturbation": _prepare_card_popup_bbcode("Apathy", "apathetic"),
		"masteries_": MASTERIES_AMOUNT,
	}
	var disabled_choices = []
	if globals.player.pathos.available_masteries == 0:
		disabled_choices.append('help')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	if key == "help":
		var amount = globals.player.pathos.available_masteries
		artifact_prep = ArtifactPrep.new(amount * 1.5, amount * 3, 1)
		# warning-ignore:return_value_discarded
		globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
		globals.player.pathos.available_masteries = 0
	else:
		artifact_prep = ArtifactPrep.new(1, 5, 1)
		# warning-ignore:return_value_discarded
		globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Apathy")
		globals.player.pathos.available_masteries += MASTERIES_AMOUNT
	end()
	var fmt = {"curio": _prepare_artifact_popup_bbcode(artifact_prep.selected_artifacts[0].canonical_name, artifact_prep.selected_artifacts[0].name)}
	nce_result_fluff[key] = nce_result_fluff[key].format(fmt)
	globals.journal.display_nce_rewards(nce_result_fluff[key])


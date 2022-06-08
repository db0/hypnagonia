# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var artifact_prep: ArtifactPrep
var highest_pathos: String
var pathos_type_highest: PathosType
var ignore_pathos : String = Terms.RUN_ACCUMULATION_NAMES.artifact
var pathos_type_ignored: PathosType = globals.player.pathos.pathi[Terms.RUN_ACCUMULATION_NAMES.artifact]

var secondary_choices := {
		'help': '[Help]: Pay {bcolor:Lose all your unspent masteries:}. {gcolor:Gain a random curio:} with rarity based on how many masteries you had.',
		'ignore': '[Ignore]: {bcolor:Gain 3 masteries:} in {ignore_pathos}. {gcolor:Gain a random curio:}. {bcolor:Become {perturbation}:}.',
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
	var pathos_org = globals.player.pathos.get_pathos_org()
	pathos_type_highest =  pathos_org["highest_pathos"]["selected"]
	highest_pathos = pathos_type_highest.name
	var scformat = {
		"perturbation": _prepare_card_popup_bbcode("Apathy", "apathetic"),
		"pathos": '{released_%s}' % [highest_pathos],
		"amount": pathos_type_highest.convert_released_num_to_pct(pathos_type_highest.released) * 100,
		"ignore_pathos": ignore_pathos,
	}
	var disabled_choices = []
	if globals.player.pathos.available_masteries == 0:
		disabled_choices.append('help')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	if key == "help":
		var amount = globals.player.pathos.available_masteries
		artifact_prep = ArtifactPrep.new(amount * 5, amount * 7, 1)
		# warning-ignore:return_value_discarded
		globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
		globals.player.pathos.available_masteries = 0
	else:
		artifact_prep = ArtifactPrep.new(1, 5, 1)
		# warning-ignore:return_value_discarded
		globals.player.add_artifact(artifact_prep.selected_artifacts[0].canonical_name)
		pathos_type_ignored.level_up()
		pathos_type_ignored.level_up()
		pathos_type_ignored.level_up()
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Apathy")
	end()
	var fmt = {"curio": _prepare_artifact_popup_bbcode(artifact_prep.selected_artifacts[0].canonical_name, artifact_prep.selected_artifacts[0].name)}
	nce_result_fluff[key] = nce_result_fluff[key].format(fmt)
	globals.journal.display_nce_rewards(nce_result_fluff[key])


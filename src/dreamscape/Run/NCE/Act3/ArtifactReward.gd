# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

# The artifact used by this event.
const SPECIAL_ARTIFACT:= "StartingDisempower"
const MASTERY_AMOUNT := 2

# TODO: Fluff
var secondary_choices := {
		'receive': '[Receive Curio]: {bcolor:Spend all {masteries}:}. {gcolor:Gain {special_curio}:}.',
		'use': '[Use Curio]: use {special_curio}. Gain {gcolor:{masteries_amount} {lowest_pathos} {mastery}:}.',
		'ignore': '[Ignore]: Nothing happens.',
	}

var lowest_pathos 
var lowest_pathos_amount 

func _init():
	# TODO: Fluff
	description = "<Multiple Options - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org("level", true)
#	print_debug(pathos_org)
	lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	var scformat = {
		"lowest_pathos": lowest_pathos.name,
		"masteries_amount":  MASTERY_AMOUNT,
		"special_curio": _prepare_artifact_popup_bbcode(SPECIAL_ARTIFACT, SPECIAL_ARTIFACT)
	}
	var disabled_choices := []
	if globals.player.find_artifact(SPECIAL_ARTIFACT):
			disabled_choices.append('receive')
	else:
			disabled_choices.append('use')
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

func continue_encounter(key) -> void:
	var card_choice_description: String
	match key:
		"receive":
			globals.player.add_artifact(SPECIAL_ARTIFACT)
			globals.player.pathos.available_masteries = 0
		"use":
			for iter in MASTERY_AMOUNT:
				lowest_pathos.level_up()
			globals.player.remove_artifact(SPECIAL_ARTIFACT)
	globals.journal.display_nce_rewards('')
	end()

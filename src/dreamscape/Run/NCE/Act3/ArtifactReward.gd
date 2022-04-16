# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

# The artifact used by this event.
const SPECIAL_ARTIFACT:= "StartingDisempower"

# TODO: Fluff
var secondary_choices := {
		'receive': '[Receive Curio]: Spend all {highest_pathos}. Gain {special_curio}.',
		'use': '[Use Curio]: use {special_curio}. Gain {lowest_pathos_amount} {lowest_pathos}.',
		'ignore': '[Ignore]: Nothing happens.',
	}

var highest_pathos
var lowest_pathos 
var lowest_pathos_amount 

func _init():
	# TODO: Fluff
	description = "<Multiple Options - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org("released", true)
#	print_debug(pathos_org)
	lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	highest_pathos = pathos_org["highest_pathos"]["selected"]
	lowest_pathos_amount = round(globals.player.pathos.get_progression_average(lowest_pathos)\
			* 8 * CFUtils.randf_range(0.8,1.2))
	var scformat = {
		"highest_pathos": '{released_%s}' % [highest_pathos],
		"lowest_pathos": '{released_%s}' % [lowest_pathos],
		"lowest_pathos_amount":  lowest_pathos_amount,
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
			globals.player.pathos.spend_pathos(highest_pathos, globals.player.pathos.released[highest_pathos])
		"use":
			globals.player.pathos.modify_released_pathos(lowest_pathos, lowest_pathos_amount)
			globals.player.remove_artifact(SPECIAL_ARTIFACT)
	globals.journal.display_nce_rewards('')
	end()

extends NonCombatEncounter

# The artifact used by this event.
const SPECIAL_ARTIFACT:= "StartingDisempower"
const MASTERIES_AMOUNT := round(Pathos.MASTERY_BASELINE * 4)
const journal_description = "<Multiple Options - Story Fluff to be Done>. Select one Option...."

# TODO: Fluff
var secondary_choices := {
		'receive': '[Receive Curio]: {bcolor:Spend all {masteries}:}. {gcolor:Gain {special_curio}:}.',
		'use': '[Use Curio]: use {special_curio}. Gain {gcolor:{masteries_amount} {masteries}:}.',
		'ignore': '[Ignore]: Nothing happens.',
	}

var lowest_pathos 
var lowest_pathos_amount 

func _init():
	# TODO: Fluff
	introduction.setup_with_vars("Artifact Reward",journal_description, "")

func begin() -> void:
	.begin()
	var scformat = {
		"masteries_amount":  MASTERIES_AMOUNT,
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
			globals.player.pathos.available_masteries += MASTERIES_AMOUNT
			globals.player.remove_artifact(SPECIAL_ARTIFACT)
	globals.journal.display_nce_rewards('')
	end()

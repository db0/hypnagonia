# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

const MASTERY_AMOUNT := 2

var secondary_choices := {
		'accept': '[Accept]: Gain {gcolor:{mastery_amount} {lowest_pathos} {masteries}:}. {bcolor:Become {perturbation}:}.',
		'decline': '[Decline]: Nothing Happens.',
	}
var pathos_choice_payments := {}

func _init():
	# TODO: Add story
	description = "<Mastery for Perturbation - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org("level", true)
#	print_debug(pathos_org)
	var lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	var scformat = {
		"lowest_pathos": lowest_pathos,
		"mastery_amount": MASTERY_AMOUNT,
		"perturbation": _prepare_card_popup_bbcode("Discombobulation", "discombobulated")
	}
	pathos_choice_payments["accept"]  = {
		"pathos": lowest_pathos,
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	if key == "accept":
		for iter in MASTERY_AMOUNT:
			var pathos_type: PathosType = pathos_choice_payments[key]["pathos"]
			pathos_type.level_up()
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Discombobulation")
	end()
	globals.journal.display_nce_rewards('')

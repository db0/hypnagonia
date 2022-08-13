extends NonCombatEncounter

const MASTERIES_AMOUNT := round(Pathos.MASTERY_BASELINE * 7)
const journal_description = "<Greed - Story Fluff to be Done>. Select one Option...."

var secondary_choices := {
		'accept': '[Accept]: Gain {gcolor:{masteries_amount} {masteries}:}. {bcolor:Become {perturbation}:}.',
		'decline': '[Decline]: Nothing Happens.',
	}
var pathos_choice_payments := {}

func _init():
	# TODO: Add story
	introduction.setup_with_vars("Greed",journal_description, "")

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org("level", true)
#	print_debug(pathos_org)
	var lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	var scformat = {
		"lowest_pathos": lowest_pathos.name,
		"masteries_amount": MASTERIES_AMOUNT,
		"perturbation": _prepare_card_popup_bbcode("Discombobulation", "discombobulated")
	}
	pathos_choice_payments["accept"]  = {
		"pathos": lowest_pathos,
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	if key == "accept":
		globals.player.pathos.available_masteries += MASTERIES_AMOUNT
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Discombobulation")
	end()
	globals.journal.display_nce_rewards('')

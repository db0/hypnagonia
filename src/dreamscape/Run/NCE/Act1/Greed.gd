# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'accept': '[Accept]: Gain {gcolor:a mastery in {lowest_pathos}:}. {bcolor:Become {perturbation}:}.',
		'decline': '[Decline]: Nothing Happens.',
	}
var pathos_choice_payments := {}

func _init():
	# TODO: Add story
	description = "<Mastery for Perturbation - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org("masteries", true)
#	print_debug(pathos_org)
	var lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	var scformat = {
		"lowest_pathos": lowest_pathos,
		"perturbation": _prepare_card_popup_bbcode("Discombobulation", "discombobulated")
	}
	pathos_choice_payments["accept"]  = {
		"pathos": lowest_pathos,
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	if key == "accept":
		globals.player.pathos.level_up(pathos_choice_payments[key]["pathos"])
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Discombobulation")
	end()
	globals.journal.display_nce_rewards('')

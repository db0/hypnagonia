# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'accept': '[Accept]: Gain {gcolor:{lowest_pathos_amount} {lowest_pathos}:}. {bcolor:Become {perturbation}:}.',
		'decline': '[Decline]: Nothing Happens.',
	}
var pathos_choice_payments := {}

func _init():
	# TODO: Add story
	description = "<Release for Perturbation - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org("released", true)
#	print_debug(pathos_org)
	var lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	var lowest_pathos_amount = round(globals.player.pathos.get_progression_average(lowest_pathos)\
			* 8 * CFUtils.randf_range(0.8,1.2))
	var scformat = {
		"lowest_pathos": '{released_%s}' % [lowest_pathos],
		"lowest_pathos_amount":  lowest_pathos_amount,
		"perturbation": _prepare_card_popup_bbcode("Discombobulation", "discombobulated")
	}
	pathos_choice_payments["accept"]  = {
		"pathos": lowest_pathos,
		"amount": lowest_pathos_amount
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	if key == "accept":
		globals.player.pathos.modify_released_pathos(pathos_choice_payments[key]["pathos"], pathos_choice_payments[key]["amount"])
		# warning-ignore:return_value_discarded
		globals.player.deck.add_new_card("Discombobulation")
	end()
	globals.journal.display_nce_rewards('')

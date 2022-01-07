# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

var secondary_choices := {
		'alpha': '[alpha]: {alpha} Lose {lowest_pathos_cost} released {lowest_pathos}. {alpha_desc}',
		'kappa': '[kappa]: {frozen} Lose {highest_pathos_cost} released {highest_pathos}. {kappa_desc}',
		'omega': '[omega]: {omega} Lose {middle_pathos_cost} released {middle_pathos}. {omega_desc}',
		'leave': '[Leave]: Nothing Happens.',
	}
var pathos_choice_payments := {}
var card_choice_descriptions := {
		'alpha': 'Choose a card which always starts at the bottom of your deck.',
		'kappa': 'Choose a card which is not discarded at the end of your turn.',
		'omega': 'Choose a card which always starts at the top of your deck.',
}

func _init():
	description = "<Multiple Tags - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var pathos_org = globals.player.pathos.get_pathos_org()
#	print_debug(pathos_org)
	var highest_pathos = pathos_org["highest_pathos"]["selected"]
	var lowest_pathos = pathos_org["lowest_pathos"]["selected"]
	var middle_pathos = pathos_org["middle_pathos"]["selected"]
	var lowest_pathos_cost = globals.player.pathos.get_progression_average(lowest_pathos) * 2
	var middle_pathos_cost = globals.player.pathos.get_progression_average(middle_pathos) * 5
	var highest_pathos_cost = globals.player.pathos.get_progression_average(highest_pathos) * 7
	var scformat = {
		"lowest_pathos": lowest_pathos,
		"lowest_pathos_cost":  lowest_pathos_cost,
		"middle_pathos": middle_pathos,
		"middle_pathos_cost":  middle_pathos_cost,
		"highest_pathos": highest_pathos,
		"highest_pathos_cost":  highest_pathos_cost,
		"alpha_desc": card_choice_descriptions.alpha,
		"kappa_desc": card_choice_descriptions.kappa,
		"omega_desc": card_choice_descriptions.omega,
	}
	pathos_choice_payments["alpha"]  = {
		"pathos": lowest_pathos,
		"cost": lowest_pathos_cost
	}
	pathos_choice_payments["kappa"] = {
		"pathos": middle_pathos,
		"cost": middle_pathos_cost
	}
	pathos_choice_payments["omega"] = {
		"pathos": highest_pathos,
		"cost": highest_pathos_cost
	}
	secondary_choices['alpha'] = secondary_choices['alpha'].format(scformat).format(Terms.get_bbcode_formats(18))
	secondary_choices['kappa'] = secondary_choices['kappa'].format(scformat).format(Terms.get_bbcode_formats(18))
	secondary_choices['omega'] = secondary_choices['omega'].format(scformat).format(Terms.get_bbcode_formats(18))
	var disabled_choices := []
	for type in ['alpha', 'kappa', 'omega']:
		secondary_choices[type] = secondary_choices[type].format(scformat)
		if globals.player.pathos.released[pathos_choice_payments[type]["pathos"]]\
				< pathos_choice_payments[type]["cost"]:
			secondary_choices[type] = "[color=red]" + secondary_choices[type] + "[/color]"
			disabled_choices.append(type)
	globals.journal.add_nested_choices(secondary_choices, disabled_choices)

func continue_encounter(key) -> void:
	var tag_name: String
	var card_choice_description
	match key:
		"alpha":
			tag_name = Terms.GENERIC_TAGS.alpha.name
			card_choice_description = card_choice_descriptions.alpha
		"kappa":
			tag_name = Terms.GENERIC_TAGS.frozen.name
			card_choice_description = card_choice_descriptions.kappa
		"omega":
			tag_name = Terms.GENERIC_TAGS.omega.name
			card_choice_description = card_choice_descriptions.omega
	if key != "leave":
		var card_filters = [CardFilter.new('Tags', tag_name, 'ne')]
#		modified_card.modify_property(property, new_value)
		var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
		# warning-ignore:return_value_discarded
		selection_deck.connect("operation_performed", self, "_on_card_selected", [tag_name])
		selection_deck.auto_close = true
		selection_deck.card_filters = card_filters
		selection_deck.initiate_card_selection(0)
		selection_deck.update_header(card_choice_description\
				.format(Terms.get_bbcode_formats(18)))
		selection_deck.update_color(Color(0,1,0))
		globals.player.pathos.released[pathos_choice_payments[key]["pathos"]]\
				-= pathos_choice_payments[key]["cost"]

	end()
	globals.journal.display_nce_rewards('')

func _on_card_selected(operation_details: Dictionary, tag_name: String) -> void:
	operation_details.card_entry.modify_property('Tags', tag_name)

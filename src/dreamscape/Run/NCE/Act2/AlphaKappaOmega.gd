extends NonCombatEncounter

const MASTERIES_AMOUNT := {
	"omega": round(Pathos.MASTERY_BASELINE),
	"alpha": round(Pathos.MASTERY_BASELINE * 2),
	"kappa": round(Pathos.MASTERY_BASELINE * 4),
}

var secondary_choices := {
		'omega': '[omega]: {omega} Lose {bcolor:{omega_cost} {masteries}:}. {gcolor:{omega_desc}:}',
		'alpha': '[alpha]: {alpha} Lose {bcolor:{alpha_cost} {masteries}:}. {gcolor:{alpha_desc}:}',
		'kappa': '[kappa]: {frozen} Lose {bcolor:{kappa_cost} {masteries}:}. {gcolor:{kappa_desc}:}',
		'leave': '[Leave]: Nothing Happens.',
	}

var card_choice_descriptions := {
		'omega': 'Choose a card which always starts at the bottom of your deck.',
		'alpha': 'Choose a card which always starts at the top of your deck.',
		'kappa': 'Choose a card which is not discarded at the end of your turn.',
}

func _init():
	description = "I came across a faceless monk with inumerable arms." \
		+ " \"I am the monk Chance,\" the monk seemed to say from nowhere, \"disciple of the goddess Lady Luck.\"" \
		+ "\"Would you like the power to control your fate?\""

func begin() -> void:
	.begin()
	var scformat = {
		"omega_cost": MASTERIES_AMOUNT["omega"],
		"alpha_cost": MASTERIES_AMOUNT["alpha"],
		"kappa_cost": MASTERIES_AMOUNT["kappa"],
		"omega_desc": card_choice_descriptions.omega,
		"alpha_desc": card_choice_descriptions.alpha,
		"kappa_desc": card_choice_descriptions.kappa,
	}
	var disabled_choices := []
	for type in ['alpha', 'kappa', 'omega']:
		if globals.player.pathos.available_masteries < MASTERIES_AMOUNT[type]:
			disabled_choices.append(type)
	_prepare_secondary_choices(secondary_choices, scformat, disabled_choices)

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
		selection_deck.popup_exclusive = true
		# warning-ignore:return_value_discarded
		selection_deck.connect("operation_performed", self, "_on_card_selected", [tag_name])
		selection_deck.auto_close = true
		selection_deck.card_filters = card_filters
		selection_deck.initiate_card_selection(0)
		selection_deck.update_header(card_choice_description\
				.format(Terms.get_bbcode_formats(18)))
		selection_deck.update_color(Color(0,1,0))
		globals.player.pathos.available_masteries -= MASTERIES_AMOUNT[key]
	end()
	globals.journal.display_nce_rewards('')

func _on_card_selected(operation_details: Dictionary, tag_name: String) -> void:
	operation_details.card_entry.modify_property('Tags', tag_name, true)

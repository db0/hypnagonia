# Gives three choices, paid with released pathos to get some rewards

extends NonCombatEncounter

# TODO: Fluff
var secondary_choices := {
		'Action': '[choice1]: {release} a random {action}.',
		'Control': '[choice2]: {release} a random {control}.',
		'Concentration': '[choice3]: {release} a random {concentration}.',
		'Understanding': '[choice4]: {release} a random {perturbation}.',
	}

# TODO: Fluff
var final_text = "{selected_card} was released"

var cards_per_type := {}

func _init():
	# TODO: Fluff
	description = "<Multiple Options - Story Fluff to be Done>. Select one Option...."

func begin() -> void:
	.begin()
	var disabled_choices := []
	for type in secondary_choices:
		secondary_choices[type] = secondary_choices[type].format(Terms.get_bbcode_formats(18))
		cards_per_type[type] = globals.player.deck.filter_cards(CardFilter.new('Type', type))
		if cards_per_type[type].size() == 0:
			secondary_choices[type] = "[color=red]" + secondary_choices[type] + "[/color]"
			disabled_choices.append(type)
	globals.journal.add_nested_choices(secondary_choices, disabled_choices)

func continue_encounter(key) -> void:
	CFUtils.shuffle_array(cards_per_type[key])
	var card_to_remove = cards_per_type[key][0]
	globals.player.deck.remove_card(card_to_remove)
	var ftformat = {
		"selected_card": _prepare_card_popup_bbcode(card_to_remove, card_to_remove.card_name),
	}	
	end()
	globals.journal.display_nce_rewards(final_text.format(ftformat))

extends NonCombatEncounter

var amounts := {
	'scold': "defence_amount",
	'flail': "damage_amount",
	'ignore': "draw_amount",
}
var secondary_choices := {
		'scold': '[Scold them for misbehaving]: Choose one card which provides {defence}. '\
				+ 'Increase that value by [color=yellow]1[/color].',
		'flail': '[Flail them wildly]: Choose one card which provides {damage}. '\
				+ 'Increase that value by [color=yellow]1[/color].',
		'ignore': '[Ignore them]: Choose one card which draws cards. '\
				+ 'Increase the amount drawn value by [color=yellow]1[/color].',
	}

var nce_result_fluff := {
		'scold': "They reverted to their original form, in shame. That's better.",
		'flail': "I started shaking them in panic and to my surprise, it worked!",
		'ignore': "I didn't have time for this. I'm sure it wouldn't be a big deal.",
	}

var hand_mutations := [
	"they had a football at each end",
	"they had tentacles for fingers",
	"they turned into hammers",
	"they grew a mouth at each fingertip and were singing shea shanties together",
	"they had birds nesting on them",
	"their fingers were burning like candles",
]

func _init():
	CFUtils.shuffle_array(hand_mutations)
	var fmt = {"hand_mutation": hand_mutations[0]}
	description = "I remember looking at my arms, and to my surprise finding {hand_mutation}. ".format(fmt)


func begin() -> void:
	# warning-ignore:return_value_discarded
	.begin()
	var scformat := {}
	for key in secondary_choices:
		secondary_choices[key] = secondary_choices[key].format(scformat).format(Terms.get_bbcode_formats(18))
	var disabled_choices := []
	for type in amounts:
		if globals.player.deck.filter_card_on_amounts(amounts[type]).size() == 0:
			secondary_choices[type] = "[color=red]" + secondary_choices[type] + "[/color]"
			disabled_choices.append(type)
	# Failsafe in case the player has no card draw, no interpretation and no confidence.
	if disabled_choices.size() >= 3:
		globals.journal.display_nce_rewards('')
		end()
	else:
		globals.journal.add_nested_choices(secondary_choices, disabled_choices)

func continue_encounter(key) -> void:
	var card_choice_description: String
	match key:
		"scold":
			card_choice_description = "Choose a card that provides Confidence"
		"flail":
			card_choice_description = "Choose a card that Interprets"
		"ignore":
			card_choice_description = "Choose a card that draws cards"
	var card_filters = [CardFilter.new('_amounts', amounts[key], 'eq')]
	var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
	selection_deck.popup_exclusive = true
	# warning-ignore:return_value_discarded
	var payload := {
		"amount_key": amounts[key],
		"amount_value": '+1',
	}
	selection_deck.connect("operation_performed", self, "_on_card_selected", [payload])
	selection_deck.auto_close = true
	selection_deck.card_filters = card_filters
	selection_deck.initiate_card_selection(0)
	selection_deck.update_header(card_choice_description\
			.format(Terms.get_bbcode_formats(18)))
	selection_deck.update_color(Color(0,1,0))
	globals.journal.display_nce_rewards(nce_result_fluff[key])
	end()


func _on_card_selected(operation_details: Dictionary, payload: Dictionary) -> void:
	operation_details.card_entry.modify_property('_amounts', payload)

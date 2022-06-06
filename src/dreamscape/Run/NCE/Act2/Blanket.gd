extends NonCombatEncounter

const PATHOS_AVG_MULTIPLIER = 2.0
const PATHOS_TYPE = Terms.RUN_ACCUMULATION_NAMES.shop

var pathos_gained : float
var pathos_type = globals.player.pathos.pathi[PATHOS_TYPE]

var secondary_choices := {
		'sleep': '[Sleep]: Choose and {bcolor:[url={"definition": "scar","meta_type": "definition"}]Scar[/url] a card:} then {gcolor:create a copy of it:}.',
		'throw': '[Throw it off]: Gain {bcolor:{pathos_amount} {repressed_{pathos_type}}:}',
	}

var nce_result_fluff := {
		'sleep': "I power through the heat and feel it enclosing me. The familiarity can be too much sometimes but it reminds me what is good in my life.",
		'throw': "I can't take this tonight. I throw it off and try to ignore the chill from the environment and from its grudge as best I can.",
	}

func _init():
	description = """
My blanket was my only friend, but it has been giving me strange vibes.
Every night when I got home it got absurdly clingy, especially when we were watching movies in bed together.
Today, I felt the heat stifling me.
"""
#	prepare_journal_art(load("res://assets/journal/nce/chasm.jpeg"))

func begin() -> void:
	.begin()
	pathos_gained = ceil(pathos_type.get_progression_average()\
			* PATHOS_AVG_MULTIPLIER * CFUtils.randf_range(0.8,1.2))
	var scformat = {
		"pathos_amount": pathos_gained,
		"pathos_type": PATHOS_TYPE,
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"sleep":
			var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
			selection_deck.popup_exclusive = true
			# warning-ignore:return_value_discarded
			selection_deck.connect("operation_performed", self, "_on_card_selected")
			selection_deck.auto_close = true
			selection_deck.initiate_card_selection(0)
			selection_deck.update_header("(Scar and Copy Card)")
			selection_deck.update_color(Color(0,1,0))
		"throw":
			pathos_type.repressed += pathos_gained
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])


func _on_card_selected(operation_details: Dictionary) -> void:
	var copied_card = operation_details.card_entry
	copied_card.scar()
	globals.player.deck.duplicate_card(copied_card)

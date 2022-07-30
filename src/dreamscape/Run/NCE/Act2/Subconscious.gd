extends NonCombatEncounter

const DAMAGE_AMOUNT := 7
const MASTERIES_AMOUNT := round(Pathos.MASTERY_BASELINE * 0.5)

var secondary_choices := {
		'intrerpret': '[intrerpret]: {bcolor:+{damage_amount} {anxiety_up}:}. {gcolor:Gain {subconscious}:}',
		'avoid': '[avoid]: Gain {gcolor:{masteries_amount} {masteries}:}.',
	}
	
var nce_result_fluff := {
		'intrerpret': '<Intrerpret Choice Result - Story Fluff to be Done>',
		'avoid': '<Avoid Choice Result - Story Fluff to be Done>',
	}

var lowest_pathos: String
var lowest_pathos_amount: float
var pathos_type_lowest : PathosType

func _init():
	description = "<Subconscious - Story Fluff to be Done>. Select one Option...."
	prepare_journal_art(load("res://assets/journal/nce/Subconscious.jpg"))

func begin() -> void:
	.begin()
	var scformat = {
		"masteries_amount": MASTERIES_AMOUNT,
		"damage_amount":  DAMAGE_AMOUNT,
		"subconscious": _prepare_card_popup_bbcode("Subconscious", " an insight into your own mind."),
	}
	_prepare_secondary_choices(secondary_choices, scformat)

func continue_encounter(key) -> void:
	match key:
		"avoid":
			globals.player.pathos.available_masteries += MASTERIES_AMOUNT
		"intrerpret":
			# warning-ignore:return_value_discarded
			globals.player.damage += DAMAGE_AMOUNT
			globals.player.deck.add_new_card("Subconscious")
	end()
	globals.journal.display_nce_rewards(nce_result_fluff[key])

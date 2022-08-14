# Gives three choices to gain pathos. Each with increasing amount of anxiety gained

extends NonCombatEncounter

const journal_description = "I dreamed of a large endless abyss. I could not see the bottom but I felt its pull. What did I do..?"
const ai_prompts:= [
	"I dreamed of a large endless abyss. I could not see the bottom but I felt its pull",
	"The yawning pit in the ground was strangely welcoming. I could feel oblivion itself pulling",
]


var secondary_choices := {
		'fall_in': '[Fall in]: {bcolor:+3 {anxiety_up}:}. {gcolor:Remove all perturbations from your deck:}.',
		'leave': '[Leave]: Nothing happens.',
	}
var nce_resul_fluff := {
		'fall_in': 'I dove into the unknown. I experienced a brief moment of panic before a sleep-like-oblivion took me...',
		'leave': 'The unknown blackness was not welcoming, the dream changed...',
	}
	

func _init():
	introduction.setup_with_vars("Sleep of Oblivion",journal_description, "",ai_prompts)
	prepare_journal_art(load("res://assets/journal/nce/Sleep of Oblivion.jpg"))
	
func begin() -> void:
	.begin()
	_prepare_secondary_choices(secondary_choices, {})

func continue_encounter(key) -> void:
	match key:
		"fall_in":
			globals.player.damage += 3
			globals.encounters.deep_sleeps += 1
			var card_filters := [
				CardFilter.new("Type","Perturbation"),
				CardFilter.new("_is_unremovable", false),
			]
			var all_perturbations : Array = globals.player.deck.filter_cards(card_filters)
			for card_entry in all_perturbations:
				globals.player.deck.remove_card(card_entry)
	end()
	globals.journal.display_nce_rewards(nce_resul_fluff[key])

# Gives three choices to gain pathos. Each with increasing amount of anxiety gained

extends NonCombatEncounter

var secondary_choices := {
		'fall_in': '[Fall in]: Take 3 anxiety. Remove all perturbations from your deck.',
		'leave': '[Leave]: Nothing happens.',
	}
var nce_resul_fluff := {
		'fall_in': 'I dove into the unknown. I experienced a brief moment of panic before a sleep-like-oblivion took me...',
		'leave': 'The unknown blackness was not welcoming, the dream changed...',
	}
	

func _init():
	description = "I dreamed of a large endless abyss. I could not see the bottom but I felt its pull. What did I do..?"

func begin() -> void:
	.begin()
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	match key:
		"fall_in":
			globals.player.damage += 3
			globals.encounters.deep_sleeps += 1
			for card_entry in globals.player.deck.get_sorted_cards():
				if card_entry.get_property("Type") == "Perturbation":
					globals.player.deck.remove_card(card_entry)
	end()
	globals.journal.display_nce_rewards(nce_resul_fluff[key])

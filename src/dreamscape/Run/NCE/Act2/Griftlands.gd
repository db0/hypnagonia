extends NonCombatEncounter

var secondary_choices := {
		'spy': '[Spy]: Gain 1 random Common card from your Ego card pool.',
		'double-cross': '[double-cross]: 7 Anxiety. Gain 1 random Uncommon card from your Ego card pool.',
		'triple-cross': '[triple-cross]: 15 Anxiety. Gain 1 random Rare card from your Ego card pool.',
	}
	
var nce_result_fluff := {
		'spy': "I decided to play it straight. I identified the strongest faction"\
			+ ", joined them, and helped them take over the town.",
		'double-cross': "The town was so evenly divided, the best play was to play both sides. "\
			+ "I kept these divisions up, and got rich in the process.",
		'triple-cross': "I made everyone believe I was working for them, but in truth, "\
			+ "I had my own motives and a secret patron I was already working for...",
	}


func _init():
	description = "This time, I was part of some strange fantasy western world. "\
			+ "In it, I was a trained spy, coming into a frontier town, and I had to decide how to behave."


func begin() -> void:
	.begin()
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	var ego = globals.player.deck_groups[Terms.CARD_GROUP_TERMS.class]
	var rarity : String
	match key:
		"spy":
			rarity = "Common"
		"double-cross":
			globals.player.damage += 7
			rarity = "Uncommon"
		"triple-cross":
			globals.player.damage += 15
			rarity = "Rare"
	var cards = Aspects.get_all_cards_in_archetype(ego, [rarity])
	CFUtils.shuffle_array(cards)
	globals.player.deck.add_new_card(cards[0])
	globals.journal.display_nce_rewards(nce_result_fluff[key])

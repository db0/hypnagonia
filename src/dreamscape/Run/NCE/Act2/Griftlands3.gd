extends NonCombatEncounter

var secondary_choices := {
		'lay_low': '[Lay Low]: Gain 1 random Common card from your Injustice card pool.',
		'clear_name': '[Clear your Name]: 7 Anxiety. Gain 1 random Uncommon card from your Injustice card pool.',
		'revenge': '[Take Revenge]: 15 Anxiety. Gain 1 random Rare card from your Injustice card pool.',
	}


var nce_result_fluff := {
		'lay_low': "It was time to hide until this all blew over.",
		'clear_name': "I had nothing to hide, but I had to fight to clear my name.",
		'revenge': "Whoever was behind this, was gonna rue the day.",
	}


func _init():
	description = "Once again, I found myself in the fantasy western world. "\
			+ "Now I was a rugged warrior, with a bounty on my head.\n"\
			+ "I had been framed..."


func begin() -> void:
	.begin()
	globals.journal.add_nested_choices(secondary_choices)

func continue_encounter(key) -> void:
	var ego = globals.player.deck_groups[Terms.CARD_GROUP_TERMS.life_goal]
	var rarity : String
	match key:
		"lay_low":
			rarity = "Common"
		"clear_name":
			globals.player.damage += 7
			rarity = "Uncommon"
		"revenge":
			globals.player.damage += 15
			rarity = "Rare"
	var cards = Aspects.get_all_cards_in_archetype(ego, [rarity])
	CFUtils.shuffle_array(cards)
	# warning-ignore:return_value_discarded
	globals.player.deck.add_new_card(cards[0])
	globals.journal.display_nce_rewards(nce_result_fluff[key])

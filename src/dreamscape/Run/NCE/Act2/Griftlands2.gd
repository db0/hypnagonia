extends NonCombatEncounter

var secondary_choices := {
		'drink': '[Drown your sorrows]: Gain {gcolor:1 random Common card:} from your Disposition card pool.',
		'gamble': '[Gamble your inheritance]: {bcolor:+7:} {anxiety_up}. Gain {gcolor:1 random Uncommon card:} from your Disposition card pool.',
		'investigate': '[Investigate]: {bcolor:+15:} {anxiety_up}. Gain {gcolor:1 random Rare card:} from your Disposition card pool.',
	}
const journal_description = "Once again, I found myself in the fantasy western world. "\
			+ "This time I was some sort of amphibian humanoid with a drinking problem, ."\
			+ "and I found out my rich elders has passed away in mysterious circumstances"


var nce_result_fluff := {
		'drink': "Who cares! I decided to party it out!",
		'gamble': "I got a hefty sum out of my inheritance, even though my siblings mostly did it to "\
			+ "get rid of me. It was time to hit the games...",
		'investigate': "Something smelled fishy, and it wasn't myself for once."\
			+ "I decided to get to the bottom of this, and discovered a conspiracy "\
			+ "among all my siblings. They underestimated me for the last time.",
	}


func _init():
	introduction.setup_with_vars("Griftlands 2",journal_description, "Something's Fishy in the Wasteland Port")
	prepare_journal_art(load("res://assets/journal/nce/Griftlands.jpg"))


func begin() -> void:
	.begin()
	_prepare_secondary_choices(secondary_choices, {})

func continue_encounter(key) -> void:
	var ego = globals.player.deck_groups[Terms.CARD_GROUP_TERMS.race]
	var rarity : String
	match key:
		"drink":
			rarity = "Common"
		"gamble":
			globals.player.damage += 7
			rarity = "Uncommon"
		"investigate":
			globals.player.damage += 15
			rarity = "Rare"
	var cards = Aspects.get_all_cards_in_archetype(ego, [rarity])
	CFUtils.shuffle_array(cards)
	# warning-ignore:return_value_discarded
	globals.player.deck.add_new_card(cards[0])
	end()
	nce_result_fluff[key] += "\nCard Gained: " + _prepare_card_popup_bbcode(cards[0], cards[0])
	globals.journal.display_nce_rewards(nce_result_fluff[key])

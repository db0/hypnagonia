extends Node

var deck_groups : Dictionary = {
	Terms.CARD_GROUP_TERMS.class: "Flyer",
	Terms.CARD_GROUP_TERMS.race: "Fearless",
	Terms.CARD_GROUP_TERMS.item: "Rubber Chicken",
	Terms.CARD_GROUP_TERMS.life_goal: "Abusive Relationship",
}

var deck: Deck

# Test setup. This should happen at game start
func _ready() -> void:
	deck = Deck.new()
	for group in deck_groups:
		deck.update_card_group(group, deck_groups[group])
	deck.assemble_starting_deck()

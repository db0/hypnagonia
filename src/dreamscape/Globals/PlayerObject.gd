class_name Player
extends Reference

var health: int = 90
var damage: int
var deck: Deck

#var deck_groups : Dictionary = {
#	Terms.CARD_GROUP_TERMS.class: "Flyer",
#	Terms.CARD_GROUP_TERMS.race: "Fearless",
#	Terms.CARD_GROUP_TERMS.item: "Rubber Chicken",
#	Terms.CARD_GROUP_TERMS.life_goal: "Abusive Relationship",
#}
var deck_groups : Dictionary = {
	Terms.CARD_GROUP_TERMS.class: null,
	Terms.CARD_GROUP_TERMS.race: null,
	Terms.CARD_GROUP_TERMS.item: null,
	Terms.CARD_GROUP_TERMS.life_goal: null,
}

func is_deck_completed() -> bool:
	for archetype in deck_groups:
		if not deck_groups[archetype]:
			return(false)
	return(true)

func setup() -> void:
	deck = Deck.new(deck_groups)
	for group in deck_groups:
		# Each deck group can modify the player's max health
		health += CardGroupDefinitions[group.to_upper()][deck_groups[group]].get(Terms.PLAYER_TERMS.health,0)
	deck.assemble_starting_deck()

func get_currrent_archetypes() -> Array:
	var all_archetypes := []
	for archetype in deck_groups:
		if deck_groups[archetype]:
			all_archetypes.append(deck_groups[archetype])
	return(all_archetypes)

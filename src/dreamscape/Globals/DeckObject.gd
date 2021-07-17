class_name Deck
extends Reference

var cards: Array
var deck_groups : Dictionary

func _init(_deck_groups) -> void:
	deck_groups = _deck_groups

func assemble_starting_deck() -> void:
	for key in deck_groups:
		for card_name in CardGroupDefinitions[key.to_upper()][deck_groups[key]]["Starting Cards"]:
			var new_card := CardEntry.new(card_name)
			cards.append(new_card)

func update_card_group(type: String, card_group: String) -> void:
	deck_groups[type] = card_group
	
func instance_cards() -> Array:
	var card_nodes := []
	for card_entry in cards:
		card_nodes.append(card_entry.instance_self())
	return(card_nodes)

func add_new_card(card_name) -> void:
	var new_card := CardEntry.new(card_name)
	cards.append(new_card)

func list_all_cards(sorted:= false) -> Array:
	var card_list := []
	for card_entry in cards:
		card_list.append(card_entry.card_name)
	if sorted:
		card_list.sort()
	return(card_list)

func count_cards() -> int:
	return(list_all_cards().size())

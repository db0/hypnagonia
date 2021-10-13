class_name Deck
extends Reference

signal card_added(card)
signal card_removed(card)

var cards: Array
var deck_groups : Dictionary

func _init(_deck_groups) -> void:
	deck_groups = _deck_groups


func assemble_starting_deck() -> void:
	for key in deck_groups:
		for card_name in Aspects[key.to_upper()][deck_groups[key]]["Basic"]:
			var new_card := CardEntry.new(card_name)
			cards.append(new_card)


func update_card_group(type: String, card_group: String) -> void:
	deck_groups[type] = card_group


func instance_cards() -> Array:
	var card_nodes := []
	for card_entry in cards:
		card_nodes.append(card_entry.instance_self())
	return(card_nodes)


# Adds a new card to the deck, 
# and optionally starts it with some ugprade progress
func add_new_card(card_name, progress := 0) -> void:
	var new_card := CardEntry.new(card_name)
	new_card.upgrade_progress = progress
	cards.append(new_card)
	emit_signal("card_added", new_card)


func remove_card(card_entry: CardEntry) -> void:
	emit_signal("card_removed", card_entry)
	cards.erase(card_entry)


func list_all_cards(sorted:= false) -> Array:
	var card_list := []
	for card_entry in cards:
		card_list.append(card_entry.card_name)
	if sorted:
		card_list.sort()
	return(card_list)


func count_cards() -> int:
	return(list_all_cards().size())


# Gets all cards which have enough progress to be upgraded
func get_upgradeable_cards() -> Array:
	var upgradeable_cards := []
	for card_entry in cards:
		if card_entry.can_be_upgraded():
			upgradeable_cards.append(card_entry)
	return(upgradeable_cards)


func count_upgradeable_cards() -> int:
	return(get_upgradeable_cards().size())


func get_progressing_cards() -> Array:
	var progressing_cards := []
	for card_entry in cards:
		if not card_entry.can_be_upgraded():
			progressing_cards.append(card_entry)
	return(progressing_cards)


func count_progressing_cards() -> int:
	return(get_progressing_cards().size())


func get_upgraded_cards() -> Array:
	var upgraded_cards := []
	for card_entry in cards:
		if card_entry.is_upgraded():
			upgraded_cards.append(card_entry)
	return(upgraded_cards)


func count_upgraded_cards() -> int:
	return(get_upgraded_cards().size())


func get_upgrade_percentage() -> float:
	var upg_cards : float = count_upgradeable_cards() + count_upgraded_cards()
	var all_cards : float = count_cards()
	return(upg_cards / all_cards)


func get_upgradable_card_type(type:= "least_progress") -> CardEntry:
	var upg_cards := get_progressing_cards()
	var results_dict := {
		"least_progress": {
			"cards":[],
			"value": 0
		},
		"most_progress": {
			"cards":[],
			"value": 0
		},
	}
	for ce in upg_cards:
		if results_dict[type]["value"] == ce.upgrade_progress:
			results_dict[type]["cards"].append(ce)
		elif results_dict[type]["value"] > ce.upgrade_progress:
			results_dict["most_progress"]["cards"] = [ce]
			results_dict["most_progress"]["value"] = ce.upgrade_progress
		elif results_dict[type]["value"] < ce.upgrade_progress:
			results_dict["least_progress"]["cards"] = [ce]
			results_dict["least_progress"]["value"] = ce.upgrade_progress
	if results_dict[type]["cards"].size() > 1:
		CFUtils.shuffle_array(results_dict[type]["cards"])
	return(results_dict[type]["cards"][0])


# Returns a list of all card entries with a specific property match
func filter_cards(property: String, filter) -> Array:
	var card_list := []
	for card_entry in cards:
		var card_prop = card_entry.get_property(property)
		# If the property is an array, we assume the player is trying to 
		# match an element in it
		if typeof(card_prop) == TYPE_ARRAY:
			if filter in card_prop:
				card_list.append(card_entry)
		elif typeof(card_prop) == typeof(filter):
			if card_entry.get_property(property) == filter:
				card_list.append(card_entry)
		else:
			if str(card_entry.get_property(property)) == str(filter):
				card_list.append(card_entry)
	return(card_list)

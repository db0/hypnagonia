class_name Deck
extends Reference

signal card_added(card)
signal card_duplicated(card, duplicate)
signal card_removed(card)
signal card_entry_upgraded(card_entry)
signal card_entry_modified(card_entry)
signal card_entry_progressed(card_entry, amount)
signal card_entry_used(card_entry)

var cards: Array
var deck_groups : Dictionary

func _init(_deck_groups) -> void:
	deck_groups = _deck_groups


func assemble_starting_deck() -> void:
	for key in deck_groups:
		for card_name in Aspects[key.to_upper()][deck_groups[key]]["Basic"]:
			var _new_card := add_new_card(card_name)
	for iter in globals.difficulty.starting_perturbations:
		var rng_perturbation = Perturbations.get_random_perturbation(
				Perturbations.get_archetype_perturbations_chance())
		# warning-ignore:return_value_discarded
		add_new_card(rng_perturbation)
	if globals.difficulty.unremovable_perturbation:
		# warning-ignore:return_value_discarded
		add_new_card("Hubris")


func update_card_group(type: String, card_group: String) -> void:
	deck_groups[type] = card_group


func instance_cards() -> Array:
	var card_nodes := []
	for card_entry in cards:
		card_nodes.append(card_entry.instance_self())
	return(card_nodes)


# Adds a new card to the deck,
# and optionally starts it with some ugprade progress
func add_new_card(card_name: String, progress := 0) -> CardEntry:
	if OS.has_feature("debug") and not cfc.get_tree().get_root().has_node('Gut'):
		print("DEBUG INFO:Deck: Adding new card:" + card_name)
	var new_card := CardEntry.new(card_name)
	# warning-ignore:return_value_discarded
	new_card.connect("card_entry_modified", self, "signal_card_entry_modified")
	# warning-ignore:return_value_discarded
	new_card.connect("card_entry_upgraded", self, "signal_card_entry_upgraded")
	# warning-ignore:return_value_discarded
	new_card.connect("card_entry_progressed", self, "signal_card_entry_progressed")
	# warning-ignore:return_value_discarded
	new_card.connect("card_entry_used", self, "signal_card_entry_used")
	new_card.upgrade_progress = progress
	cards.append(new_card)
	emit_signal("card_added", new_card)
	return(new_card)


func remove_card(card_entry: CardEntry) -> void:
	if OS.has_feature("debug") and not cfc.get_tree().get_root().has_node('Gut'):
		print("DEBUG INFO:Deck: Removing card:" + card_entry.card_name)
	if card_entry.properties.get("_is_unremovable", false):
		return
	# As a failsafe, we do not allow to remove the last card
	if cards.size() > 1:
		card_entry.disconnect("card_entry_modified", self, "signal_card_entry_modified")
		card_entry.disconnect("card_entry_upgraded", self, "signal_card_entry_upgraded")
		card_entry.disconnect("card_entry_progressed", self, "signal_card_entry_progressed")
		cards.erase(card_entry)
		emit_signal("card_removed", card_entry)
	elif OS.has_feature("debug") and not cfc.get_tree().get_root().has_node('Gut'):
		print("DEBUG INFO:Deck: Card Removal Block because: Last card in deck")

func duplicate_card(card_entry: CardEntry) -> CardEntry:
	var new_card = card_entry.duplicate()
	cards.append(new_card)
	emit_signal("card_added", new_card)
	emit_signal("card_duplicated", card_entry, new_card)
	return(new_card)

func signal_card_entry_upgraded(card_entry: CardEntry) -> void:
	emit_signal("card_entry_upgraded", card_entry)

func signal_card_entry_modified(card_entry: CardEntry) -> void:
	emit_signal("card_entry_modified", card_entry)

func signal_card_entry_progressed(card_entry: CardEntry, amount: int) -> void:
	emit_signal("card_entry_progressed", card_entry, amount)

func signal_card_entry_used(card_entry: CardEntry) -> void:
	emit_signal("card_entry_used", card_entry)


func list_all_cards(sorted:= false) -> Array:
	var card_list := []
	for card_entry in cards:
		card_list.append(card_entry.card_name)
	if sorted:
		card_list.sort()
	return(card_list)


# Returns the cardlist array sorted by card_name
func get_sorted_cards() -> Array:
	var sorted_array := cards.duplicate()
	sorted_array.sort_custom(CFUtils, "sort_scriptables_by_name")
	return(sorted_array)


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
		if card_entry.is_progressing():
			progressing_cards.append(card_entry)
	return(progressing_cards)

func get_card_needing_most_progress() -> CardEntry:
	var selected_card: CardEntry
	var most_progress_needed := 0
	for card_entry in get_progressing_cards():
		if most_progress_needed == 0:
			selected_card = card_entry
			most_progress_needed = card_entry.upgrade_threshold - card_entry.upgrade_progress
		elif card_entry.upgrade_threshold - card_entry.upgrade_progress > most_progress_needed:
			selected_card = card_entry
			most_progress_needed = card_entry.upgrade_threshold - card_entry.upgrade_progress
	return(selected_card)

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
		elif results_dict[type]["value"] < ce.upgrade_progress:
			results_dict["most_progress"]["cards"] = [ce]
			results_dict["most_progress"]["value"] = ce.upgrade_progress
		elif results_dict[type]["value"] > ce.upgrade_progress:
			results_dict["least_progress"]["cards"] = [ce]
			results_dict["least_progress"]["value"] = ce.upgrade_progress
	if results_dict[type]["cards"].size() > 1:
		CFUtils.shuffle_array(results_dict[type]["cards"])
	return(results_dict[type]["cards"].front())


# Returns a list of all card entries with a specific property match
# filters can be either a single CardFilter object, or an array of CardFilter objects
func filter_cards(filters) -> Array:
	var card_list := []
	for c in cards:
		var card_entry: CardEntry = c
		if typeof(filters) == TYPE_ARRAY:
			var card_matches = true
			for f in filters:
				var filter: CardFilter = f
				if not filter.check_card(card_entry.properties):
					card_matches = false
			if card_matches:
				card_list.append(card_entry)
		elif filters as CardFilter:
			var filter: CardFilter = filters
			if filter.check_card(card_entry.properties):
				card_list.append(card_entry)
	return(card_list)


# Returns a list of all card entries with a specific amount type
# in their _amounts dictionary
func filter_card_on_amounts(amount_name: String) -> Array:
	var card_list := []
	for c in cards:
		var card_entry: CardEntry = c
		var card_amounts = card_entry.properties.get("_amounts", {})
		if card_amounts.has(amount_name):
			card_list.append(card_entry)
	return(card_list)


# Returns a random card from this deck object
# A custom list of objects can also be passed and it will return
# a card from there
# For example you can feed it the results of filter_cards()
func get_random_card(card_list = cards) -> CardEntry:
	var rng_array = card_list.duplicate()
	CFUtils.shuffle_array(rng_array)
	return(rng_array.back())

func extract_save_state() -> Array:
	var deck_array := []
	for ce in cards:
		deck_array.append(ce.extract_save_state())
	return(deck_array)

func restore_save_state(saved_cards: Array) -> void:
	for ce_dict in saved_cards:
		restore_card_entry(ce_dict)
		
func restore_card_entry(saved_entry: Dictionary) -> void:
	var new_card = add_new_card(saved_entry.card_name)
	new_card.restore_save_state(saved_entry)

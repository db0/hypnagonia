class_name ModifyPropertyArtifact
extends Artifact

enum SelectionType {
	CHOICE
	RANDOM
}

var modified_card: CardEntry
var selection_type: int =  SelectionType.CHOICE
var property: String
var new_value
# This must be an Array of CardFilter objects
var card_filters := []
var card_choice_description := ''

func _on_artifact_added() -> void:
	if property == '':
		print_debug("ERROR: 'property' var has to be set before calling this function.")
		return
	if selection_type == SelectionType.CHOICE:
		if card_choice_description == '':
			card_choice_description = "Choose a card to modify with " + artifact_object.definition["name"] 
		var selection_deck : SelectionDeck = globals.journal.spawn_selection_deck()
		# warning-ignore:return_value_discarded
		selection_deck.connect("operation_performed", self, "_on_card_selected")
		selection_deck.auto_close = true
		selection_deck.card_filters = card_filters
		selection_deck.initiate_card_selection(0)
		selection_deck.update_header(card_choice_description\
				.format(Terms.get_bbcode_formats(18)))
		selection_deck.update_color(Color(0,1,0))
		# warning-ignore:return_value_discarded
	else:
		var potential_cards : Array
		if not card_filters.empty():
			potential_cards = globals.player.deck.filter_cards(card_filters)
		else:
			potential_cards = globals.player.deck.cards.duplicate()
		if potential_cards.size() > 0:
			CFUtils.shuffle_array(potential_cards)
			modified_card = potential_cards.pop_back()
			modified_card.modify_property(property, new_value)
			modified_card.upgrade_progress = modified_card.upgrade_threshold
	globals.player.deck.connect("card_upgrade_ended", self, "on_card_upgrade_ended")


func on_card_upgrade_ended(old_card: CardEntry, new_card: CardEntry) -> void:
	if old_card == modified_card:
		modified_card = new_card
		modified_card.modify_property(property, new_value)


func _on_card_selected(operation_details: Dictionary) -> void:
	modified_card = operation_details.card_entry
	modified_card.modify_property(property, new_value)

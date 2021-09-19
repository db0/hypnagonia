extends CardLibrary

var abilities_header : RichTextLabel
var filtered_archetype_cards: Array

onready var back_button := $VBC/HBC/MC/AvailableCards/Settings/Back
onready var _archetype_filter_button := $VBC/HBC/MC/AvailableCards/CC/ButtonFilters/ArchetypeFilter

func _ready() -> void:
	# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed",self,"_on_viewport_resized")
	# warning-ignore:return_value_discarded
	_archetype_filter_button.connect("archetype_chosen", self,"_on_archetype_chosen")
	
# Populates the list of available cards, with all defined cards in the game
func populate_available_cards() -> void:
	.populate_available_cards()
	abilities_header = _card_headers.get_node("Abilities")
	abilities_header.rect_min_size.x = get_viewport().size.x / 2

# Resizes the abilities header to match the window size.
# So that the abilities have the most space to show.
func _on_viewport_resized() -> void:
	# On resize down, for some reason, the name doesn't automatically resize properly
	# Only manually tweaking the window size fixes it. I haven't found a proper solution yet
	abilities_header.rect_min_size.x = get_viewport().size.x / 2

func _on_archetype_chosen(archetype) -> void:
	if archetype == "Clear Filters":
		_archetype_filter_button.text = "Filter by Archetype"
		filtered_archetype_cards.clear()
	else:
		filtered_archetype_cards = Aspects.get_all_cards_in_archetype(archetype)
		_archetype_filter_button.text = "Filtering: " + archetype
	_apply_filters(_filter_line.get_active_filters())
	

func _check_custom_filters(card_object: CVListCardObject) -> bool:
	if filtered_archetype_cards.size() and not card_object.card_name in filtered_archetype_cards:
		return(false)
	return(true)

# Clears all card filters
func _on_ClearFilters_pressed() -> void:
	_archetype_filter_button.text = "Filter by Archetype"
	filtered_archetype_cards.clear()
	._on_ClearFilters_pressed()

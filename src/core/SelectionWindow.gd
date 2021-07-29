class_name SelectionWindow
extends AcceptDialog

# The path to the GridCardObject scene.
const _GRID_CARD_OBJECT_SCENE_FILE = CFConst.PATH_CORE\
		+ "CardViewer/CVGridCardObject.tscn"
const _GRID_CARD_OBJECT_SCENE = preload(_GRID_CARD_OBJECT_SCENE_FILE)
const _INFO_PANEL_SCENE_FILE = CFConst.PATH_CORE\
		+ "CardViewer/CVInfoPanel.tscn"
const _INFO_PANEL_SCENE = preload(_INFO_PANEL_SCENE_FILE)

export(PackedScene) var grid_card_object_scene := _GRID_CARD_OBJECT_SCENE
export(PackedScene) var info_panel_scene := _INFO_PANEL_SCENE

var selected_cards := []
var selection_count : int
var selection_type: String

onready var _card_grid = $GridContainer
onready var _tween = $Tween

#func _ready():
#	var c = cfc.instance_card("Test Card 1")
#	var c2 = cfc.instance_card("Test Card 2")
#	initiate_selection([c, c2])

func _process(delta):
	var current_count = selected_cards.size()
	match selection_type:
		"min":
			if current_count < selection_count:
				get_ok().disabled = true
			else:
				get_ok().disabled = false
		"equal":
			if current_count != selection_count:
				get_ok().disabled = true
			else:
				get_ok().disabled = false
		"max":
			if current_count > selection_count:
				get_ok().disabled = true
			else:
				get_ok().disabled = false
	
	
func initiate_selection(card_array: Array, _selection_count := 0, _selection_type := 'min') -> void:
	selection_count = _selection_count
	selection_type = _selection_type
	# If the amount of cards available for the choice are below the requirements
	# We just return what is there.
	if card_array.size() < selection_count and selection_type in ["equal", "min"]:
		selected_cards = card_array
		emit_signal("confirmed")
		return
	dialog_text = selection_type + ': ' + str(selection_count)
	window_title = selection_type + ': ' + str(selection_count)
	for c in _card_grid.get_children():
		c.queue_free()
	for card in card_array:
		var dupe_selection: Card
		dupe_selection = card.duplicate(DUPLICATE_USE_INSTANCING)
		dupe_selection.remove_from_group("cards")
		dupe_selection.canonical_name = card.canonical_name
		dupe_selection.properties = card.properties.duplicate()
		dupe_selection.is_faceup = true
		_extra_dupe_ready(dupe_selection, card)
		var card_grid_obj = grid_card_object_scene.instance()
		_card_grid.add_child(card_grid_obj)
		card_grid_obj.preview_popup.focus_info.info_panel_scene = info_panel_scene
		card_grid_obj.preview_popup.focus_info.setup()
		card_grid_obj.setup(dupe_selection)
		card_grid_obj.connect("gui_input", self, "on_selection_gui_input", [dupe_selection, card])
		popup_centered_minsize()
		# We always make sure to clean tweening conflicts
		rect_size.y += 30
		rect_position.y = 0
		_tween.remove_all()
		# We do a nice alpha-modulate tween
		_tween.interpolate_property(self,'modulate:a',
				0, 1, 0.25,
				Tween.TRANS_SINE, Tween.EASE_IN)
		_tween.start()
		
		


# Overridable function for games to extend processing of dupe card
# after adding it to the scene
func _extra_dupe_ready(_dupe_selecion: Card, _card: Card) -> void:
	pass

# The player can select the cards using a simple left-click. 
func on_selection_gui_input(event: InputEvent, dupe_selection: Card, origin_card: Card) -> void:
	if event is InputEventMouseButton\
			and event.is_pressed()\
			and event.get_button_index() == 1:
		# Each time a card is clicked, it's selected/unselected
		dupe_selection.highlight.set_highlight(!dupe_selection.highlight.visible)
		if origin_card in selected_cards:
			selected_cards.erase(origin_card)
		else:
			selected_cards.append(origin_card)

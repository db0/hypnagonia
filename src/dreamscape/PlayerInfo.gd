class_name PlayerInfo
extends PanelContainer

const CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")
const PATHOS_INFO_SCENE = preload("res://src/dreamscape/PathosEntryInfo.tscn")

var current_decklist_cache: Array
var pathos_infos := {}

onready var _deck_preview_popup := $DeckPreview
onready var _deck_preview_scroll := $DeckPreview/ScrollContainer/
onready var _deck_preview_grid := $DeckPreview/ScrollContainer/GridContainer
onready var _player_health_label := $HBC/Health
onready var _encounter_label := $HBC/Encounter
onready var _deck_button := $HBC/Deck
onready var _pathos_details := $PathosDetails
onready var _pathos_details_list := $PathosDetails/VBC
onready var _pathos_button := $HBC/Pathos

func _ready() -> void:
	for entry in globals.player.pathos.repressed:
		var pinfo = PATHOS_INFO_SCENE.instance()
		_pathos_details_list.add_child(pinfo)
		pathos_infos[entry] = pinfo
		pinfo.setup(entry)
  
func _process(delta: float) -> void:
	_update_health_label()
	_update_encounter_label()
	_update_deck_count()
	
func _on_Settings_pressed() -> void:
	pass # Replace with function body.


func _on_Deck_pressed() -> void:
	var popup_size_x = (CFConst.CARD_SIZE.x * CFConst.THUMBNAIL_SCALE * _deck_preview_grid.columns)\
			+ _deck_preview_grid.get("custom_constants/vseparation") * _deck_preview_grid.columns
	_deck_preview_popup.rect_size = Vector2(popup_size_x,600)
	_deck_preview_popup.popup_centered()
	populate_preview_cards()


func populate_preview_cards() -> void:
	if current_decklist_cache != globals.player.deck.list_all_cards():
		for card in _deck_preview_grid.get_children():
			card.queue_free()
		current_decklist_cache =  globals.player.deck.list_all_cards()
		for preview_card_entry in globals.player.deck.cards:
			var card_preview_container = CARD_PREVIEW_SCENE.instance()
			_deck_preview_grid.add_child(card_preview_container)
			card_preview_container.setup(preview_card_entry.card_name)
			card_preview_container.display_card.deck_card_entry = preview_card_entry
	

func _update_health_label() -> void:
	if cfc.NMAP.has("board")\
			and is_instance_valid(cfc.NMAP.board)\
			and is_instance_valid(cfc.NMAP.board.dreamer):
		_player_health_label.text =\
				str(cfc.NMAP.board.dreamer.damage) + '/' + str(cfc.NMAP.board.dreamer.health)
	else:
		_player_health_label.text = str(globals.player.damage) + '/' + str(globals.player.health)

func _update_encounter_label() -> void:
	_encounter_label.text = 'Encounter ' + str(globals.encounters.encounter_number)

func _update_deck_count() -> void:
	_deck_button.text = str(globals.player.deck.count_cards())


func _on_Pathos_pressed() -> void:
	_pathos_details.popup_centered_minsize()
	for entry in pathos_infos:
		pathos_infos[entry].update()
	_pathos_details.rect_global_position =\
		_pathos_button.rect_global_position + Vector2(-_pathos_details.rect_size.x,50)

class_name PlayerInfo
extends PanelContainer

const CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")

onready var _deck_preview_popup := $DeckPreview
onready var _deck_preview_scroll := $DeckPreview/ScrollContainer/
onready var _deck_preview_grid := $DeckPreview/ScrollContainer/GridContainer

var current_decklist_cache: Array
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
		for preview_card_name in globals.player.deck.list_all_cards(true):
			var card_preview_container = CARD_PREVIEW_SCENE.instance()
			current_decklist_cache =  globals.player.deck.list_all_cards()
			_deck_preview_grid.add_child(card_preview_container)
			card_preview_container.setup(preview_card_name)
	

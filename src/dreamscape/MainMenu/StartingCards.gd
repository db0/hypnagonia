extends ScrollContainer

const STARTING_CARD_PREVIEW_SCENE = preload("res://src/dreamscape/MainMenu/StartingCardPreviewObject.tscn")

onready var _starting_cards_container = $HBC



func populate_starting_cards(types: Array, rel_parent: Node) -> void:
	print_debug(_starting_cards_container.get_children())
	for card in _starting_cards_container.get_children():
		card.queue_free()
	for type in types:
		for archetype in Terms.CARD_GROUP_TERMS.values():
			if CardGroupDefinitions[archetype.to_upper()].has(type):
				for card_name in CardGroupDefinitions[archetype.to_upper()][type]["Starting Cards"]:
					print_debug(card_name)
					var preview_card_object := STARTING_CARD_PREVIEW_SCENE.instance()
					_starting_cards_container.add_child(preview_card_object)
					preview_card_object.setup(card_name)
	print_debug(types, _starting_cards_container.get_children())
	

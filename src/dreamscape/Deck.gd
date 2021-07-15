extends DreamPile

signal draw_card(deck)

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")

func _on_DreamPile_input_event(event) -> void:
	if event.is_pressed()\
			and not cfc.game_paused\
			and not are_cards_still_animating()\
			and position == Vector2(0,0)\
			and get_card_count() > 0\
			and event.get_button_index() == 1:
		populate_popup(true)

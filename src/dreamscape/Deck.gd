extends DreamPile

# warning-ignore:unused_signal
signal draw_card(deck)

func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")

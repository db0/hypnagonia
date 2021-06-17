# Code for a sample deck, you're expected to provide your own ;)
extends Pile

signal draw_card(deck)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not cfc.are_all_nodes_mapped:
		yield(cfc, "all_nodes_mapped")

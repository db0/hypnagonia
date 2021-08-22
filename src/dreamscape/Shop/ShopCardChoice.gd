extends VBoxContainer

var cost: int
var cost_type: String = "frustration"

onready var shop_card_display := $ChoiceCardObject
onready var shop_card_cost := $Cost

func _process(delta: float) -> void:
	if cost > globals.player.pathos.released[cost_type]:
		shop_card_cost.add_color_override("font_color", Color(1,0,0))
	else:
		shop_card_cost.add_color_override("font_color", Color(1,1,0))
	

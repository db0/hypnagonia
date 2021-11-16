extends VBoxContainer

var cost: int setget set_cost
var cost_type: String = Terms.RUN_ACCUMULATION_NAMES.nce

onready var shop_card_display := $ChoiceCardObject
onready var shop_card_cost := $Cost

func _process(delta: float) -> void:
	if cost > globals.player.pathos.released[cost_type]:
		shop_card_cost.add_color_override("font_color", Color(1,0,0))
	else:
		shop_card_cost.add_color_override("font_color", Color(1,1,0))
	

func set_cost(value) -> void:
	cost = value
	shop_card_cost.text = str(value) + ' ' + cost_type.capitalize()


func disable() -> void:
	modulate.a = 0
	shop_card_display.is_disabled = true
	shop_card_display._on_GridCardObject_mouse_exited()
	

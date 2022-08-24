extends VBoxContainer

var cost: int setget set_cost
var cost_type: String = Terms.RUN_ACCUMULATION_NAMES.nce

onready var shop_card_display := find_node('ChoiceCardObject')
onready var shop_card_cost := find_node('Cost')
onready var shop_cost_icon := find_node('CostIcon')

func _ready():
	# warning-ignore:return_value_discarded
	globals.player.pathos.connect("advancements_modified", self, "_on_advancements_modified")
	shop_cost_icon.texture = CFUtils.convert_texture_to_image(shop_cost_icon.texture)

func _update_cost() -> void:
	if cost > globals.player.pathos.available_masteries:
		shop_card_cost.add_color_override("font_color", Color(1,0,0))
	else:
		shop_card_cost.add_color_override("font_color", Color(1,1,0))
	

func set_cost(value) -> void:
	cost = value
	shop_card_cost.text = str(value)
	_update_cost()

func disable() -> void:
	modulate.a = 0
	shop_card_display.is_disabled = true
	shop_card_display._on_GridCardObject_mouse_exited()
	
func _on_advancements_modified(_amount, _old_value) -> void:
	_update_cost()

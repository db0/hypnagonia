extends VBoxContainer

var cost: int setget set_cost
var cost_type: String = Terms.RUN_ACCUMULATION_NAMES.elite
# Used to know when the selection is an existing memory to upgrade
var is_upgrade: bool

onready var shop_artifact_display := find_node('ArtifactChoiceObject')
onready var shop_artifact_cost := find_node('Cost')
onready var shop_cost_icon := find_node('CostIcon')


func _ready():
	globals.player.pathos.connect("advancements_modified", self, "_on_advancements_modified")
	shop_cost_icon.texture = CFUtils.convert_texture_to_image(shop_cost_icon.texture)
	
func _update_cost() -> void:
	if cost > globals.player.pathos.available_advancements:
		shop_artifact_cost.add_color_override("font_color", Color(1,0,0))
	elif is_upgrade:
		shop_artifact_cost.add_color_override("font_color", Color(0,0.386,0.92))
	else:
		shop_artifact_cost.add_color_override("font_color", Color(1,1,0))
	

func set_cost(value, _is_upgrade := false) -> void:
	cost = value
	if _is_upgrade:
		shop_artifact_cost.text = "(Upgrade) %s" % [value]
		is_upgrade = true
	else:
		shop_artifact_cost.text = "%s" % [value]
	_update_cost()
	
func _on_advancements_modified(_amount) -> void:
	_update_cost()	

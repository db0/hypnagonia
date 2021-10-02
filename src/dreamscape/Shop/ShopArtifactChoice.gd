extends VBoxContainer

var cost: int setget set_cost
var cost_type: String = Terms.RUN_ACCUMULATION_NAMES.elite

onready var shop_artifact_display := $ArtifactChoiceObject
onready var shop_artifact_cost := $Cost

func _process(delta: float) -> void:
	if cost > globals.player.pathos.released[cost_type]:
		shop_artifact_cost.add_color_override("font_color", Color(1,0,0))
	else:
		shop_artifact_cost.add_color_override("font_color", Color(1,1,0))
	

func set_cost(value) -> void:
	cost = value
	shop_artifact_cost.text = str(value) + ' ' + cost_type.capitalize()

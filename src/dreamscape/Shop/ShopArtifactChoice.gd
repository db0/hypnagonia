extends VBoxContainer

var cost: int setget set_cost
var cost_type: String = Terms.RUN_ACCUMULATION_NAMES.elite
# Used to know when the selection is an existing memory to upgrade
var is_upgrade: bool

onready var shop_artifact_display := $ArtifactChoiceObject
onready var shop_artifact_cost := $Cost

func _process(_delta: float) -> void:
	if cost > globals.player.pathos.released[cost_type]:
		shop_artifact_cost.add_color_override("font_color", Color(1,0,0))
	elif is_upgrade:
		shop_artifact_cost.add_color_override("font_color", Color(0,0.386,0.92))
	else:
		shop_artifact_cost.add_color_override("font_color", Color(1,1,0))
	

func set_cost(value, _is_upgrade := false) -> void:
	cost = value
	if _is_upgrade:
		shop_artifact_cost.text = "(Upgrade) %s %s" % [value, cost_type.capitalize()]
		is_upgrade = true
	else:
		shop_artifact_cost.text = "%s %s" % [value, cost_type.capitalize()]

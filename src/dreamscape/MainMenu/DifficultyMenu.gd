extends CenterContainer

onready var back_button = $"PC/VBC/Back"
onready var _total_difficulty := $"PC/VBC/TotalDifficulty"
onready var desc_popup := $"Descriptions"
onready var desc_label := $"Descriptions/Description"
onready var nodes_map := {
	"prevent_basic_cards_release": {
		"container": $"PC/VBC/PreventCardBasicRelease",
		"check_box": $"PC/VBC/PreventCardBasicRelease/CheckBox",
	},
	"desire_curios_give_perturbation": {
		"container": $"PC/VBC/DesireCuriosGivePerturbation",
		"check_box": $"PC/VBC/DesireCuriosGivePerturbation/CheckBox",
	},
	"starting_perturbations": {
		"container": $"PC/VBC/StartingPerturbations",
		"label": $"PC/VBC/StartingPerturbations/Label",
		"hslider": $"PC/VBC/StartingPerturbations/HSlider",
		"count": $"PC/VBC/StartingPerturbations/Count"
	},
	"progress_increase": {
		"container": $"PC/VBC/IncreaseProgressReq",
		"label": $"PC/VBC/IncreaseProgressReq/Label",
		"hslider": $"PC/VBC/IncreaseProgressReq/HSlider",
		"count": $"PC/VBC/IncreaseProgressReq/Count"
	},
	"act_healing": {
		"container": $"PC/VBC/ActHealing",
		"label": $"PC/VBC/ActHealing/Label",
		"hslider": $"PC/VBC/ActHealing/HSlider",
		"count": $"PC/VBC/ActHealing/Count",
		"_is_percentage": true,
	},
	"shop_prices": {
		"container": $"PC/VBC/ShopPrices",
		"label": $"PC/VBC/ShopPrices/Label",
		"hslider": $"PC/VBC/ShopPrices/HSlider",
		"count": $"PC/VBC/ShopPrices/Count",
		"_is_percentage": true,
	},
	"max_health": {
		"container": $"PC/VBC/MaxAnxiety",
		"label": $"PC/VBC/MaxAnxiety/Label",
		"hslider": $"PC/VBC/MaxAnxiety/HSlider",
		"count": $"PC/VBC/MaxAnxiety/Count",
		"_is_percentage": true,
	},
}

func _ready() -> void:
	_total_difficulty.text = "Difficulty: " + str(globals.difficulty.total_difficulty)
	for difficulty_setting in nodes_map:
		if nodes_map[difficulty_setting].has("check_box"):
			nodes_map[difficulty_setting]["check_box"].connect("toggled", self, "_on_CheckBox_toggled", [difficulty_setting])
			nodes_map[difficulty_setting]["check_box"].pressed = globals.difficulty[difficulty_setting]
		elif nodes_map[difficulty_setting].has("hslider"):
			nodes_map[difficulty_setting]["hslider"].connect("value_changed", self, "_on_HSlider_value_changed", [difficulty_setting])
			if nodes_map[difficulty_setting].get("_is_percentage", false):
				nodes_map[difficulty_setting]["hslider"].value = globals.difficulty.TOTAL_DIFFICULTY_MAPS[difficulty_setting][globals.difficulty[difficulty_setting]]
				nodes_map[difficulty_setting]["count"].text = str(globals.difficulty[difficulty_setting] * 100) + '%'
			else:
				nodes_map[difficulty_setting]["hslider"].value = globals.difficulty[difficulty_setting]
				nodes_map[difficulty_setting]["count"].text = str(globals.difficulty[difficulty_setting])
			if globals.difficulty.DIFFICULTY_STEPS.has(difficulty_setting):
				nodes_map[difficulty_setting]["hslider"].step = globals.difficulty.DIFFICULTY_STEPS[difficulty_setting]
		nodes_map[difficulty_setting]['container'].connect("mouse_entered", self, "_on_difficulty_mouse_entered", [difficulty_setting])
		nodes_map[difficulty_setting]['container'].connect("mouse_exited", self, "_on_difficulty_mouse_exited")
	# warning-ignore:return_value_discarded
	globals.difficulty.connect("total_difficulty_recalculated", self, "_on_total_difficulty_changed")

func _process(_delta: float) -> void:
	if desc_popup.visible:
		desc_popup.rect_global_position =\
			get_local_mouse_position() + Vector2(0,-30)

func _on_HSlider_value_changed(value: int, difficulty_key: String) -> void:
	globals.difficulty[difficulty_key] = value
	nodes_map[difficulty_key]["count"].text = str(globals.difficulty[difficulty_key])
	if nodes_map[difficulty_key].get("_is_percentage", false):
		 nodes_map[difficulty_key]["count"].text = str(globals.difficulty[difficulty_key] * 100) + '%'

func _on_CheckBox_toggled(value: bool, difficulty_key: String) -> void:
	globals.difficulty[difficulty_key] = value

func _on_total_difficulty_changed(total_difficulty) -> void:
	_total_difficulty.text = "Difficulty: " + str(total_difficulty)

func _on_difficulty_mouse_entered(difficulty_key: String) -> void:
	desc_label.text = globals.difficulty.DESCRIPTIONS[difficulty_key]
	desc_popup.visible = true

func _on_difficulty_mouse_exited() -> void:
	desc_popup.visible = false

extends CenterContainer

onready var back_button = $"PC/VBC/Back"
onready var _total_difficulty := $"PC/VBC/TotalDifficulty"
onready var nodes_map := {
	"prevent_basic_cards_release": {
		"check_box": $"PC/VBC/PreventCardBasicRelease/CheckBox",
	},
	"desire_curios_give_perturbation": {
		"check_box": $"PC/VBC/DesireCuriosGivePerturbation/CheckBox",
	},
	"starting_perturbations": {
		"label": $"PC/VBC/StartingPerturbations/Label",
		"hslider": $"PC/VBC/StartingPerturbations/HSlider",
		"count": $"PC/VBC/StartingPerturbations/Count"
	},
	"progress_increase": {
		"label": $"PC/VBC/IncreaseProgressReq/Label",
		"hslider": $"PC/VBC/IncreaseProgressReq/HSlider",
		"count": $"PC/VBC/IncreaseProgressReq/Count"
	},
	"act_healing": {
		"label": $"PC/VBC/ActHealing/Label",
		"hslider": $"PC/VBC/ActHealing/HSlider",
		"count": $"PC/VBC/ActHealing/Count",
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
	# warning-ignore:return_value_discarded
	globals.difficulty.connect("total_difficulty_recalculated", self, "_on_total_difficulty_changed")

func _on_HSlider_value_changed(value: int, difficulty_key: String) -> void:
	globals.difficulty[difficulty_key] = value
	nodes_map[difficulty_key]["count"].text = str(globals.difficulty[difficulty_key])
	if nodes_map[difficulty_key].get("_is_percentage", false):
		 nodes_map[difficulty_key]["count"].text = str(globals.difficulty[difficulty_key] * 100) + '%'

func _on_CheckBox_toggled(value: bool, difficulty_key: String) -> void:
	globals.difficulty[difficulty_key] = value

func _on_total_difficulty_changed(total_difficulty) -> void:
	_total_difficulty.text = "Difficulty: " + str(total_difficulty) 

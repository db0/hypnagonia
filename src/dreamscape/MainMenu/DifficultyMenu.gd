extends CenterContainer

onready var back_button = $"PC/VBC/Back"
onready var _total_difficulty := $"PC/VBC/TotalDifficulty"
onready var _starting_perturbations_label := $"PC/VBC/StartingPerturbations/Label"
onready var _starting_perturbations_slider := $"PC/VBC/StartingPerturbations/HSlider"
onready var _starting_perturbations_count := $"PC/VBC/StartingPerturbations/Count"
onready var _increase_progress_label := $"PC/VBC/IncreaseProgressReq/Label"
onready var _increase_progress_slider := $"PC/VBC/IncreaseProgressReq/HSlider"
onready var _increase_progress_count := $"PC/VBC/IncreaseProgressReq/Count"
onready var sliders = [
	_starting_perturbations_slider,
	_increase_progress_slider,
]

func _ready() -> void:
	_total_difficulty.text = "Difficulty: " + str(globals.difficulty.total_difficulty) 
	_starting_perturbations_slider.value = globals.difficulty.starting_perturbations
	_starting_perturbations_count.text = str(globals.difficulty.starting_perturbations)
	_increase_progress_slider.value = globals.difficulty.progress_increase
	_increase_progress_count.text = str(globals.difficulty.progress_increase)
	_increase_progress_slider.step = globals.difficulty.PROGRESS_INCREASE_STEP
	for slider in sliders:
		slider.connect("value_changed", self, "_on_HSlider_value_changed", [slider])
	# warning-ignore:return_value_discarded
	globals.difficulty.connect("total_difficulty_recalculated", self, "_on_total_difficulty_changed")

func _on_HSlider_value_changed(value: int, slider: HSlider) -> void:
	match slider:
		_starting_perturbations_slider:
			globals.difficulty.starting_perturbations = value
			_starting_perturbations_count.text = str(value)
		_increase_progress_slider:
			globals.difficulty.progress_increase = value
			_increase_progress_count.text = str(value)

func _on_total_difficulty_changed(total_difficulty) -> void:
	_total_difficulty.text = "Difficulty: " + str(total_difficulty) 


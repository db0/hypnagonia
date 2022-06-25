extends DifficultyOption

enum ResultTypes {
	NUMERICAL
	PERCENTAGE
	STRING_DESCRIPTION
}

export(ResultTypes) var result_type

onready var description := $Description
onready var slider := $Slider
onready var result := $Result

func _ready() -> void:
	match result_type:
		ResultTypes.NUMERICAL:
			slider.value = globals.difficulty[difficulty_key]
		ResultTypes.PERCENTAGE:
			slider.value = globals.difficulty.TOTAL_DIFFICULTY_MAPS[difficulty_key][globals.difficulty[difficulty_key]]
		ResultTypes.STRING_DESCRIPTION:
			slider.value = globals.difficulty[difficulty_key]
	_set_result_from_difficulty()
	if globals.difficulty.DIFFICULTY_STEPS.has(difficulty_key):
		slider.step = globals.difficulty.DIFFICULTY_STEPS[difficulty_key]

# We convert the value to int because we check against the type of value in the 
# setter, in order to know if someone is assigning a value directly or with the slider
func _on_Slider_value_changed(value: int) -> void:
	globals.difficulty[difficulty_key] = value
	_set_result_from_difficulty()

func _set_result_from_difficulty() -> void:
	match result_type:
		ResultTypes.NUMERICAL:
			result.text = str(globals.difficulty[difficulty_key])
		ResultTypes.PERCENTAGE:
			result.text = str(globals.difficulty[difficulty_key] * 100) + '%'
		ResultTypes.STRING_DESCRIPTION:
			# We add 2 to the index, because these enums start from -2
			result.text = globals.difficulty.DifficultyStrings.keys()[globals.difficulty[difficulty_key] + 2].capitalize()
	

class_name Difficulty
extends Reference

signal total_difficulty_recalculated(new_total)

const DIFFICULTY_FILE = "user://Difficulties.json"
const PROGRESS_INCREASE_STEP := 4

var difficulties := {}
var total_difficulty := 0
var starting_perturbations := 0 setget set_starting_perturbations
var progress_increase := 0 setget set_progress_increase

func _init() -> void:
	init_difficulty_settings_from_file()
	
func set_starting_perturbations(value) -> void:
	starting_perturbations = value
	recalculate_total_difficulty()
	store_difficulty_to_file('starting_perturbations', value)
	
func set_progress_increase(value) -> void:
	progress_increase = value
	recalculate_total_difficulty()
	store_difficulty_to_file('progress_increase', value)
	
# Whenever a setting is changed via this function, it also stores it
# permanently on-disk.
func store_difficulty_to_file(setting_name: String, value) -> void:
	difficulties[setting_name] = value
	var file = File.new()
	file.open(DIFFICULTY_FILE, File.WRITE)
	file.store_string(JSON.print(difficulties, '\t'))
	file.close()


# Initiates game_settings from the contents of CFConst.SETTINGS_FILENAME
func init_difficulty_settings_from_file() -> void:
	var file = File.new()
	if file.file_exists(DIFFICULTY_FILE):
		file.open(DIFFICULTY_FILE, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			difficulties = data.duplicate()
	for key in difficulties:
		self[key] = difficulties[key]


func recalculate_total_difficulty() -> void:
	total_difficulty = 0
	total_difficulty += starting_perturbations
	total_difficulty += progress_increase / PROGRESS_INCREASE_STEP
	emit_signal("total_difficulty_recalculated", total_difficulty)

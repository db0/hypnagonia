class_name Difficulty
extends Reference

signal total_difficulty_recalculated(new_total)

const DIFFICULTY_FILE = "user://Difficulties.json"
const DIFFICULTY_MULTIPLIERS := {
	"desire_curios_give_perturbation": 2,
}
const TOTAL_DIFFICULTY_MAPS := {
	"act_healing": {
		0.0: 3,
		0.25: 2,
		0.5: 1,
		0.75: 0,
		1.0: -1,
	}
}
const DIFFICULTY_STEPS := {
	"progress_increase": 4,
}

var difficulties := {}
var total_difficulty := 0
var starting_perturbations := 0 setget set_starting_perturbations
var progress_increase := 0 setget set_progress_increase
var act_healing := 0.75 setget set_act_healing
var prevent_basic_cards_release := false setget set_prevent_basic_cards_release
var desire_curios_give_perturbation := false setget set_desire_curios_give_perturbation

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
	
func set_act_healing(value) -> void:
	if not TOTAL_DIFFICULTY_MAPS['act_healing'].has(value):
		value = seek_value_from_difficulty('act_healing', value)
	act_healing = value
	recalculate_total_difficulty()
	store_difficulty_to_file('act_healing', value)
	
func set_prevent_basic_cards_release(value) -> void:
	prevent_basic_cards_release = value
	recalculate_total_difficulty()
	store_difficulty_to_file('prevent_basic_cards_release', value)
	
func set_desire_curios_give_perturbation(value) -> void:
	desire_curios_give_perturbation = value
	recalculate_total_difficulty()
	store_difficulty_to_file('desire_curios_give_perturbation', value)
	
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
	recalculate_total_difficulty()


func recalculate_total_difficulty() -> void:
	total_difficulty = 0
	total_difficulty += starting_perturbations
	total_difficulty += progress_increase / DIFFICULTY_STEPS.progress_increase
	total_difficulty += TOTAL_DIFFICULTY_MAPS.act_healing[act_healing]
	total_difficulty += calc_boolean_difficulty(prevent_basic_cards_release)
	total_difficulty += calc_boolean_difficulty(desire_curios_give_perturbation) * DIFFICULTY_MULTIPLIERS.desire_curios_give_perturbation
	emit_signal("total_difficulty_recalculated", total_difficulty)

# Boolean variables are always worded so that false is difficulty 0
# and true is difficulty 1
func calc_boolean_difficulty(bool_var: bool) -> int:
	var total_calc: int
	if bool_var:
		return(1)
	return(0)

func get_difficulty(difficulty_key: String) -> int:
	var req_dif : int
	if TOTAL_DIFFICULTY_MAPS.has(difficulty_key):
		req_dif = TOTAL_DIFFICULTY_MAPS[difficulty_key][self[difficulty_key]]
	else:
		req_dif = self[difficulty_key]
	req_dif *= DIFFICULTY_MULTIPLIERS.get(difficulty_key, 1)
	return(req_dif)

func seek_value_from_difficulty(difficulty_key: String, value: int):
	if not TOTAL_DIFFICULTY_MAPS.has(difficulty_key):
		print_debug("WARNING: value %s for %s is unexpected" % [value, difficulty_key])
		return
	for key in TOTAL_DIFFICULTY_MAPS[difficulty_key]:
		if TOTAL_DIFFICULTY_MAPS[difficulty_key][key] == value:
			return(key)

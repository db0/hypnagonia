class_name Difficulty
extends Reference

signal total_difficulty_recalculated(new_total)

enum DifficultyStrings {
	CASUAL = -2
	EASY
	NORMAL
	HARD
	TOUGH
	EPIC
}
const DIFFICULTY_FILE = "user://Difficulties.json"
const DIFFICULTY_MULTIPLIERS := {
	"desire_curios_give_perturbation": 2,
	"permanent_defence": -5,
	"permanent_immersion": -4,
}
const TOTAL_DIFFICULTY_MAPS := {
	"act_healing": {
		0.0: 3, # Disabled
		0.25: 2,
		0.5: 1,
		0.75: 0,
		1.0: -1,
	},
	"starting_masteries": {
		0.0: 1,
		1.0: 0,
		2.0: -1,
	},
	"max_health": {
		0.8: 2,
		0.9: 1,
		1.0: 0,
		1.1: -1,
		1.2: -2,
		1.3: -3,
	},
	"starting_damage": {
		0.4: 4,
		0.3: 3,
		0.2: 2,
		0.1: 1,
		0.0: 0,
	},
}
const DIFFICULTY_STEPS := {
	"progress_increase": 4,
}
const DESCRIPTIONS := {
	"starting_perturbations": "Your starting deck will get the specified amounr of random Perturbations",
	"progress_increase": "The progress required to upgrade each card will be increased by this amount",
	"act_healing": "At the end of each act the dreamer will release anxiety equal to this percent of their max anxiety.",
	"starting_masteries": "Modifies the starting amount of pathos masteries the player starts the game with.",
	"max_health": "The dreamer starting max anxiety is modified by this percentage.",
	"starting_damage": "The dreamer starts with a prexisting amount of anxiety.",
	"prevent_basic_cards_release": "Basic (AKA Starting) cards cannot receive an upgrade which removes them permanently from the deck.",
	"desire_curios_give_perturbation": "Curios discovered using repressed desire will have a an extra chance to add a Perturbation to your deck.",
	"lower_upgraded_draft_chance": "Less chance to discover upgraded cards during acts 2 and 3.",
	"unremovable_perturbation": "An unreleaseable perturbation will be added to your deck.",
	"permanent_defence": "Confidence and Perpexity are not removed at the start of the turn. Courage is adjusted.",
	"permanent_immersion": "Unused Immersion is not lost at end of turn. The dreamer can store a max of 10 immersion.",
	"encounter_difficulty": "Modifies the chance to get beneficial or detrimental journal encounters.\n"\
			+ "Harder difficulties will make Torments appear more often and the Boss to appear earlier.\n"\
			+ "Easier difficulties will make Rest sites, Shops and Curios appear more often instead\n",
}

var difficulties := {}
var total_difficulty := 0
var starting_perturbations := 0 setget set_starting_perturbations
var progress_increase := 0 setget set_progress_increase
var act_healing := 0.75 setget set_act_healing
var starting_masteries := 1.0 setget set_starting_masteries
var max_health := 1.0 setget set_max_health
var starting_damage := 0.0 setget set_starting_damage
var prevent_basic_cards_release := false setget set_prevent_basic_cards_release
var desire_curios_give_perturbation := false setget set_desire_curios_give_perturbation
var lower_upgraded_draft_chance := false setget set_lower_upgraded_draft_chance
var unremovable_perturbation := false setget set_unremovable_perturbation
var permanent_defence := false setget set_permanent_defence
var permanent_immersion := false setget set_permanent_immersion
var encounter_difficulty := 0 setget set_encounter_difficulty

func _init() -> void:
	init_difficulty_settings_from_file()

func set_starting_perturbations(value) -> void:
	starting_perturbations = value
	_finalize_value("starting_perturbations", starting_perturbations)

func set_progress_increase(value) -> void:
	progress_increase = value
	_finalize_value("progress_increase", progress_increase)

func set_act_healing(value) -> void:
	act_healing = _get_percentage_value("act_healing", value)
	_finalize_value("act_healing", act_healing)

func set_starting_masteries(value) -> void:
	starting_masteries = _get_percentage_value("starting_masteries", value)
	_finalize_value("starting_masteries", starting_masteries)

func set_max_health(value) -> void:
	max_health = _get_percentage_value("max_health", value)
	_finalize_value("max_health", max_health)

func set_starting_damage(value) -> void:
	starting_damage = _get_percentage_value("starting_damage", value)
	_finalize_value("starting_damage", starting_damage)

func set_prevent_basic_cards_release(value) -> void:
	prevent_basic_cards_release = value
	_finalize_value("prevent_basic_cards_release", prevent_basic_cards_release)

func set_desire_curios_give_perturbation(value) -> void:
	desire_curios_give_perturbation = value
	_finalize_value("desire_curios_give_perturbation", desire_curios_give_perturbation)
	
func set_lower_upgraded_draft_chance(value) -> void:
	lower_upgraded_draft_chance = value
	_finalize_value("lower_upgraded_draft_chance", lower_upgraded_draft_chance)
	
func set_unremovable_perturbation(value) -> void:
	unremovable_perturbation = value
	_finalize_value("unremovable_perturbation", unremovable_perturbation)
	
func set_permanent_defence(value) -> void:
	permanent_defence = value
	_finalize_value("permanent_defence", permanent_defence)
	
func set_permanent_immersion(value) -> void:
	permanent_immersion = value
	_finalize_value("permanent_immersion", permanent_immersion)
	
func set_encounter_difficulty(value) -> void:
	encounter_difficulty = value
	_finalize_value("encounter_difficulty", encounter_difficulty)


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
		set(key, difficulties[key])
	recalculate_total_difficulty()


func recalculate_total_difficulty() -> void:
	total_difficulty = 0
	total_difficulty += starting_perturbations
	total_difficulty += progress_increase / DIFFICULTY_STEPS.progress_increase
	total_difficulty += TOTAL_DIFFICULTY_MAPS.act_healing.get(act_healing,0)
	total_difficulty += TOTAL_DIFFICULTY_MAPS.starting_masteries.get(starting_masteries,0)
	total_difficulty += TOTAL_DIFFICULTY_MAPS.max_health.get(max_health,0)
	total_difficulty += TOTAL_DIFFICULTY_MAPS.starting_damage.get(starting_damage,0)
	total_difficulty += calc_boolean_difficulty(prevent_basic_cards_release)
	total_difficulty += calc_boolean_difficulty(desire_curios_give_perturbation) * DIFFICULTY_MULTIPLIERS.desire_curios_give_perturbation
	total_difficulty += calc_boolean_difficulty(lower_upgraded_draft_chance)
	total_difficulty += calc_boolean_difficulty(unremovable_perturbation)
	total_difficulty += calc_boolean_difficulty(permanent_defence) * DIFFICULTY_MULTIPLIERS.permanent_defence
	total_difficulty += calc_boolean_difficulty(permanent_immersion) * DIFFICULTY_MULTIPLIERS.permanent_immersion
	total_difficulty += encounter_difficulty
	emit_signal("total_difficulty_recalculated", total_difficulty)


# Boolean variables are always worded so that false is difficulty 0
# and true is difficulty 1
func calc_boolean_difficulty(bool_var: bool) -> int:
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
		return
	for key in TOTAL_DIFFICULTY_MAPS[difficulty_key]:
		if TOTAL_DIFFICULTY_MAPS[difficulty_key][key] == value:
			return(key)


func _get_percentage_value(difficulty_key: String, value) -> float:
	if typeof(value) == TYPE_INT:
		value = seek_value_from_difficulty(difficulty_key, value)
	elif not TOTAL_DIFFICULTY_MAPS[difficulty_key].has(value):
		printerr("WARNING: Unexpected value %s assigned to %s" % [value,difficulty_key])
	return(value)


func _finalize_value(difficulty_key: String, value) -> void:
	recalculate_total_difficulty()
	store_difficulty_to_file(difficulty_key, value)

func extract_save_state() -> Dictionary:
	# We load the difficulties from the file, as they're already converted to a dict
	var difficulty_dict := {}
	var file = File.new()
	if file.file_exists(DIFFICULTY_FILE):
		file.open(DIFFICULTY_FILE, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			difficulty_dict = data.duplicate()
	return(difficulty_dict)
	
func restore_save_state(save_state: Dictionary) -> void:
	for key in save_state:
		set(key, save_state[key])

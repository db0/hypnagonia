class_name GameSave
extends Reference

const SAVE_PATH := "user://game_save.dat"
const GAME_LOADING_SCENE := "res://src/dreamscape/SaveGame/GameLoading.tscn"

var savefile = File.new()

func save_state() -> void:
	savefile.open(SAVE_PATH, File.WRITE)
	var state = {
		"starting_seed": cfc.game_rng_seed,
		"current_seed": cfc.game_rng.seed,
		"seed_state": cfc.game_rng.state,
		"card_back_texture_selection": globals.card_back_texture_selection,
		"player": _extract_player(),
		"encounters": _extract_encounters(),
		"current_encounter": _extract_current_encounter(),
		"difficulty":  _extract_difficulty(),
	}
	savefile.store_var(state)
#	file.store_string(JSON.print(state, '\t'))
	savefile.close()


func load_state() -> void:
	if not save_file_exists():
		return
	savefile.open(SAVE_PATH, File.READ)
	var data = savefile.get_var()
	savefile.close()
	if typeof(data) != TYPE_DICTIONARY:
		return
	# warning-ignore:return_value_discarded
	cfc.get_tree().change_scene(GAME_LOADING_SCENE)
	cfc.quit_game()
	globals.reset()
	globals.player.restore_save_state(data.player)
	globals.encounters.restore_save_state(data.encounters)
	globals.difficulty.restore_save_state(data.difficulty)
	# warning-ignore:return_value_discarded
	globals.card_back_texture_selection = data.card_back_texture_selection
	cfc.game_rng_seed = data.starting_seed
	cfc.game_rng.seed = data.current_seed
	cfc.game_rng.state = data.seed_state
	# Load the PackedScene resource
	cfc.get_tree().change_scene(CFConst.PATH_CUSTOM + 'Overworld/Journal.tscn')


func get_class_name() -> String:
	return("GameSave")


func save_file_exists() -> bool:
	return(savefile.file_exists(SAVE_PATH))


func delete_save() -> void:
	if not save_file_exists():
		return
	var dir = Directory.new()
	dir.remove(SAVE_PATH)
		

func _extract_player() -> Dictionary:
	return(globals.player.extract_save_state())


func _extract_encounters() -> Dictionary:
	return(globals.encounters.extract_save_state())


func _extract_difficulty() -> Dictionary:
	return(globals.difficulty.extract_save_state())


func _extract_current_encounter():
	var current_encounter
	if globals.current_encounter:
		current_encounter = globals.current_encounter.get_script().get_path()
	return(current_encounter)

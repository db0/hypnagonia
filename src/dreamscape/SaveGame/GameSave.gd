class_name GameSave
extends Reference

const SAVE_PATH := "user://game_save.json"
const GAME_LOADING_SCENE := "res://src/dreamscape/SaveGame/GameLoading.tscn"

func save_state() -> void:
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	var state = {
		"starting_seed": cfc.game_rng_seed,
		"current_seed": cfc.game_rng.seed,
		"seed_state": cfc.game_rng.state,
		"card_back_texture_selection": globals.card_back_texture_selection,
		"player": _extract_player(),
		"encounters": _extract_encounters(),
		"current_encounter": _extract_current_encounter(),
		"unused_journal_texts": globals.unused_journal_texts,
		"difficulty": _extract_difficulty(),
	}
	file.store_string(JSON.print(state, '\t'))
	file.close()

func load_state() -> void:
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
		return
	file.open(SAVE_PATH, File.READ)
	var data = parse_json(file.get_as_text())
	file.close()
	if typeof(data) != TYPE_DICTIONARY:
		return
# warning-ignore:return_value_discarded
	cfc.get_tree().change_scene(GAME_LOADING_SCENE)
	cfc.quit_game()
	globals.reset()
	globals.player.restore_save_state(data.player)
	globals.encounters.restore_save_state(data.encounters)
	# warning-ignore:return_value_discarded
	globals.card_back_texture_selection = data.card_back_texture_selection
	globals.unused_journal_texts = data.unused_journal_texts
	cfc.game_rng_seed = data.starting_seed
	cfc.game_rng.seed = data.current_seed
	cfc.game_rng.state = data.seed_state
	cfc.get_tree().change_scene(CFConst.PATH_CUSTOM + 'Overworld/Journal.tscn')

func _extract_player() -> Dictionary:
	return(globals.player.extract_save_state())


func _extract_deck() -> Array:
	return(globals.player.deck.extract_save_state())


func _extract_encounters() -> Dictionary:
	return(globals.encounters.extract_save_state())


func _extract_difficulty() -> Dictionary:
	return(globals.difficulty.extract_save_state())


func _extract_current_encounter():
	var current_encounter
	if globals.current_encounter:
		current_encounter = globals.current_encounter.get_script().get_path()
	return(current_encounter)


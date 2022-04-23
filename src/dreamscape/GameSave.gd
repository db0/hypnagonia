class_name GameSave
extends Reference

const SAVE_PATH := "user://game_save.json"

func save_state() -> void:
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	var state = {
		"player": _extract_player(),
		"encounters": _extract_encounters(),
		"current_encounter": _extract_current_encounter()
	}
	file.store_string(JSON.print(state, '\t'))
	file.close()


func _extract_player() -> Dictionary:
	return(globals.player.extract_save_state())


func _extract_deck() -> Array:
	return(globals.player.deck.extract_save_state())


func _extract_encounters() -> Dictionary:
	return(globals.encounters.extract_save_state())


func _extract_current_encounter():
	var current_encounter
	if globals.current_encounter:
		current_encounter = globals.current_encounter.get_script().get_path()
	return(current_encounter)


class_name SingleEncounter
extends Reference

signal encounter_begin(encounter)
signal encounter_end(encounter)

var description: String
var journal_art
var shader_params: Dictionary
var pathos_released: String

func begin() -> void:
	if OS.has_feature("debug"):
		print("DEBUG INFO:Encounter: Entering Encounter: " + get_script().get_path())
	globals.current_encounter = self
	# warning-ignore:return_value_discarded
	globals.player.pathos.release(pathos_released)
	emit_signal("encounter_begin", self)


func end() -> void:
	emit_signal("encounter_end", self)


func game_over() -> void:
	cfc.quit_game()
	globals.journal.display_loss()
	emit_signal("encounter_end", self)


func prepare_journal_art(encounter: Dictionary) -> void:
	var tex = encounter.get("journal_art")
	if tex:
		journal_art = ImageTexture.new();
		var image = tex.get_data()
		journal_art.create_from_image(image)


func prepare_shader_art(shader: Shader, _shader_params: Dictionary) -> void:
	shader_params = _shader_params
	journal_art = shader

class_name SingleEncounter
extends Reference

signal encounter_begin(encounter)
signal encounter_end(encounter)


var introduction:= EncounterStory.new("journal_choice")
# The art shown to the player in the journal. It can be a texture or a shader.
var journal_art
# If the art is a shader
var shader_params: Dictionary
# The type of pathos used by this encounter
var pathos_released: String
# Stores how many times this encounter type was skipped until now
var skipped: int = 0

func begin() -> void:
	if OS.has_feature("debug") and not cfc.is_testing:
		print("DEBUG INFO:Encounter: Entering Encounter: " + get_script().get_path())
	globals.current_encounter = self
	# We store it now, because it will be cleared in the pathos on select()
	skipped = _get_pathos_type().skipped
	# warning-ignore:return_value_discarded
	_get_pathos_type().select()
	emit_signal("encounter_begin", self)


# Used when this choice is not selected when it appears in the encounter
func ignore() -> void:
	_get_pathos_type().ignore()

func end() -> void:
	emit_signal("encounter_end", self)


func game_over() -> void:
	cfc.quit_game()
	# We're doing an if-clause to avoid failing during fast testing teradown
	if is_instance_valid(globals.journal):
		globals.journal.display_loss()
	emit_signal("encounter_end", self)


func prepare_journal_art(value) -> void:
	var tex
	match typeof(value):
		TYPE_DICTIONARY:
			tex = value.get("journal_art")
			if typeof(tex) == TYPE_ARRAY:
				tex = tex.duplicate()
				CFUtils.shuffle_array(tex, true)
				tex = tex[0]
		_:
			tex = value
	if tex:
		journal_art = CFUtils.convert_texture_to_image(tex, true);


func prepare_shader_art(shader: Shader, _shader_params: Dictionary) -> void:
	shader_params = _shader_params
	journal_art = shader

func _get_pathos_type() -> PathosType:
	return(globals.player.pathos.pathi[pathos_released])

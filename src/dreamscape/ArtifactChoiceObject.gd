extends CombatSignifier

signal artifact_selected(option)
var index: int
onready var shader_effect := $ShaderEffect
onready var bbc := $BackBufferCopy

# I have to put a property formated description which includes the amounts
# The artifact needs to have based on the artifact definition.
# If the arguemtn for this function are coming from ArtifactPrep, then they should
# already have the proper dictionary fields
func setup(signifier_details: Dictionary, signifier_name: String) -> void:
	var updated_detail = signifier_details.duplicate(true)
	updated_detail["description"] = updated_detail.bbdescription
	.setup(updated_detail, signifier_name)


func apply_sharer(shader_path: String) -> void:
	bbc.visible = true
	shader_effect.visible = true
	shader_effect.material = ShaderMaterial.new()
	shader_effect.material.shader = load(shader_path)

func _on_JournalArtifactChoice_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.get_button_index() == 1:
			emit_signal("artifact_selected", index)


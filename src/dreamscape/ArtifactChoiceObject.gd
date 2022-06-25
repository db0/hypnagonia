extends CombatSignifier

signal artifact_selected(option)
var index: int
var selected := false
var disabled := false

onready var shader_effect := $ShaderEffect
onready var bbc := $BackBufferCopy

# I have to put a property formated description which includes the amounts
# The artifact needs to have based on the artifact definition.
# If the arguemtn for this function are coming from ArtifactPrep, then they should
# already have the proper dictionary fields
func setup(signifier_details: Dictionary, signifier_name: String) -> void:
	var updated_detail = signifier_details.duplicate(true)
	var memory_cost_info := ''
	# The existence of a pathos key, signifies that this artifact is a memory
	if signifier_details.has('pathos'):
		var upgrades = signifier_details.get("upgrades",0)
		# If a card has upgrades, we want the card displayed in the shop to have the statistics
		# of its upgraded version
		if signifier_details.get("is_upgrade"):
			upgrades += 1
		memory_cost_info = "\n\n[i]{pathos_description}{delay_pct_explanation}[/i]"\
				.format(MemoryObject.get_cost_format(updated_detail.canonical_name, upgrades))
		updated_detail["bbdescription"] =\
			updated_detail.description.\
			format(Terms.get_bbcode_formats(18)).\
			format(MemoryDefinitions.get_memory_bbcode_format(signifier_details, upgrades))
	updated_detail["description"] = updated_detail.bbdescription + memory_cost_info
	.setup(updated_detail, signifier_name)
	if updated_detail.get("linked_terms"):
			var linked_terms = {
				"already_added": [],
				"dreamer": [],
				"torment": [],
			}
			linked_terms['dreamer'] = updated_detail.get("linked_terms")
			cfc.ov_utils.add_linked_terms(focus_info, linked_terms)

func apply_shader(shader_path: String) -> void:
	bbc.visible = true
	shader_effect.visible = true
	shader_effect.material = ShaderMaterial.new()
	shader_effect.material.shader = load(shader_path)

func _on_JournalArtifactChoice_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.get_button_index() == 1:
		select_self()

func select_self() -> void:
	if selected: 
		return
	if disabled:
		return
	selected = true
	disconnect("gui_input", self, "_on_JournalArtifactChoice_gui_input")
	disconnect("mouse_entered", self, "_on_CombatSingifier_mouse_entered")
	decription_popup.visible = false
	emit_signal("artifact_selected", index)
	

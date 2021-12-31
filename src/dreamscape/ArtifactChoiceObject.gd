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
	var memory_cost_info := ''
	# The existence of a pathos key, signifies that this artifact is a memory
	if signifier_details.has('pathos'):
		var upgrades = signifier_details.get("upgrades",0)
		# If a card has upgrades, we want the card displayed in the shop to have the statiastics
		# of its upgraded version
		if signifier_details.get("is_upgrade"):
			upgrades += 1
		memory_cost_info = "\n\n[i]This memory will cost {fill_cost} released {pathos} to recall{delay_pct_explanation}[/i]"\
				.format(MemoryObject.get_cost_format(updated_detail.canonical_name, upgrades))
		updated_detail["bbdescription"] =\
			updated_detail.description.\
			format(Terms.get_bbcode_formats(18)).\
			format(MemoryDefinitions.get_memory_bbcode_format(signifier_details, upgrades))
	updated_detail["description"] = updated_detail.bbdescription + memory_cost_info
	.setup(updated_detail, signifier_name)


func apply_shader(shader_path: String) -> void:
	bbc.visible = true
	shader_effect.visible = true
	shader_effect.material = ShaderMaterial.new()
	shader_effect.material.shader = load(shader_path)

func _on_JournalArtifactChoice_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.get_button_index() == 1:
			emit_signal("artifact_selected", index)


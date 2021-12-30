class_name Memory
extends Artifact

onready var shader_node := $Signifier/Shader
onready var highlight := $Signifier/Highlight

func _ready() -> void:
	if not artifact_object.is_ready:
		_on_pathos_accumulated(artifact_object, 0)
	else:
		_on_memory_ready(artifact_object)
	if not is_active:
		highlight.material = null


func setup_artifact(memory_object, _is_active: bool, new_addition: bool) -> void:
	.setup_artifact(memory_object, _is_active, new_addition)
	memory_object.connect("pathos_accumulated", self, "_on_pathos_accumulated")
	memory_object.connect("memory_ready", self, "_on_memory_ready")
	memory_object.connect("memory_used", self, "_on_memory_used")

func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[Terms.PLAYER].duplicate()
	var artifact_description = artifact_object.definition["description"]
	var bbcolor = 'red'
	if artifact_object.is_ready:
		bbcolor = 'green'
	artifact_description += '\n[color=%s]This memory is %s%% ready to recall[/color]' % [bbcolor,
			round(float(artifact_object.pathos_accumulated)/float(artifact_object.pathos_threshold) * 100)]
	artifact_description += "\n\n[i]This memory costs {fill_cost} released {pathos} to recall{delay_pct_explanation}[/i]"\
			.format(artifact_object.get_cost_format(canonical_name, artifact_object.upgrades_amount))
	format["amount"] = str(amount)
	format["double_amount"] = str(2*amount)
	format["triple_amount"] = str(3*amount)
	# warning-ignore:integer_division
	format["half_amount"] = str(amount/2)
	_add_extra_description_format(format)
	decription_label.bbcode_text = artifact_description.\
			format(format).\
			format(Terms.get_bbcode_formats(18)).\
			format(MemoryDefinitions.get_memory_bbcode_format(artifact_object.definition, artifact_object.upgrades_amount))


func _use() -> void:
	artifact_object.use()
	execute_memory_effect()


# Overridable function
func execute_memory_effect() -> void:
	pass


func _on_MemoryTemplate_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton\
			and event.is_pressed()\
			and event.get_button_index() == 1\
			and is_active:
		if artifact_object.is_ready:
			_use()
	## DEBUG
	elif event.is_pressed() and event.get_button_index() == 2:
		globals.player.pathos.repress_pathos(artifact_object.pathos_used, 30)
		# warning-ignore:return_value_discarded
		globals.player.pathos.release(artifact_object.pathos_used)
		artifact_object._on_encounter_changed('', 1)
		artifact_object.upgrade()
	## END DEBUG
	_set_current_description()


func _on_pathos_accumulated(memory, _amount) -> void:
	if not memory.is_ready:
		shader_node.material.set_shader_param('percentage',
				float(artifact_object.pathos_accumulated)/float(artifact_object.pathos_threshold))


func _on_memory_ready(_memory) -> void:
	highlight.visible = true
	shader_node.material.set_shader_param('percentage', 1.0)


func _on_memory_used(_memory) -> void:
	highlight.visible = false
	shader_node.material.set_shader_param('percentage', 0.0)


class_name Memory
extends Artifact


onready var shader_node := $Signifier/Shader
# Used when the memory is active and ready
onready var active_highlight := $Signifier/ActiveHighlight
# Used when the memory is inactive and ready
onready var inactive_highlight := $Signifier/InactiveHighlight

func _ready() -> void:
	if not artifact_object.is_ready:
		_on_memory_charging(artifact_object, 0)
	else:
		_on_memory_ready(artifact_object)
	if not is_active:
		active_highlight.material = null


func setup_artifact(memory_object, _is_active: bool, new_addition: bool) -> void:
	.setup_artifact(memory_object, _is_active, new_addition)
	# We do that in _ready() as well, but to avoid errors in the console before that, we set it now as well
	canonical_name = memory_object.canonical_name
	memory_object.connect("memory_charging", self, "_on_memory_charging")
	memory_object.connect("memory_ready", self, "_on_memory_ready")
	memory_object.connect("memory_unready", self, "_on_memory_unready")
	memory_object.connect("memory_used", self, "_on_memory_used")


func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[Terms.PLAYER].duplicate()
	var artifact_description = artifact_object.definition["description"]
	var bbcolor = 'red'
	if artifact_object.is_ready:
		bbcolor = 'green'
	var pages_needed = artifact_object.recharge_time - artifact_object.current_charge
	if pages_needed > 0:
		artifact_description += '\n[color=%s]This memory needs %s more journal encounters to recall[/color]' % [
				bbcolor,artifact_object.recharge_time - artifact_object.current_charge]
	else:
		artifact_description += '\n[color=%s]This memory is ready to recall[/color]' % [bbcolor]
	artifact_description += "\n\n[i]{pathos_description}.{delay_pct_explanation}[/i]."\
			.format(artifact_object.get_cost_format(canonical_name, artifact_object.upgrades_amount))
	format["amount"] = str(amount)
	format["double_amount"] = str(2*amount)
	format["triple_amount"] = str(3*amount)
	# warning-ignore:integer_division
	format["half_amount"] = str(amount/2)
	_add_extra_description_format(format)
#	print_debug(MemoryDefinitions.get_memory_bbcode_format(artifact_object.definition, artifact_object.upgrades_amount))
	decription_label.bbcode_text = artifact_description.\
			format(format).\
			format(Terms.get_bbcode_formats(18)).\
			format(MemoryDefinitions.get_memory_bbcode_format(artifact_object.definition, artifact_object.upgrades_amount))
	if artifact_object.definition.get("linked_terms"):
			var linked_terms = {
				"already_added": [],
				"dreamer": [],
				"torment": [],
			}
			linked_terms['dreamer'] = artifact_object.definition.get("linked_terms")
			cfc.ov_utils.add_linked_terms(focus_info, linked_terms)

func _use():
	if OS.has_feature("debug") and not cfc.is_testing:
		print("DEBUG INFO:Memory: About to use: " + canonical_name)
	# TODO: Make Lethe turn the memory highlight red
	if cfc.NMAP.has('hand') and cfc.NMAP.hand.has_card_name("Lethe"):
		if OS.has_feature("debug") and not cfc.is_testing:
			print("DEBUG INFO:Memory use aborted because Lethe in hand")
		return
	var sceng = execute_memory_effect()
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	if sceng and not sceng.can_all_costs_be_paid:
		return(sceng)
	artifact_object.use()
	return(sceng)

# Overridable function
func execute_memory_effect():
	pass


func _on_MemoryTemplate_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton\
			and event.is_pressed()\
			and event.get_button_index() == 1\
			and is_active:
		if artifact_object.is_ready:
			_use()
	## DEBUG
	elif OS.has_feature("debug") and event.is_pressed() and event.get_button_index() == 3:
		artifact_object.upgrade()
		artifact_object.ready()
		_set_current_description()
	## END DEBUG

func _on_memory_charging(memory: Reference, _amount) -> void:
	if not memory.is_ready:
		shader_node.material.set_shader_param('percentage',
				float(artifact_object.current_charge)/float(artifact_object.recharge_time))


func _on_memory_ready(_memory: Reference) -> void:
	_activate_highlight()
	_set_current_description()
	shader_node.material.set_shader_param('percentage', 1.0)

func _on_memory_unready(_memory: Reference) -> void:
	_deactive_highlight()
	_set_current_description()
	shader_node.material.set_shader_param('percentage',
			float(artifact_object.pathos_accumulated)/float(artifact_object.pathos_threshold))


func _on_memory_used(_memory: Reference) -> void:
	_deactive_highlight()
	_set_current_description()
	shader_node.material.set_shader_param('percentage', 0.0)


# Changes highlight from active, to inactive
func _flip_highlights() -> void:
	if artifact_object.is_ready:
		active_highlight.visible = !active_highlight.visible
		inactive_highlight.visible = !inactive_highlight.visible


func _activate_highlight() -> void:
	if artifact_object.is_ready:
		active_highlight.visible = true
		inactive_highlight.visible = false
	else:
		inactive_highlight.visible = true
		active_highlight.visible = false


func _deactive_highlight() -> void:
	active_highlight.visible = false
	inactive_highlight.visible = false
			

func _switch_highlight_to(highlight_node: Panel) -> void:
	if artifact_object.is_ready:
		for hl in [active_highlight, inactive_highlight]:
			if hl == highlight_node:
				hl.visible = true
			else:
				hl.visible = false

# When memories trigger scripts, it always means they triggered
# When not, this function will be overriden
func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

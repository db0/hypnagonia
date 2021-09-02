class_name Artifact
extends CombatSignifier


enum PRIORITY {
	ADD
	MULTIPLY
	SET
}

export(PRIORITY) var priority
export(ArtifactDefinitions.EffectContext) var effect_context

# If this is true, the artifacts scripts will be used
# Because we display the artifact nodes in various PlayerInfo instances 
# (so that the player can still see the icons)
# we don't want them to be always active, but only in the correct context
var is_active := false
# The global entry of the artifact which is tracked between encounters
var artifact_object : ArtifactObject


func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		var turn: Turn = cfc.NMAP.board.turn
		for turn_signal in Turn.ALL_SIGNALS:
			# warning-ignore:return_value_discarded
			turn.connect(turn_signal, self, "_on_" + turn_signal)
	setup(artifact_object.definition, artifact_object.canonical_name)
	artifact_object.connect("removed", self, "_on_artifact_removed")
	artifact_object.connect("counter_modified", self, "_on_artifact_counter_modified")


func setup_artifact(_artifact_object: ArtifactObject, _is_active: bool, new_addition: bool) -> void:
	is_active = _is_active
	artifact_object = _artifact_object
	print_debug(_artifact_object.canonical_name, _is_active)
	if new_addition:
		_on_artifact_added()


# To override. This is called by the scripting engine
# Is source is telling this script whether we're checking for alterants affecting the
# entity applying this effect, or the antity receiving this effect.
func get_effect_alteration(
		_script: ScriptTask,
		_value: int,
		_sceng,
		_is_source: bool,
		_dry_run:= true,
		_subject: Node = null) -> int:
	return(0)

# Executes a custom script defined in an effect
func execute_script(
		script := [],
		trigger_object: Node = self,
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = null
	sceng = cfc.scripting_engine.new(
			script,
			cfc.NMAP.board.dreamer,
			trigger_object,
			trigger_details)
	# In case the script involves targetting, we need to wait on further
	# execution until targetting has completed
	sceng.execute(CFInt.RunType.COST_CHECK)
	if not sceng.all_tasks_completed:
		yield(sceng,"tasks_completed")
	# If the dry-run of the ScriptingEngine returns that all
	# costs can be paid, then we proceed with the actual run
	if sceng.can_all_costs_be_paid and not only_cost_check:
		#print("DEBUG:" + str(state_scripts))
		# The ScriptingEngine is where we execute the scripts
		# We cannot use its class reference,
		# as it causes a cyclic reference error when parsing
		sceng.execute()
		if not sceng.all_tasks_completed:
			yield(sceng,"tasks_completed")
	# This will only trigger when costs could not be paid, and will
	# execute the "is_else" tasks
	elif not sceng.can_all_costs_be_paid and not only_cost_check:
		#print("DEBUG:" + str(state_scripts))
		sceng.execute(CFInt.RunType.ELSE)
	return(sceng)


func _on_CombatSingifier_mouse_entered() -> void:
	_set_current_description()
	._on_CombatSingifier_mouse_entered()
	decription_popup.rect_global_position = rect_global_position + Vector2(50,0)


func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[Terms.PLAYER].duplicate()
	var artifact_description = artifact_object.definition["description"]
	format["artifact_name"] = canonical_name
	format["amount"] = str(amount)
	format["double_amount"] = str(2*amount)
	format["triple_amount"] = str(3*amount)
	# warning-ignore:integer_division
	format["half_amount"] = str(amount/2)
	decription_label.bbcode_text = artifact_description.\
			format(format).format(Terms.get_bbcode_formats(18))


# Overwritable function
func _on_artifact_added() -> void:
	pass


func _on_artifact_removed() -> void:
	queue_free()


func _on_artifact_counter_modified(value: int) -> void:
	update_amount(value)


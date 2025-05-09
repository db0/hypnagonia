class_name Artifact
extends CombatSignifier

# Used by the scripting engine alterants, to know which calculation
# to do first.
enum PRIORITY {
	ADD
	MULTIPLY
	SET
}

signal artifact_triggered(artifact)
signal scripting_completed(artifact, sceng)

export(PRIORITY) var priority
export(ArtifactDefinitions.EffectContext) var effect_context

# If this is true, the artifacts scripts will be used
# Because we display the artifact nodes in various PlayerInfo instances 
# (so that the player can still see the icons)
# we don't want them to be always active, but only in the correct context
var is_active := false
# The global entry of the artifact which is tracked between encounters
var artifact_object
# Some artifacts can only trigger once per battle. 
# This variable tracks that.
var _is_activated = false
# Helps us track our parents
var player_info_node: Control
# This is used to track if the artifact has been used during a predictions run
var snapshot_is_active: Dictionary

func _ready() -> void:
	if is_active and effect_context == ArtifactDefinitions.EffectContext.BATTLE:
		if not cfc.are_all_nodes_mapped:
			yield(cfc, "all_nodes_mapped")
		var turn: Turn = cfc.NMAP.board.turn
		for turn_signal in Turn.ALL_SIGNALS:
			# warning-ignore:return_value_discarded
			scripting_bus.connect(turn_signal, self, "_on_" + turn_signal)
	setup(artifact_object.definition, artifact_object.canonical_name)
	# warning-ignore:return_value_discarded
	artifact_object.connect("removed", self, "_on_artifact_removed")
	connect("scripting_completed", self, "_on_scripting_completed")
	if artifact_object.get_class() == "ArtifactObject":
		# warning-ignore:return_value_discarded
		artifact_object.connect("counter_modified", self, "_on_artifact_counter_modified")
	scripting_bus.connect("scripting_event_triggered", self, "execute_scripts")



func setup_artifact(_artifact_object, _is_active: bool, new_addition: bool) -> void:
	is_active = _is_active
	artifact_object = _artifact_object
	effect_context = artifact_object.context
#	print_debug(_artifact_object.canonical_name, _is_active)
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
	emit_signal("scripting_completed", self, sceng)
	return(sceng)


# Dummy function to overwrite, to enable artifacts to receive trigger
#  signals from all cards via the SignalPropagator
# If an artifact needs to fire based on a card trigger, this is the place
# to add that code
func execute_scripts(
		_trigger_card: Card = null,
		_trigger: String = "manual",
		_trigger_details: Dictionary = {},
		_only_cost_check := false):
	pass

# Because I want artifacts to connect to the scriptables
# pipeline, they need these two dummy functions to exist
# to avoid crashing the alterant engine.
# But I handle artifact alterants through the extended sceng _check_for_effect_alterants()
# Which uses another approach. So these two are not used here.
func retrieve_scripts(_trigger: String) -> Dictionary:
	return({})


func get_state_exec() -> String:
	return("NONE")

# Overridable function to add to artifacts so that they can alter global values
# such as card draft chance etc
func get_global_alterant(_value, _alterant_type: int):
	return


func _on_CombatSingifier_mouse_entered() -> void:
	_set_current_description()
	._on_CombatSingifier_mouse_entered()
	decription_popup.rect_global_position = rect_global_position + Vector2(50,0)


func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[Terms.PLAYER].duplicate()
	var artifact_description = artifact_object.definition["description"]
	format["artifact_name"] = artifact_object.definition["name"]
	format["amount"] = str(amount)
	format["double_amount"] = str(2*amount)
	format["triple_amount"] = str(3*amount)
	# warning-ignore:integer_division
	format["half_amount"] = str(amount/2)
	_add_extra_description_format(format)
	decription_label.bbcode_text = artifact_description.\
			format(format).\
			format(Terms.get_bbcode_formats(18)).\
			format(artifact_object.definition.get("amounts", {}))
	if artifact_object.definition.get("linked_terms"):
			var linked_terms = {
				"already_added": [],
				"dreamer": [],
				"torment": [],
			}
			linked_terms['dreamer'] = artifact_object.definition.get("linked_terms")
			cfc.ov_utils.add_linked_terms(focus_info, linked_terms)

# Function to overwrite from extended classes to add extra description format keys
func _add_extra_description_format(_format_dict: Dictionary) -> void:
	pass

# Overwritable function
func _on_artifact_added() -> void:
	pass


func _on_artifact_removed() -> void:
	queue_free()


func _on_artifact_counter_modified(value: int) -> void:
	update_amount(value)


# Marks this artifact as activated.
# Returns false if already activated. Else returns true
func _activate() -> bool:
	if _is_activated:
		return(false)
	_is_activated = true
	return(true)


# Marks this artifact as ready to be reactivated again.
# Simple function for now which I will extend with
# code to make the activation/refesh more obvious in the future
func _refresh():
	_is_activated = false


func _on_player_turn_ended(_turn: Turn) -> void:
	pass

func _on_player_turn_started(_turn: Turn) -> void:
	pass

func _on_enemy_turn_ended(_turn: Turn) -> void:
	pass

func _on_enemy_turn_started(_turn: Turn) -> void:
	pass


# Overridable function
func _on_scripting_completed(_artifact, _sceng) -> void:
	pass


# Used to mark that this artifact's effects have been triggered
func _send_trigger_signal() -> void:
	emit_signal("artifact_triggered", self)

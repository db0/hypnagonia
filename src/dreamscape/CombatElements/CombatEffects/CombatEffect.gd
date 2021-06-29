class_name CombatEffect
extends CombatSignifier

enum SELF_DECREASE {
	FALSE
	TURN_START
	TURN_END
}

enum PRIORITY {
	ADD
	MULTIPLY
	SET
}

export(SELF_DECREASE) var self_decreasing
export(PRIORITY) var priority

var entity_type: String
var stacks: int = 0 setget set_stacks
var description_string := ''

func setup(signifier_details: Dictionary, signifier_name: String) -> void:
	.setup(signifier_details, signifier_name)
	entity_type = signifier_details["entity_type"]


func _ready() -> void:
	var turn: Turn = cfc.NMAP.board.turn
	for turn_signal in Turn.ALL_SIGNALS:
		# warning-ignore:return_value_discarded
		turn.connect(turn_signal, self, "_on_" + turn_signal)


func set_stacks(value: int) -> void:
	if value > 0:
		signifier_amount.text = str(value)
		stacks = value
	else:
		queue_free()

# To override. This is called by the scripting engine
# Is source is telling this script whether we're checking for alterants affecting the 
# entity applying this effect, or the antity receiving this effect.
func get_effect_alteration(
		_script: ScriptTask, 
		_value: int, 
		_sceng, 
		_is_source: bool, 
		_dry_run:= true,
		subject: Node = null) -> int:
	return(0)

func _on_CombatSingifier_mouse_entered() -> void:
	_set_current_description()
	._on_CombatSingifier_mouse_entered()


func _set_current_description() -> void:
	var format = Terms.COMMON_FORMATS[entity_type].duplicate()
	format["effect_name"] = name
	format["amount"] = str(stacks)
	format["double_amount"] = str(2*stacks)
	format["triple_amount"] = str(3*stacks)
	format["half_amount"] = str(stacks/2)
	decription_label.text = description_string.format(format)

# Returns the lowercase name of the token
func get_effect_name() -> String:
	return(name.to_lower())


# Executes a custom script defined in an effect
func execute_script(
		script := [],
		trigger_object: Node = self,
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = null
	sceng = cfc.scripting_engine.new(
			script,
			get_parent().combat_entity,
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


func _on_player_turn_ended(_turn: Turn) -> void:
	if entity_type == Terms.PLAYER and self_decreasing == SELF_DECREASE.TURN_START:
		set_stacks(stacks - 1)

func _on_player_turn_started(_turn: Turn) -> void:
	if entity_type == Terms.PLAYER and self_decreasing == SELF_DECREASE.TURN_END:
		set_stacks(stacks - 1)

func _on_enemy_turn_ended(_turn: Turn) -> void:
	if entity_type == Terms.ENEMY and self_decreasing == SELF_DECREASE.TURN_START:
		set_stacks(stacks - 1)

func _on_enemy_turn_started(_turn: Turn) -> void:
	if entity_type == Terms.ENEMY and self_decreasing == SELF_DECREASE.TURN_END:
		set_stacks(stacks - 1)

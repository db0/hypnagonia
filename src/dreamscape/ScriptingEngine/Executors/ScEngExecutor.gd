# This class is responsible for connecting the Scripting Engine
# results back into the card game framework.
# Objects extending this class will contain the method and payload for modifying 
# the game state as expected by the card's execution, 
# but do not automatically execute when created. 
# This allows each game logic to delay the payload from being applied until 
# the game is ready for it. This could be instantly, or it could be after some animation
# finished playing.
class_name ScEngExecutor
extends Reference

# warning-ignore:unused_signal
signal executed(dry_run)

# Each script task has a unique name, such as "flip_card"
var task_name := "script_executor"
# The return code of this object
# It should always be one of the values in CFConst.ReturnCode
# Typically the ScriptingEngine expects CFConst.ReturnCode.CHANGED for is_cost
# Tasks, and CFConst.ReturnCode.CHANGED or CFConst.ReturnCode.OK for non-costs tasks
# This value should normally be returned by the methods which are modifying the
# game state
var rc: int = CFConst.ReturnCode.CHANGED
# All Scripts going through the Scripting Engine are tagged in some way
# to help with further ScEng triggers. So this variable will always be filled
var tags: Array
# Which node on the table owns this task execution. 
# This is typically a Card, but it can be pretty much anything
var owner
# We also store the complete task object along, just in case it needs to be used further
var script_task: ScriptTask
# The snapshot_id of the current ScEng execution which generated this Executor
# This is sent as part of the payload when doing dry runs, to simulate how the game state
# Would be modified by each task in the script.
var snapshot_id
# This is set to true, the first time this executor delivers it payload without a dry-run
var has_executed := false


# We only expect the ScriptTask object as an argument
# We then extract the required info from it directly.
func _init(_script_task: ScriptTask):
	script_task = _script_task
	owner = script_task.owner
	tags = ["Scripted"] + script_task.get_property(SP.KEY_TAGS)
	# warning-ignore:return_value_discarded
	connect("executed", self, "_when_finished_executing")


# If _dry_run is false, attempts to modify the game state as instructed and sets the rc
# If _dry_run is true, simply sets the rc but does not change the game state.
func exec(_dry_run:= false) -> int:
	return(rc)

func _when_finished_executing(dry_run: bool) -> void:
	if not dry_run:
		has_executed = true

class_name ExecModCounter
extends ScEngExecutor

var counter_name: String
# The amount of damage to inflict on the target
var modification


func _init(_counter_name, _modification, _script_task: ScriptTask).(_script_task):
	counter_name = _counter_name
	modification = _modification
	task_name = "mod_counter"


func exec(dry_run:= false) -> int:
	# Nothing to do here. It's handled by ScEng natively for now.
	emit_signal("executed", dry_run)
	return(rc)

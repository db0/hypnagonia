class_name ExecModifyMasteries
extends ScEngExecutor

var modification: int

func _init(
		_modification, 
		_script_task: ScriptTask).(_script_task):
	modification = _modification
	task_name = "modify_masteries"


func exec(dry_run:= false) -> int:
	rc = CFConst.ReturnCode.CHANGED
	globals.player.pathos.available_masteries += modification
	emit_signal("executed", dry_run)
	return(rc)

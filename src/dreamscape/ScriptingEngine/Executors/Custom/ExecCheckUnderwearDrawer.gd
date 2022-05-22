extends ScEngExecutor

var combat_entity

func _init(_combat_entity, _script_task: ScriptTask).(_script_task):
	combat_entity = _combat_entity
	task_name = "custom_script"


func exec(dry_run:= false) -> int:
	
	emit_signal("executed", dry_run)
	return(rc)

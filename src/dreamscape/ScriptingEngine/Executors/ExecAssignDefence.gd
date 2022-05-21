class_name ExecAssignDefence
extends ScEngExecutor

# The combat entity which will receive this damage
var combat_entity
# The amount of defence to give to the target
var defence
var set_to_mod


func _init(_combat_entity, _defence, _set_to_mod, _script_task: ScriptTask).(_script_task):
	combat_entity = _combat_entity
	defence = _defence
	set_to_mod = _set_to_mod
	task_name = "assign_defence"


func exec(dry_run:= false) -> int:
	rc = combat_entity.modify_defence(
			defence,
			set_to_mod,
			dry_run,
			tags,
			owner)
	emit_signal("executed", dry_run)
	return(rc)

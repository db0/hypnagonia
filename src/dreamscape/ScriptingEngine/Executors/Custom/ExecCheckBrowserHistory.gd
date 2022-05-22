extends ScEngExecutor

# The combat entity which will receive this damage
var combat_entity
# The amount of defence to give to the target
var defence = 10

func _init(_combat_entity, _script_task: ScriptTask).(_script_task):
	combat_entity = _combat_entity
	task_name = "custom_script"


func exec(dry_run:= false) -> int:
	combat_entity.modify_defence(
			-defence,
			false,
			dry_run,
			tags,
			owner)
	rc = owner.modify_health(
			defence,
			false,
			dry_run,
			tags,
			owner)
	emit_signal("executed", dry_run)
	return(rc)

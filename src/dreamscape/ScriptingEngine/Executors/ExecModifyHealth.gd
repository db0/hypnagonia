class_name ExecModifyHealth
extends ScEngExecutor

# The combat entity which will receive this damage
var combat_entity
# The amount of damage to inflict on the target
var modification
var set_to_mod


func _init(_combat_entity, _modification, _set_to_mod, _script_task: ScriptTask).(_script_task):
	combat_entity = _combat_entity
	modification = _modification
	set_to_mod = _set_to_mod
	task_name = "modify_health"


func exec(dry_run:= false) -> int:
	rc = combat_entity.modify_health(
			modification,
			set_to_mod,
			dry_run,
			tags,
			owner)
	emit_signal("executed", dry_run)
	return(rc)

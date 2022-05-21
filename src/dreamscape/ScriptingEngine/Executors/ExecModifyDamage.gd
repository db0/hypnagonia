class_name ExecModifyDamage
extends ScEngExecutor

# The combat entity which will receive this damage
var combat_entity
# The amount of damage to inflict on the target
var modification


func _init(_combat_entity, _modification, _script_task: ScriptTask).(_script_task):
	combat_entity = _combat_entity
	modification = _modification
	task_name = "modify_damage"


func exec(dry_run:= false) -> int:
	rc = combat_entity.modify_damage(
			modification,
			dry_run,
			tags,
			owner)
	return(rc)

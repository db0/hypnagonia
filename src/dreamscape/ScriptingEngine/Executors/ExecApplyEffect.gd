class_name ExecApplyEffect
extends ScEngExecutor

# The combat entity which will receive this effect
var combat_entity
# The amount of defence to give to the target
var effect_name: String
var final_amount: int
var set_to_mod: bool
var upgrade_name: String


func _init(_combat_entity, _effect_name, _final_amount, _set_to_mod, _upgrade_name, _script_task: ScriptTask).(_script_task):
	combat_entity = _combat_entity
	effect_name = _effect_name
	final_amount = _final_amount
	set_to_mod = _set_to_mod
	upgrade_name = _upgrade_name
	task_name = "apply_effect"


func exec(dry_run:= false) -> int:
	rc = combat_entity.active_effects.mod_effect(
			effect_name,
			final_amount,
			set_to_mod,
			dry_run,
			tags,
			upgrade_name)
	emit_signal("executed", dry_run)
	return(rc)

class_name ExecModifyPathos
extends ScEngExecutor

# The amount of defence to give to the target
var pathos: String
var modification: int
var is_convertion: bool
var upgrade_name: String
var type: String


func _init(
		_pathos, 
		_modification, 
		_is_convertion, 
		_type, 
		_script_task: ScriptTask).(_script_task):
	pathos = _pathos
	modification = _modification
	is_convertion = _is_convertion
	type = _type
	task_name = "modify_pathos"


func exec(dry_run:= false) -> int:
	rc = CFConst.ReturnCode.CHANGED
	if type == "temp":
		globals.player.pathos.temp_modify_requirements_for_mastery(pathos, modification)
	elif type == "released":
		var is_cost = script_task.get_property(SP.KEY_IS_COST)
		if is_convertion:
			#We do not use .release_pathos() as we need to keep track of the final modification
			if globals.player.pathos.repressed[pathos] < modification:
				modification = globals.player.pathos.repressed[pathos]
			globals.player.pathos.modify_repressed_pathos(pathos, -modification, !is_cost)
		globals.player.pathos.modify_released_pathos(pathos, modification, !is_cost)
	else:
		if is_convertion:
			if globals.player.pathos.released.get(pathos, 0) < modification:
				modification = globals.player.pathos.released.get(pathos, 0)
			globals.player.pathos.modify_released_pathos(pathos, -modification)
		globals.player.pathos.modify_repressed_pathos(pathos, modification)
	emit_signal("executed", dry_run)
	return(rc)

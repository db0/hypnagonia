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
	var pathos_type: PathosType = globals.player.pathos.pathi[pathos]
	if type == "temp":
		pathos_type.temp_modify_requirements_for_mastery(modification)
	elif type == "released":
		var is_cost = script_task.get_property(SP.KEY_IS_COST)
		if is_convertion:
			#We do not use .release_pathos() as we need to keep track of the final modification
			if pathos_type.repressed < modification:
				modification = int(pathos_type.repressed)
			pathos_type.modify_repressed(-modification, !is_cost)
		pathos_type.modify_released(modification, !is_cost)
	else:
		if is_convertion:
			if pathos_type.released < modification:
				modification = int(pathos_type.released)
			pathos_type.modify_released(-modification)
		pathos_type.modify_repressed(modification)
	emit_signal("executed", dry_run)
	return(rc)

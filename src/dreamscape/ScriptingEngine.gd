#class_name DreamscapeScriptingEngine
extends ScriptingEngine

# Just calls the parent class.
func _init(state_scripts: Array,
		owner,
		_trigger_card: Card,
		_trigger_details: Dictionary).(state_scripts,
		owner,
		_trigger_card,
		_trigger_details) -> void:
	pass

func inflict_damage(script: ScriptTask) -> int:
	var damage: int
	var alteration = 0
	var retcode: int
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the damage is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		damage = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			damage *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects)
		damage = per_msg.found_things
	else:
		damage = script.get_property(SP.KEY_AMOUNT)
	alteration = _check_for_alterants(script, damage)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	for combat_entity in script.subjects:
		retcode = combat_entity.take_damage(
				damage + alteration,
				costs_dry_run(),
				tags)
	return(retcode)
	
func assign_defence(script: ScriptTask) -> int:
	var modification: int
	var alteration = 0
	var retcode: int
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	if str(script.get_property(SP.KEY_AMOUNT)) == SP.VALUE_RETRIEVE_INTEGER:
		# If the modification is requested, is only applies to stored integers
		# so we flip the stored_integer's value.
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_AMOUNT)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_AMOUNT),
				script.owner,
				script.get_property(script.get_property(SP.KEY_AMOUNT)),
				null,
				script.subjects)
		modification = per_msg.found_things
	else:
		modification = script.get_property(SP.KEY_AMOUNT)
	alteration = _check_for_alterants(script, modification)
	if alteration is GDScriptFunctionState:
		alteration = yield(alteration, "completed")
	for combat_entity in script.subjects:
		retcode = combat_entity.receive_defence(
				modification + alteration,
				costs_dry_run(),
				tags)
	return(retcode)

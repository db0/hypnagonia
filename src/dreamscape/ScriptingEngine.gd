#class_name DreamscapeScriptingEngine
extends ScriptingEngine

# Just calls the parent class.
func _init(state_scripts: Array,
		owner,
		_trigger_object: Node,
		_trigger_details: Dictionary).(state_scripts,
		owner,
		_trigger_object,
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
	alteration = _check_for_effect_alterants(script, damage)
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

func apply_effect(script: ScriptTask) -> int:
	var retcode: int
	var modification: int
	var alteration = 0
	var effect_name: String = script.get_property(SP.KEY_EFFECT)
	# We inject the tags from the script into the tags sent by the signal
	var tags: Array = ["Scripted"] + script.get_property(SP.KEY_TAGS)
	if str(script.get_property(SP.KEY_MODIFICATION)) == SP.VALUE_RETRIEVE_INTEGER:
		modification = stored_integer
		if script.get_property(SP.KEY_IS_INVERTED):
			modification *= -1
	elif SP.VALUE_PER in str(script.get_property(SP.KEY_MODIFICATION)):
		var per_msg = perMessage.new(
				script.get_property(SP.KEY_MODIFICATION),
				script.owner,
				script.get_property(script.get_property(SP.KEY_MODIFICATION)),
				null,
				script.subjects)
		modification = per_msg.found_things
		print_debug(per_msg.found_things, modification)
	else:
		modification = script.get_property(SP.KEY_MODIFICATION)
	var set_to_mod: bool = script.get_property(SP.KEY_SET_TO_MOD)
	if not set_to_mod:
		alteration = _check_for_alterants(script, modification)
		if alteration is GDScriptFunctionState:
			alteration = yield(alteration, "completed")
	var stacks_diff := 0
	for e in script.subjects:
		var entity: CombatEntity = e
		var current_stacks: int
		# If we're storing the integer, we want to store the difference
		# cumulative difference between the current and modified effect stacks
		# among all the tasrgets
		# If we set set stacks to 1, and one entity had 3 stacks,
		# while another had 0
		# The total stored integer would be -1
		# This allows us to do an effect like
		# Remove all Poison stacks from all entities, gain 1 health for each stack removed.
		if script.get_property(SP.KEY_STORE_INTEGER):
			current_stacks = entity.active_effects.get_effect_stacks(effect_name)
			if set_to_mod:
				stacks_diff += modification + alteration - current_stacks
			elif current_stacks + modification + alteration < 0:
				stacks_diff += -current_stacks
			else:
				stacks_diff = modification + alteration
		retcode = entity.active_effects.mod_effect(effect_name,
				modification + alteration,set_to_mod,costs_dry_run(), tags)
	if script.get_property(SP.KEY_STORE_INTEGER):
		stored_integer = stacks_diff
	return(retcode)

# Initiates a seek through the owner and target combat entity to see if there's any effects
# which modify the intensity of the task in question
func _check_for_effect_alterants(script: ScriptTask, value: int) -> int:
	var total_alteration = 0
	var alteration_details = {}
	var source_object: CombatEntity
	if script.trigger_object.get_class() == "Card":
		source_object = cfc.NMAP.board.dreamer
	elif "combat_entity" in script.trigger_object:
		source_object = script.trigger_object.combat_entity
	else:
		source_object = script.trigger_object
	var all_source_effects = source_object.active_effects.get_all_effects().values()
	for effect in all_source_effects:
		var alteration : int = effect.get_effect_alteration(script, value, true)
		alteration_details[effect] = alteration
		total_alteration += alteration
	return(total_alteration)



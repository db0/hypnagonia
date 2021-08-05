class_name EnemyIntents
extends HBoxContainer

const SINGLE_INTENT_SCENE = preload("res://src/dreamscape/CombatElements/Enemies/SingleIntent.tscn")

var all_intents: Array
var unused_intents: Array
# The enemy entity owning these intents
var combat_entity
var intent_name: String

var all_intent_scripts = IntentScripts.new()

func prepare_intents(specific_index = null) -> void:
	# This will reshuffle all intents and make sure the specified intent is the 
	# one selected for this enemy. This is useful for setting up enemies.
	if not unused_intents.size():
		reshuffle_intents()
	var new_intents : Dictionary
	if specific_index != null:
		unused_intents = all_intents.duplicate(true)
		new_intents = unused_intents[specific_index].duplicate(true)
		unused_intents.remove(specific_index)
		CFUtils.shuffle_array(unused_intents)
	else:
		new_intents = unused_intents.pop_back().duplicate(true)
	if new_intents.reshuffle:
		reshuffle_intents()
	for intent in get_children():
		intent.queue_free()
	yield(get_tree().create_timer(0.01), "timeout")
	for intent in new_intents.intent_scripts:
		# Some intents can use a generic format of "Intent Name: Value"
		# Therefore we always split the intent name (i.e. the key) on a colon, and the name
		# is always the first part.
		var intent_array = intent.split(':')
		# We store the name of the last script in the list of intents as the 
		# intent name. Then we can use it for special animations and so on.
		intent_name = intent_array[0]
		var intent_scripts = all_intent_scripts.get_scripts(intent_name)
		if not intent_scripts:
			print_debug("WARNING: Intent with name '" + intent_name + "' not found!")
		else:
			# If there is a second value in the intent_array, it means this is
			# a generic intent and the value is provided in the intent name
			# after the colon separator.
#			print_debug("Added Intent: " + intent_name)
			if intent_array.size() > 1:
				if intent_scripts[0].has("amount"):
					intent_scripts[0].amount = int(intent_array[1])
				else:
					intent_scripts[0].modification = int(intent_array[1])
#				print_debug("Set Intent Value: " + intent_array[1])
			if intent_array.size() > 2:
				if intent_scripts[0].has("effect_name"):
					intent_scripts[0].effect_name = Terms.ACTIVE_EFFECTS[intent_array[2]].name
			for single_intent in intent_scripts:
				var new_intent : CombatSignifier = SINGLE_INTENT_SCENE.instance()
				add_child(new_intent)
				new_intent.setup(single_intent, intent_name)


func reshuffle_intents() -> void:
	unused_intents = all_intents.duplicate(true)
	if not combat_entity.get_property("_is_ordered"):
		CFUtils.shuffle_array(unused_intents)
#	print_debug(unused_intents)

func get_total_damage() -> int:
	var total_damage := 0
	for intent in get_children():
		if "Attack" in intent.intent_script.tags:
			total_damage += intent.amount
	return(total_damage)

# Executes the tasks defined in the intent's scripts in order.
#
# Returns a [ScriptingEngine] object but that it not statically typed
# As it causes the parser think there's a cyclic dependency.
func execute_scripts(
		trigger_object:= self,
		_trigger: String = "manual",
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = null
	var current_intents = []
	for intent in get_children():
		current_intents.append(intent.intent_script)
		# This evocation of the ScriptingEngine, checks the card for
		# cost-defined tasks, and performs a dry-run on them
		# to ascertain whether they can all be paid,
		# before executing the card script.
	sceng = cfc.scripting_engine.new(
			current_intents,
			combat_entity,
			trigger_object,
			trigger_details)
	# In case the script involves targetting, we need to wait on further
	# execution until targetting has completed
	sceng.execute(CFInt.RunType.COST_CHECK)
	if not sceng.all_tasks_completed:
		yield(sceng,"tasks_completed")
	# If the dry-run of the ScriptingEngine returns that all
	# costs can be paid, then we proceed with the actual run
	if sceng.can_all_costs_be_paid and not only_cost_check:
		#print("DEBUG:" + str(state_scripts))
		# The ScriptingEngine is where we execute the scripts
		# We cannot use its class reference,
		# as it causes a cyclic reference error when parsing
		sceng.execute()
		if not sceng.all_tasks_completed:
			yield(sceng,"tasks_completed")
	# This will only trigger when costs could not be paid, and will
	# execute the "is_else" tasks
	elif not sceng.can_all_costs_be_paid and not only_cost_check:
		#print("DEBUG:" + str(state_scripts))
		sceng.execute(CFInt.RunType.ELSE)
	return(sceng)

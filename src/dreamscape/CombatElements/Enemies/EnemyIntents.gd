class_name EnemyIntents
extends HBoxContainer

const SINGLE_INTENT_SCENE = preload("res://src/dreamscape/CombatElements/CombatSignifier.tscn")

var current_intents: Array
var all_intents: Array
var unused_intents: Array
# The enemy entity owning these intents
var combat_entity

func prepare_intents() -> void:
	if not unused_intents.size():
		reshuffle_intents()
	var new_intents : Dictionary = unused_intents.pop_back().duplicate(true)
	if new_intents.reshuffle:
		reshuffle_intents()
	current_intents.clear()
	for intent in get_children():
		intent.queue_free()
	yield(get_tree().	create_timer(0.01), "timeout")
	for intent in new_intents.intent_scripts:
		# Some intents can use a generic format of "Intent Name: Value"
		# Therefore we always split the intent name (i.e. the key) on a colon, and the name
		# is always the first part.
		var intent_array = intent.split(':')
		var intent_name = intent_array[0]
		var intent_scripts = IntentScripts.INTENTS.get(intent_name)
		if not intent_scripts:
			print_debug("WARNING: Intent with name '" + intent_name + "' not found!")
		else:
			# If there is a second value in the intent_array, it means this is
			# a generic intent and the value is provided in the intent name
			# after the colon separator.
#			print_debug("Added Intent: " + intent_name)
			if intent_array.size() > 1:
				intent_scripts[0].amount = int(intent_array[1])
#				print_debug("Set Intent Value: " + intent_array[1])
			current_intents.append(intent_scripts)
			for single_intent in intent_scripts:
				var new_intent : CombatSignifier = SINGLE_INTENT_SCENE.instance()
				add_child(new_intent)
				new_intent.setup(single_intent, intent_name)

func reshuffle_intents() -> void:
	unused_intents = all_intents.duplicate(true)
	CFUtils.shuffle_array(unused_intents)
#	print_debug(unused_intents)


# Executes the tasks defined in the intent's scripts in order.
#
# Returns a [ScriptingEngine] object but that it not statically typed
# As it causes the parser think there's a cyclic dependency.
func execute_scripts(
		trigger_card: Card = null,
		trigger: String = "manual",
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = null
	for intent_script in current_intents:
		# This evocation of the ScriptingEngine, checks the card for
		# cost-defined tasks, and performs a dry-run on them
		# to ascertain whether they can all be paid,
		# before executing the card script.
		sceng = cfc.scripting_engine.new(
				intent_script,
				combat_entity,
				trigger_card,
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

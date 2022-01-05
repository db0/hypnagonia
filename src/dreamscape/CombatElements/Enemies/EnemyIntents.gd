class_name EnemyIntents
extends GridContainer

signal intents_predicted
signal intents_displayed

const SINGLE_INTENT_SCENE = preload("res://src/dreamscape/CombatElements/Enemies/SingleIntent.tscn")

var all_intents: Array
var unused_intents: Array
# The enemy entity owning these intents
var combat_entity
# This stores a single name for the whole action planned by the enemy.
# This is typically used for playing animations
var animation_name: String
# Keeps track of how many times a specific intent has been used in this battle
# when it only had limited uses
var intent_uses: Dictionary
# The hash of the last used intent dictionary (for comparisons)
var last_used_intent: int
var times_last_intent_repeated: int
var next_intent_id := ''
# Tracks wether we finished adding the intent children nodes.
var intents_displayed := false
# This dictionary is filled with values taken from the encounter specification
# It allows us to rebalance the enemy based on its difficulty (easy/medium/hard)
# Its keys should be the name of the intent being rebalanced. The values should
# how much to rebalance -/+
# The keys below, are the ones supported until now
var rebalancing := {
	"Stress": 0,
	"Perplex": 0,
	"Debuff": 0,
	"Buff": 0,
}
var all_intent_scripts = IntentScripts.new()

func prepare_intents(specific_index = null, is_second_try := false) -> Dictionary:
	# This will reshuffle all intents and make sure the specified intent is the
	# one selected for this enemy. This is useful for setting up enemies.
	if not unused_intents.size():
		reshuffle_intents()
	var new_intents : Dictionary
	var selected_intent: Dictionary
	if specific_index != null:
		unused_intents = all_intents.duplicate()
		selected_intent = unused_intents[specific_index]
		unused_intents.remove(specific_index)
		CFUtils.shuffle_array(unused_intents)
	# If we're setting up the next intent specifically
	# Then we grab it from the index position of the non-shuffled list
	# Then remove it from the unused intents, if it's still in there.
	elif next_intent_id != '':
		for intent_seek in all_intents:
			if intent_seek.get("id", '') == next_intent_id:
				selected_intent = intent_seek
		for intent in unused_intents:
			if intent.hash() == selected_intent.hash():
				unused_intents.erase(intent)
	else:
		for cinte in unused_intents:
			var eval_intent : Dictionary = cinte
			# If the intent is not in standard intent rotation, then it can
			# only be selected through the sets_up_intent_index key.
			if eval_intent.get("not_in_rotation", false):
				continue
			# If an intent can only be used a specific amount of times in a row
			# And it has reached that amount, then we keep looking
			# This assumes that the exact same intent does not exist multiple times
			# in the list
			elif eval_intent.has("max_in_a_row")\
					and last_used_intent == eval_intent.hash():
				if times_last_intent_repeated >= eval_intent["max_in_a_row"]:
					times_last_intent_repeated = 0
					continue
				else:
					selected_intent = eval_intent
					unused_intents.erase(eval_intent)
					break
			else:
				times_last_intent_repeated = 0
				selected_intent = eval_intent
				unused_intents.erase(eval_intent)
				break
	# There is a chance that is the stars align (or if the developer messed up)
	# no intent will be selected. In this case, we reset the intents list and try again fresh.
	# Assuming the developer did not mess up, this should return at least one intent, but 
	# There is a chance
	if selected_intent.empty():
		# if we restart this process, we set a flag. if we end up twice without
		# a valid intent, we abort to avoid looping infinitely.
		if not is_second_try:
			print_debug("WARNING: no valid Intent selected. Reseting and Retrying. "
					+ "Please check intents of Torment: " + combat_entity.canonical_name)
			reshuffle_intents()
			# warning-ignore:return_value_discarded
			prepare_intents(null, true)
			return({})
		else:
			printerr("ERROR: Could not discover valid intent. Please check intents list for this enemy. Aborting. ")
	last_used_intent = selected_intent.hash()
	times_last_intent_repeated += 1
	# This allows us to select some intents which can only be used a specified
	# amount per encounter by this Torment. Every time they are used
	# we remove them from the "master" array of intents.
	if selected_intent.get("max_uses"):
		intent_uses[selected_intent] = intent_uses.get(selected_intent,0) + 1
		if intent_uses[selected_intent] >= selected_intent.max_uses:
			all_intents.erase(selected_intent)
#			print_debug("Removed ", selected_intent, intent_uses)
	new_intents = selected_intent.duplicate(true)
	# If this intent sets up the next intent, then we store the next intent index to use here.
	# If this is not defined, then the value will be -1 which is ignored.
	next_intent_id = new_intents.get("sets_up_intent", '')
	if new_intents.reshuffle:
		reshuffle_intents()
	_display_intents(new_intents)
	return(new_intents)

func reshuffle_intents() -> void:
	unused_intents = all_intents.duplicate()
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
	_pre_execute_scripts()
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
	_post_execute_scripts()
	return(sceng)


func predict_intents(snapshot_id: int) -> void:
	yield(get_tree(), "idle_frame")
	for intent in get_children():
		intent.recalculate_amount(snapshot_id)
	emit_signal("intents_predicted")


# Returns a pointer to the dictionary in all_intents which has the specified
# "id" key.
# If not found, returns null
func find_intent_id(intent_id: String):
	for intent in all_intents:
		if intent.has("id") and intent_id == intent["id"]:
			return(intent)


# Discovers the intent with the chosen id in all_intents, and erases it
func erase_intent_id(intent_id: String):
	var intent = find_intent_id(intent_id)
	if intent:
		all_intents.erase(intent)
	

#	Injects the specified intent dictionary into all_intents
func insert_intent(intent: Dictionary, index = null):
	if index:
		all_intents.insert(index, intent)
	else:
		all_intents.append(intent)


# Clears existing intents, and replaces them with a new one from unused_intents
# As if the entity was first created
func refresh_intents(specific_index = null) -> void:
	if not intents_displayed:
		yield(self, "intents_displayed")
	next_intent_id = ''
	times_last_intent_repeated = 0
	reshuffle_intents()
	for intent in get_children():
		intent.queue_free()
	prepare_intents(specific_index)

# We have this externally to allow to override it if needed (e.g. for boss intents)
func _get_intent_scripts(_intent_name: String) -> Array:
	return(all_intent_scripts.get_scripts(_intent_name))


# Goes through the specified intents and shows their combat signifiers
func _display_intents(new_intents: Dictionary) -> void:
	for intent in get_children():
		intent.queue_free()
	intents_displayed = false
	yield(get_tree().create_timer(0.01), "timeout")
	for intent in new_intents.intent_scripts:
		# Some intents can use a generic format of "Intent Name: Value"
		# Therefore we always split the intent name (i.e. the key) on a colon, and the name
		# is always the first part.
		var intent_array = intent.split(':')
		# We store the name of the last script in the list of intents as the
		# intent name. Then we can use it for special animations and so on.
		var intent_name = intent_array[0]
		animation_name = intent_name
		var intent_scripts = _get_intent_scripts(intent_name)
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
			# If there is a third value in the intent_array, it means this is
			# an add/remove effect intent. The name of the effect is the
			# third field in the name
			if intent_array.size() > 2:
				if intent_scripts[0].has("effect_name"):
					intent_scripts[0].effect_name = Terms.ACTIVE_EFFECTS[intent_array[2]].name
			var rebalance : int = rebalancing.get(intent_name,0)
			if rebalance != 0:
				if intent_scripts[0].has("amount"):
					intent_scripts[0].amount += rebalance
				if intent_scripts[0].has("modification"):
					intent_scripts[0].modification += rebalance
			for single_intent in intent_scripts:
				var new_intent : CombatSignifier = SINGLE_INTENT_SCENE.instance()
				add_child(new_intent)
				new_intent.setup(single_intent, intent_name)
	intents_displayed = true
	emit_signal("intents_displayed")

# Overridable function
func _pre_execute_scripts() -> void:
	pass

# Overridable function
func _post_execute_scripts() -> void:
	pass

# This class contains very custom scripts definitionsa for objects that need them
#
# The definition happens via object name
class_name CustomScripts
extends Reference

var costs_dry_run := false

func _init(_dry_run) -> void:
	costs_dry_run = _dry_run
# This fuction executes custom scripts
#
# It relies on the definition of each script being based the object's name
# Therefore the only thing we need, is the object itself to grab its name
# And to have a self-reference in case it affects itself
#
# You can pass a predefined subject, but it's optional.
func custom_script(script: ScriptObject) -> void:
	var card: Card = script.owner
	var subjects: Array = script.subjects
	# I don't like the extra indent caused by this if, 
	# But not all object will be Card
	# So I can't be certain the "canonical_name" var will exist
	match script.owner.canonical_name:
		"The Joke":
			# No demo cost-based custom scripts
			if not costs_dry_run:
				if subjects.size() and subjects[0] as EnemyEntity:
					var enemy_entity: EnemyEntity = subjects[0]
					if enemy_entity.active_effects.get_effect(Terms.ACTIVE_EFFECTS.disempower):
						var the_joke = [{
							"name": "modify_damage",
							"subject": "trigger",
							"amount": 10,
							"tags": ["Damage"],
						}]
						execute_script(the_joke, script.owner, enemy_entity)
					else:
						var the_joke = [{
							"name": "apply_effect",
							"effect": Terms.ACTIVE_EFFECTS.disempower,
							"subject": "trigger",
							"modification": 3,
						}]
						execute_script(the_joke, script.owner, enemy_entity)
		"Barrel Through":
			# No demo cost-based custom scripts
			if not costs_dry_run:
				if subjects.size() and subjects[0] as EnemyEntity:
					var enemy_entity: EnemyEntity = subjects[0]
					print_debug(enemy_entity.active_effects.get_effect(Terms.ACTIVE_EFFECTS.vulnerable))
					if enemy_entity.active_effects.get_effect(Terms.ACTIVE_EFFECTS.vulnerable):
						var barrel_through = [{
								"name": "modify_damage",
								"amount": 12,
								"tags": ["Damage"],
								"subject": "boardseek",
								SP.KEY_SUBJECT_COUNT: "all",
								"sort_by": "random",
								"filter_state_seek": [{
									"filter_not_enemy": enemy_entity,
								}],
						}]
						execute_script(barrel_through, script.owner, enemy_entity)

# warning-ignore:unused_argument
func custom_alterants(script: ScriptObject) -> int:
	var alteration := 0
	return(alteration)



# Executes a custom script so that all modifiers are also handled.
func execute_script(
		script : Array,
		owner: Node,
		trigger_object: Node,
		trigger_details: Dictionary = {},
		only_cost_check := false):
	var sceng = null
	sceng = cfc.scripting_engine.new(
			script,
			owner,
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

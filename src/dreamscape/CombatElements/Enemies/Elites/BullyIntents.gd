extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Notice"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Gather Crowd"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Gather Crowd"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Call Buddy"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Call Buddy"],
		"reshuffle": true,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)

func prepare_intents(specific_index = null, _is_second_try := false) -> Dictionary:
	if not unused_intents.size():
		reshuffle_intents()
	var new_intents : Dictionary
	if specific_index != null:
		unused_intents = all_intents.duplicate(true)
		new_intents = unused_intents[specific_index].duplicate(true)
		unused_intents.remove(specific_index)
		CFUtils.shuffle_array(unused_intents)
	else:
		new_intents = unused_intents.pop_front().duplicate(true)
	if new_intents.reshuffle:
		reshuffle_intents()
	_display_intents(new_intents)
	return(new_intents)

func execute_special(script: ScriptTask, costs_dry_run := false) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if costs_dry_run:
		return(retcode)
	var crowd_health_mod := 0
	match combat_entity.get_property("_difficulty"):
		"easy":
			crowd_health_mod = -3
		"hard":
			crowd_health_mod = +2
	var summon_crowd = [{
		"name": "spawn_enemy",
		"enemy": EnemyDefinitions.THE_LAUGHING_ONE,
		"tags": ["Intent"],
		"modify_spawn_health": -15 + crowd_health_mod,
		"set_spawn_as_minion": true
	}]
	var atk_anxiety : int
	match script.get_property("torment_special"):
		"Call Buddy":
			atk_anxiety = 15
		"Gather Crowd":
			atk_anxiety = 7
	var crowd_damage = [{
		"name": "modify_damage",
		"subject": "dreamer",
		"amount": atk_anxiety,
		"tags": ["Attack", "Intent"],
	}]
	var pre_execution_dreamer_damage = cfc.NMAP.board.dreamer.damage
	var sceng = execute_special_script(crowd_damage, script.owner, combat_entity)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	if pre_execution_dreamer_damage < cfc.NMAP.board.dreamer.damage:
		execute_special_script(summon_crowd, script.owner, combat_entity)
	return(retcode)


# This is necessary to show the results of special intents
func calculate_special(sceng, subject: CombatEntity, script: ScriptTask) -> int:
	var calculation := 0
	var atk_anxiety : int
	match script.get_property("torment_special"):
		"Call Buddy":
			atk_anxiety = 15
		"Gather Crowd":
			atk_anxiety = 7
	var crowd_damage = {
		"name": "modify_damage",
		"subject": "dreamer",
		"amount": atk_anxiety,
		"tags": ["Attack", "Intent"],
	}
	# To properly calculate a special intent, we need to convert it
	# into a ScriptTask and pass it to the right calculate function
	var script_task := ScriptTask.new(
			combat_entity,
			crowd_damage,
			combat_entity,
			{})
	script_task.prime([],CFInt.RunType.COST_CHECK,0)
	if not script_task.is_primed:
		yield(script_task,"primed")
	calculation = sceng.calculate_modify_damage(subject, script_task)
	return(calculation)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Array:
# warning-ignore:unused_variable
	var enraged_stacks: int
	var vulnerable_stacks := 1
	match combat_entity.get_property("_difficulty"):
		"hard":
			vulnerable_stacks = 2
	var scripts := {
		"Notice": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": vulnerable_stacks,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "Hey look, the new kid is here. What's up, ugly?"
			},
		],
		"Call Buddy": [
			{
				"name": "torment_special",
				"tags": ["Attack", "Intent"],
				# We need to have an amount and subject here, even though
				# They are anyway replaced in the special script
				# Because the prediction code requires them to populate
				# The intent prediction properly.
				"amount": 15,
				"subject": "dreamer",
				"icon": preload("res://assets/icons/alien-egg.png"),
				"description": "What's the matter, gonna cry?",
				"torment_special": "Call Buddy",
				"predict_as": true
			},
		],
		"Gather Crowd": [
			{
				"name": "torment_special",
				"tags": ["Attack", "Intent"],
				"amount": 7,
				"subject": "dreamer",
				"icon": preload("res://assets/icons/alien-egg.png"),
				"description": "You're never gonna have any friends here...",
				"torment_special": "Gather Crowd",
				"predict_as": true
			},
			{
				"name": "torment_special",
				"tags": ["Attack", "Intent"],
				"amount": 7,
				"subject": "dreamer",
				"icon": preload("res://assets/icons/alien-egg.png"),
				"description": "...am I right, everyone?",
				"torment_special": "Gather Crowd",
				"predict_as": true
			},
		],
	}
	return(scripts.get(intent_name,{}))

extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Denial"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Minimisation"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Gaslighting"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Blameshifting"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Irresponsibility"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Projection"],
		"reshuffle": true,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)

func prepare_intents() -> void:
	if not unused_intents.size():
		refresh_intents()
	var new_intents : Dictionary = unused_intents.pop_front().duplicate(true)
	if new_intents.reshuffle:
		refresh_intents()
	for intent in get_children():
		intent.queue_free()
	yield(get_tree().create_timer(0.01), "timeout")
	for intent in new_intents.intent_scripts:
		# Some intents can use a generic format of "Intent Name: Value"
		# Therefore we always split the intent name (i.e. the key) on a colon, and the name
		# is always the first part.
		var intent_array = intent.split(':')
		var intent_name = intent_array[0]
		var intent_scripts = get_boss_scripts(intent_name)
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

func refresh_intents() -> void:
	unused_intents = all_intents.duplicate(true)

func get_boss_scripts(intent_name: String) -> Dictionary:
	var scripts := {
		"Denial": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 4,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "That didn't happen."
			}
		],
		"Minimisation": [
			{
				"name": "modify_damage",
				"tags": ["Damage", "Intent"],
				"subject": "dreamer",
				"amount": 10 + get_outrage(),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "And if it did..."
			},
			{
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 15,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description": "...it wasn't that bad."
			}			
		],
		"Gaslighting": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 1 + get_outrage(),
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "And if it was..."
			},
			{
				"name": "spawn_enemy",
				"enemy": EnemyDefinitions.GASLIGHTER,
				"tags": ["Intent"],
				"modify_spawn_health": -25 + (get_outrage() * 2),
				"icon": preload("res://assets/icons/alien-egg.png"),
				"description": "...that's not a big deal."
			}
		],
		"Blameshifting": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 4,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "And if it is..."
			},
			{
				"name": "modify_damage",
				"tags": ["Damage", "Intent"],
				"subject": "dreamer",
				"amount": 5 + get_outrage(),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "... that's not my fault."
			},
		],
		"Irresponsibility": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"tags": ["Intent"],
				"subject": "dreamer",
				"modification": 2,
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "And if it was..."
			},
			{
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "self",
				"amount": 10,
				"icon": all_intent_scripts.ICON_DEFEND,
				"description":  "...I didn't mean it."
			}
		],
		"Projection": [
			{
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.outrage.name,
				"tags": ["Intent"],
				"subject": "self",
				"modification": 1,
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "And if I did..."
			},
			{
				"name": "modify_damage",
				"tags": ["Damage", "Intent"],
				"subject": "dreamer",
				"amount": 23 + (get_outrage() * 2),
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "...you deserved it."
			},
		],
	}
	return(scripts.get(intent_name,{}))

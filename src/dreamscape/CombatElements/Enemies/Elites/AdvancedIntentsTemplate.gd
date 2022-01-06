extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["IntentName1"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["IntentName2"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["IntentName3"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["IntentName4"],
		"reshuffle": true,
		"max_in_a_row": 2,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Array:
	var intent_scripts := []
	var script : Dictionary
	match combat_entity.get_property("_difficulty"):
		"easy":
			pass
		"medium":
			pass
		"hard":
			pass
	match intent_name:
		"IntentName1":
			intent_scripts.append(script)
		"IntentName2":
			intent_scripts.append(script)
		"IntentName3":
			intent_scripts.append(script)
		"IntentName4":
			intent_scripts.append(script)
	return(intent_scripts)

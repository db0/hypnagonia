extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Your Place"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Pondering"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Pondering"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Ennui"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Existential Anguish"],
		"reshuffle": true,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func _get_elite_scripts(intent_name: String) -> Array:
	var intent_scripts := []
	var script : Dictionary
	var difficulty
	match combat_entity.get_property("_difficulty"):
		"easy":
			difficulty = 2
		"medium":
			difficulty = 3
		"hard":
			difficulty = 4
	match intent_name:
		"Existential Anguish":
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": difficulty * 10,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.",
			}
			intent_scripts.append(script)
	match intent_name:
		"Pondering":
			script = {
				"name": "assign_defence",
				"tags": ["Intent"],
				"subject": "boardseek",
				"amount": difficulty,
				"subject_count": "all",
				"filter_state_seek": [{
					"filter_group": "EnemyEntities",
				},],
				"icon": all_intent_scripts.ICON_DEFEND,
				"description": "Perplex Group: Will give all Torments the specified amount of {perplexity}."
			}
			intent_scripts.append(script)
			if get_tree().get_nodes_in_group("EnemyEntities").size() == 1:
				script = {
					"name": "modify_damage",
					"tags": ["Attack", "Intent"],
					"subject": "dreamer",
					"amount": difficulty * 3,
					"icon": all_intent_scripts.ICON_ATTACK,
					"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.",
				}
				intent_scripts.append(script)
	match intent_name:
		"Ennui":
			script = {
				"name": "spawn_card_to_container",
				"card_name": "Inescepable Conclusion",
				"dest_container": "hand",
				"object_count": 1,
				"tags": ["Intent"],
				"icon": all_intent_scripts.ICON_SPAWN_CARD,
				"description": "This Torment is planning to give you a card."
			}
			intent_scripts.append(script)
	match intent_name:
		"Your Place":
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": (difficulty * 3) + 4,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.",
			}
			intent_scripts.append(script)
	return(intent_scripts)

extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Infinite"],
		"reshuffle": false,
		"max_uses": 1,
	},
	{
		"intent_scripts": ["Unending"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Boring"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["So Many Doors"],
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
	var difficulty
	match intent_name:
		"Infinite":
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.infinite_tedium.name,
				"subject": "self",
				"modification": 1,
				"tags": ["Intent"],
				"icon": all_intent_scripts.ICON_SPECIAL,
				"description": "Starting at infinity: [i]I could feel this was going to be a long walk...[/i]"
			}
			intent_scripts.append(script)
			script = {
					"name": "assign_defence",
					"tags": ["Intent"],
					"subject": "self",
					"amount": 13,
					"icon": all_intent_scripts.ICON_DEFEND,
					"description": "Perplex: Will give this Torment the specified amount of {perplexity}."
				}
			intent_scripts.append(script)
		"Unending":
			match combat_entity.get_property("_difficulty"):
				"easy":
					difficulty = 1
				"medium":
					difficulty = 2
				"hard":
					difficulty = 3
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 18 + difficulty * 4,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]This way and that way, but never an end.[/i]"
			}
			intent_scripts.append(script)
		"So Many Doors":
			match combat_entity.get_property("_difficulty"):
				"easy":
					difficulty = 1
				"medium":
					difficulty = 2
				"hard":
					difficulty = 3
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 12 + difficulty,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]I keep checking the random doors appearing to the side, but they're all locked.[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": 13 + difficulty,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]I tried rushing them as well, but I just bounced off as if I was full of air.[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
				"subject": "dreamer",
				"modification": 1,
				"tags": ["Intent"],
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "This Torment is planning to apply a debuff to the Dreamer."\
						+ "[i]But every door looked like it was just a crack open as I approached. Was it a mirage?[/i]"
			}
			intent_scripts.append(script)
		"Boring":
			match combat_entity.get_property("_difficulty"):
				"easy":
					difficulty = 1
				"medium":
					difficulty = 1
				"hard":
					difficulty = 2
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.drain.name,
				"subject": "dreamer",
				"modification": difficulty,
				"tags": ["Intent","Delayed"],
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "Mind Numbing: This Torment is planning to debuff the dreamer.\n"\
						 + "[i]Step after boring step...[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "spawn_card_to_container",
				"tags": ["Intent"],
				"card_name": "Lethe",
				"object_count": 1,
				"dest_container": "Deck",
				"icon": all_intent_scripts.ICON_SPAWN_CARD,
				"description": "Mind Numbing: This Torment is planning to debuff the dreamer.\n"\
						+ "[i]...this drudgery is making me forget who I even am.[/i]"
			}
			intent_scripts.append(script)
			

	return(intent_scripts)

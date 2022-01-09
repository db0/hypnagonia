extends BossIntents

const INTENTS := [
	{
		"intent_scripts": ["Jumble", "Chaos"],
		"reshuffle": false,
	},
	{
		"intent_scripts": ["Rumble", "Chaos"],
		"reshuffle": true,
		"max_in_a_row": 1,
	},
	{
		"intent_scripts": ["Debuff", "Chaos"],
		"reshuffle": false,
	},
]

func _ready() -> void:
	all_intents = INTENTS.duplicate(true)


func _get_intent_scripts(intent_name: String) -> Array:
	return(_get_elite_scripts(intent_name))


func execute_special(_script: ScriptTask, costs_dry_run := false) -> int:
	var retcode: int = CFConst.ReturnCode.CHANGED
	if costs_dry_run:
		return(retcode)
	var rng_card = cfc.NMAP.hand.get_random_card()
	if rng_card:
		var rarity = rng_card.get_property("_rarity")
		var type = rng_card.get_property("Type")
		var is_upgraded = false
		if rng_card.deck_card_entry:
			is_upgraded = rng_card.deck_card_entry.is_upgraded()
		var card_options = globals.player.compile_card_type(type, [rarity], is_upgraded)
		CFUtils.shuffle_array(card_options)
		if card_options.size() > 0:
			var new_card = cfc.instance_card(card_options[0])
			cfc.NMAP.hand.add_child(new_card)
			new_card.set_to_idle()
			rng_card.remove_from_deck(false)
	return(retcode)


func _get_elite_scripts(intent_name: String) -> Array:
	var intent_scripts := []
	var script : Dictionary
	var difficulty
	match combat_entity.get_property("_difficulty"):
		"easy":
			difficulty = 3
		"medium":
			difficulty = 4
		"hard":
			difficulty = 5
	match intent_name:
		"Chaos":
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
				"subject": "self",
				"modification": 1,
				"tags": ["Intent"],
				"icon": all_intent_scripts.ICON_BUFF,
				"description": "Chaos: This Torment is planning to buff itself.\n"\
						+ "[i]It impossible to focus on.[/i]"
			}
			intent_scripts.append(script)
		"Jumble":
			script = {
				"name": "torment_special",
				"tags": ["Intent"],
				"subject": "dreamer",
				"icon": all_intent_scripts.ICON_SPECIAL,
				"description": "Jumble",
				"torment_special": "Jumble: [i]What was I doing again?[/i]",
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
						+ "[i]Was I walking this way? No I'm sure it was that way.[/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": difficulty * 2,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]Was that a picture of a living person?[/i]"
			}
			intent_scripts.append(script)
		"Rumble":
			for _iter in range(difficulty):
				script = {
					"name": "modify_damage",
					"tags": ["Attack", "Intent"],
					"subject": "dreamer",
					"amount": 1,
					"icon": all_intent_scripts.ICON_ATTACK,
					"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]I think the floor moved.[/i]"
				}
				intent_scripts.append(script)
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": difficulty * 4,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i]I rearranged itself all over again![/i]"
			}
			intent_scripts.append(script)
		"Debuff":
			script = {
				"name": "apply_effect",
				"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
				"subject": "dreamer",
				"modification": 2,
				"tags": ["Intent"],
				"icon": all_intent_scripts.ICON_DEBUFF,
				"description": "This Torment is planning to apply a debuff to the Dreamer."\
						+ "[i][/i]"
			}
			intent_scripts.append(script)
			script = {
				"name": "modify_damage",
				"tags": ["Attack", "Intent"],
				"subject": "dreamer",
				"amount": difficulty * 3,
				"icon": all_intent_scripts.ICON_ATTACK,
				"description": "Stress: Will cause the dreamer to take the specified amount of {anxiety}.\n"\
						+ "[i][/i]"
			}
			intent_scripts.append(script)
	return(intent_scripts)

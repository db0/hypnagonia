#extends CoreScripts
extends "res://src/dreamscape/cards/sets/SetScripts_Core.gd"

const scripts := {
	"Dread": {
		"manual": {
			"hand": [
				{
					"name": "remove_card_from_deck",
					"tags": ["Card"],
					"subject": "self",
				},
			],
		},
	},
	"Terror": {
		"manual": {
			"hand": [
				{
					"name": "remove_card_from_deck",
					"tags": ["Card"],
					"subject": "self",
				},
			],
		},
	},
	"Unease": {
		"on_player_turn_ended": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					}
				}
			],
		},
	},
	"Discombobulation": {
		"on_player_turn_ended": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					}
				}
			],
		},
	},
	"Prejudice": {
		"on_player_turn_ended": {
			"hand": [
				{
					"name": "apply_effect",
					"tags": ["Card"],
					"effect_name": Terms.ACTIVE_EFFECTS.burn.name,
					"subject": "dreamer",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "effect_stacks",
					}
				}
			],
		},
	},
	"Alertness": {
		"card_moved_to_hand": {
			"hand": [
				{
					"name": "mod_counter",
					"tags": ["Card"],
					"trigger": "self",
					"counter_name": "immersion",
					"modification":  {
						"lookup_property": "_amounts",
						"value_key": "immersion_amount",
					}
				},
			],
			"filter_source": "deck",
		},
		"on_player_turn_started": {
			"hand": [
				{
					# Have to go with a custom_script here, because the
					# signal to end_turn might trigger on the card
					# before it triggers on the counters
					# so I need to wait for the immersion to be increased
					# first
					"name": "custom_script",
					"tags": ["Card"],
				},
			],
		},
		"on_player_turn_ended": {
			"hand": [
				{
					"name": "move_card_to_container",
					"tags": ["Card"],
					"subject": "self",
					"dest_container": "forgotten",
				},
			],
		},
	},
	"Apathy": {
		"shuffle_completed": {
			"pile": [
				{
					"name": "custom_script",
					"tags": ["Card"],
				}
			],
			"filter_source": "deck",
		},
	},
	"Dubious Painkillers": {
		"manual": {
			"hand": [
				{
					"name": "modify_damage",
					"subject": "dreamer",
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "exert_amount"
					},
					"tags": ["Exert", "Card"],
				},
				{
					"name": "modify_health",
					"subject": "dreamer",
					"amount": {
						"lookup_property": "_amounts",
						"value_key": "health_amount",
					},
					"tags": ["Card"],
				},
				{
					"name": "move_card_to_container",
					"subject": "self",
					"dest_container": "forgotten",
					"tags": ["Played", "Card"],
				},
			],
		},
	},
}


# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	# We return only the scripts that match the card name and trigger
	return(_prepare_scripts(scripts, card_name))

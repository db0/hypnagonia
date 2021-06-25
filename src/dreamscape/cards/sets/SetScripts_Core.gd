# See README.md
extends Reference

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Assault": {
			"manual": {
				"hand": [
					{
						"name": "modify_health",
						"subject": "target",
						"is_cost": true,
						"amount": 6,
						"tags": ["Damage"],
						"filter_state_subject": [{
							"filter_group": "CombatEntities",
						}],
					},
				],
			},
		},
		"Defend": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"is_cost": true,
						"amount": 5,
					}
				],
			},
		},
		"Noisy Whip": {
			"manual": {
				"hand": [
					{
						"name": "modify_health",
						"subject": "target",
						"is_cost": true,
						"amount": 5,
						"tags": ["Damage"],
						"filter_state_subject": [{
							"filter_group": "CombatEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.disempower,
						"subject": "previous",
						"modification": 1,
					}
				],
			},
		},
		"Dive-in": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.vulnerable,
						"subject": "dreamer",
						"modification": 2,
					},
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.advantage,
						"subject": "dreamer",
						"modification": 1,
					}
				],
			},
		},
		"Safety of Air": {
			"manual": {
				"hand": [
					{
						"name": "modify_health",
						"subject": "dreamer",
						"is_cost": true,
						"amount": -4,
						"tags": ["Healing"],
					},
				],
			},
		},
		"Laugh at Danger": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.laugh_at_danger,
						"is_cost": true,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Confounding Movements": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"is_cost": true,
						"amount": 4,
					},
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.disempower,
						"subject": "target",
						"is_cost": true,
						"modification": 1,
					}
				],
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))

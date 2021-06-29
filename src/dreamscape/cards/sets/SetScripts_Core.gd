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
							"filter_group": "EnemyEntities",
						}],
					},
				],
			},
		},
		"Confidence": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
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
							"filter_group": "EnemyEntities",
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
						"amount": -4,
						"tags": ["Healing"],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Nothing to Fear": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.nothing_to_fear,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Untouchable": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.impervious,
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
						"amount": 4,
					},
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.disempower,
						"subject": "target",
						"is_cost": true,
						"modification": 1,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Inner Justice": {
			"manual": {
				"hand": [
					{
						"name": "mod_counter",
						"counter_name": "immersion",
						"is_cost": true,
						"modification": -3,
					},
					{
						"name": "mod_counter",
						"counter_name": "immersion",
						"modification": 5,
					},
				],
			},
		},
		"Whirlwind": {
			"manual": {
				"hand": [
					{
						"name": "modify_health",
						"subject": "target",
						"is_cost": true,
						"amount": 3,
						"tags": ["Damage"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_health",
						"subject": "previous",
						"amount": 3,
						"tags": ["Damage"],
					},
					{
						"name": "modify_health",
						"subject": "previous",
						"amount": 3,
						"tags": ["Damage"],
					},
				],
			},
		},
		"Overview": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "target",
						"amount": 0,
						"set_to_mod": true,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
				],
			},
		},
		"Rubber Eggs": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": ActiveEffects.NAMES.rubber_eggs,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},

	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))

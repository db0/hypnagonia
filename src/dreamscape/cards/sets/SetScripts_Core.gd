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
						"name": "modify_damage",
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
						"name": "modify_damage",
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
						"effect": Terms.ACTIVE_EFFECTS.disempower,
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
						"effect": Terms.ACTIVE_EFFECTS.vulnerable,
						"subject": "dreamer",
						"modification": 2,
					},
					{
						"name": "apply_effect",
						"effect": Terms.ACTIVE_EFFECTS.advantage,
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
						"name": "modify_damage",
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
						"effect": Terms.ACTIVE_EFFECTS.nothing_to_fear,
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
						"effect": Terms.ACTIVE_EFFECTS.impervious,
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
						"effect": Terms.ACTIVE_EFFECTS.disempower,
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
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 3,
						"tags": ["Damage"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"subject": "previous",
						"amount": 3,
						"tags": ["Damage"],
					},
					{
						"name": "modify_damage",
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
						"effect": Terms.ACTIVE_EFFECTS.rubber_eggs,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"The Joke": {
			"manual": {
				"hand": [
					{
						"name": "custom_script",
						"subject": "target",
						"is_cost": true,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Nunclucks": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": Terms.ACTIVE_EFFECTS.nunclucks,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Gummiraptor": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 10,
						"tags": ["Damage"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "modify_damage",
						"is_cost": true,
						"amount": 10,
						"tags": ["Damage"],
						"subject": "previous",
						"filter_gummiraptor": true,
					}
				],
			},
		},
		"Cocky Retort": {
			"manual": {
				"hand": [
					# We have a function to discard manually to ensure
					# it's not counted for checking if the hand is full
					{
						"name": "move_card_to_container",
						"dest_container": cfc.NMAP.discard,
						"subject": "self",
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 8,
					},
					{
						"name": "move_card_to_container",
						"src_container": cfc.NMAP.deck,
						"dest_container": cfc.NMAP.hand,
						"subject_count": 1,
						"subject": "index",
						"subject_index": "top",
					},
				],
			},
		},
		"Rapid Encriclement": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": Terms.ACTIVE_EFFECTS.vulnerable,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": 2,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Barrel Through": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"amount": 8,
						"tags": ["Damage"],
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "custom_script",
						"subject": "previous",
					},
				],
			},
		},
		"Intimidate": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": Terms.ACTIVE_EFFECTS.poison,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": 2,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Cheeky Approach": {
			"manual": {
				"hand": [
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"amount": 10,
					},
					{
						"name": "apply_effect",
						"effect": Terms.ACTIVE_EFFECTS.poison,
						"subject": "target",
						"is_cost": true,
						"modification": 3,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					}
				],
			},
		},
		"Laugh at Danger": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": Terms.ACTIVE_EFFECTS.laugh_at_danger,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
		"Towering Presence": {
			"manual": {
				"hand": [
					{
						"name": "modify_damage",
						"subject": "target",
						"is_cost": true,
						"tags": ["Damage"],
						"amount": "per_defence",
						"per_defence": {
							"subject": "dreamer",
						},
					},
				],
			},
		},
		"Unassailable": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect": Terms.ACTIVE_EFFECTS.unassailable,
						"subject": "dreamer",
						"modification": 1,
					},
				],
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(scripts.get(card_name,{}))

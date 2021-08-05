extends CoreScripts

# This fuction returns all the scripts of the specified card name.
#
# if no scripts have been defined, an empty dictionary is returned instead.
func get_scripts(card_name: String) -> Dictionary:
	var scripts := {
		"Gaslighter": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "target",
						"is_cost": true,
						"modification": 2,
						"filter_state_subject": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "previous",
						"modification": "per_effect_stacks",
						"per_effect_stacks": {
							"subject": "dreamer",
							"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						},
					},
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.poison.name,
						"subject": "dreamer",
						"modification": 0,
						"set_to_mod": true,
					}
				],
			},
		},
		"Fearmonger": {
			"manual": {
				"hand": [
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"is_cost": true,
						"src_container":  cfc.NMAP.deck,
						"dest_container":  cfc.NMAP.forgotten,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Type": "Perturbation"
								}
							}
						],
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"is_cost": true,
						"amount": 4,
					},
					{
						"name": "move_card_to_container",
						"subject": "tutor",
						"is_else": true,
						"src_container":  cfc.NMAP.discard,
						"dest_container":  cfc.NMAP.forgotten,
						"filter_state_tutor": [
							{
								"filter_properties": {
									"Type": "Perturbation"
								}
							}
						],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"is_else": true,
						"dest_container": cfc.NMAP.discard,
					},
					{
						"name": "assign_defence",
						"subject": "dreamer",
						"is_else": true,
						"amount": 4,
					}
				],
			},
		},
		"The Laughing One": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
						"subject": "dreamer",
						"modification": 1,
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Broken Mirror": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.impervious.name,
						"subject": "dreamer",
						"modification": 1,
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"The Critic": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.vulnerable.name,
						"subject": "target",
						"modification": 10,
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Clown": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.disempower.name,
						"subject": "boardseek",
						"subject_count": "all",
						"modification": 3,
						"filter_state_seek": [{
							"filter_group": "EnemyEntities",
						}],
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
		"Unnamed Enemy 1": {
			"manual": {
				"hand": [
					{
						"name": "apply_effect",
						"effect_name": Terms.ACTIVE_EFFECTS.thorns.name,
						"subject": "dreamer",
						"modification": 3,
					},
					{
						"name": "move_card_to_container",
						"subject": "self",
						"dest_container": cfc.NMAP.forgotten,
					},
				],
			},
		},
	}
	# We return only the scripts that match the card name and trigger
	return(_prepare_scripts(scripts, card_name))

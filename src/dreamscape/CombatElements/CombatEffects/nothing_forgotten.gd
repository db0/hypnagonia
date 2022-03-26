extends CombatEffect

func _on_player_turn_started(_turn: Turn) -> void:
	var script = [
		{
			"name": "modify_properties",
			"tags": ["Card"],
			"set_properties": {"Tags": Terms.GENERIC_TAGS.frozen.name},
			"needs_subject": true,
			"subject": "tutor",
			"filter_state_tutor": [{
				"filter_cardfilters": [
					{
						"property": "Tags",
						"value": Terms.GENERIC_TAGS.frozen.name,
						"comparison": "ne",
					}
				],
			}],
			"subject_count": stacks,
			"sort_by": "random",
			"src_container": "hand",
		},
	]
	execute_script(script)

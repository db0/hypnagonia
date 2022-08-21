extends Artifact


func _on_player_turn_started(_turn: Turn = null) -> void:
	var script = [
		{
			"name": "modify_properties",
			"tags": ["Curio"],
			"set_properties": 
				{
					"Cost": '-' + str(ArtifactDefinitions.BossRandomDiscount.amounts.immersion_amount)
				},
			"subject": "tutor",
			"filter_state_tutor": [{
				"filter_cardfilters": [
					{
						"property": "Cost",
						"value": 1,
						"comparison": "ge",
					}
				],
			}],
			"subject_count": 1,
			"sort_by": "random",
			"src_container": "hand",
			"up_to": true,
			"is_cost": true,
		},
		{
			"name": "enable_rider",
			"tags": ["Curio"],
			"rider": "reset_cost_after_play",
			"subject": "previous",
		},
	]
	execute_script(script)

func _on_scripting_completed(_artifact, _sceng) -> void:
	_send_trigger_signal()

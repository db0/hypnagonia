extends CombatEffect

func _on_player_turn_started(_turn: Turn) -> void:
	for iter in stacks:
		var spare_lens = [
			{
				"name": "spawn_card_to_container",
				"card_filters": [
					{
						'property': 'Tags',
						'value': Terms.GENERIC_TAGS.fusion.name,
					},
					{
						'property': '_is_upgrade',
						'value': false,
					},
					{
						'property': '_rarity',
						'value': "Common",
					}
				],
				"dest_container": "deck",
				"selection_amount": 1,
				"object_count": 1,
				"tags": ["Card"],
			},
		]
		execute_script(spare_lens)


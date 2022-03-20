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
		# I am waiting a bit to avoid conflicting with the normal hand reshuffle.
		# This means this effect will happen only after the hand is reshuffled.
		execute_script(spare_lens)
		yield(get_tree().create_timer(0.2), "timeout")

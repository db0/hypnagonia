extends CombatEffect

func _on_player_turn_ended(_turn: Turn) -> void:
	var recall = [{
			"name": "move_card_to_container",
			"dest_container": cfc.NMAP.deck,
			"src_container": cfc.NMAP.discard,
			"subject": "index",
			"subject_index": "top",
			"subject_count": stacks,
			"is_cost": true,
		},
		{
			"name": "shuffle_container",
			"dest_container": cfc.NMAP.deck,
		},
	]
	# I am waiting a bit to avoid conflicting with the normal hand reshuffle.
	# This means this effect will happen only after the hand is reshuffled.
	yield(get_tree().create_timer(0.3), "timeout")
	while not cfc.NMAP.hand.is_hand_refilled:
		yield(cfc.NMAP.hand, "hand_refilled")
	execute_script(recall)
		

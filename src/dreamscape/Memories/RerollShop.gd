extends Memory

func execute_memory_effect():
	player_info_node.owner_node.reroll_shop()
	_send_trigger_signal()

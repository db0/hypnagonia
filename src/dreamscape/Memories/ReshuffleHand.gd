extends Memory

func execute_memory_effect():
	var hand_count : int = cfc.NMAP.hand.get_card_count()
	var script = [
			{
				"name": "move_card_to_container",
				"tags": ["Memory"],
				"src_container": "hand",
				"dest_container": "deck",
				"subject_count": "all",
				"subject": "index",
				"subject_index": "top",
			},
			{
				"name": "shuffle_container",
				"tags": ["Memory"],
				"dest_container": "deck",
			},
			{
				"name": "draw_cards",
				"tags": ["Memory"],
				"card_count": hand_count
			},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

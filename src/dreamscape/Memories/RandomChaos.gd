extends Memory

func execute_memory_effect():
	var script = [
			{
				"name": "autoplay_card",
				"src_container": "deck",
				"subject_count": MemoryDefinitions.RandomChaos.amounts.draw_amount,
				"subject": "index",
				"subject_index": "top",
			},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

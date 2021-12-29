extends Memory

func execute_memory_effect() -> void:
	var script = [
			{
				"name": "autoplay_card",
				"src_container": "deck",
				"subject_count": MemoryDefinitions.RandomChaos.amounts.draw_amount,
				"subject": "index",
				"subject_index": "random",
			},
	]
	execute_script(script)

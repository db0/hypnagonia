extends Memory

func execute_memory_effect() -> void:
	var script = [
			{
				"name": "draw_cards",
				"tags": ["Memory"],
				"card_count": MemoryDefinitions.CardDraw.amounts.draw_amount
			},
	]
	execute_script(script)

extends Memory

func execute_memory_effect():
	var script = [
			{
				"name": "draw_cards",
				"tags": ["Memory"],
				"card_count": MemoryDefinitions.CardDraw.amounts.draw_amount
			},
	]
	var sceng = execute_script(script)
	if sceng is GDScriptFunctionState:
		sceng = yield(sceng, "completed")
	return(sceng)

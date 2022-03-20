extends Memory

func execute_memory_effect():
	for card in cfc.NMAP.forgotten.get_all_cards():
		card.execute_scripts(null,"battle_begun", {})

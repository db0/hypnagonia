extends Memory

func execute_memory_effect():
	globals.player.health += MemoryDefinitions.GainMaxHealth.amounts.anxiety_amount

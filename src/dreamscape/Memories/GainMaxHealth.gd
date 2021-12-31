extends Memory

func execute_memory_effect() -> void:
	globals.player.health += MemoryDefinitions.GainMaxHealth.amounts.anxiety_amount

extends TormentCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.poison.name
	memory_definition = MemoryDefinitions.PoisonEnemy

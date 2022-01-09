extends TormentCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.disempower.name
	memory_definition = MemoryDefinitions.DisempowerEnemy

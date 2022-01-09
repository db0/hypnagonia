extends DreamerCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.buffer.name
	memory_definition = MemoryDefinitions.BufferSelf

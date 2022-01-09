extends DreamerCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.quicken.name
	memory_definition = MemoryDefinitions.QuickenSelf

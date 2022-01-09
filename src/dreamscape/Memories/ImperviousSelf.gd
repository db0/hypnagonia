extends DreamerCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.impervious.name
	memory_definition = MemoryDefinitions.ImperviousSelf

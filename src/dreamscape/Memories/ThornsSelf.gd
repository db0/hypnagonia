extends DreamerCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.thorns.name
	memory_definition = MemoryDefinitions.ThornsSelf

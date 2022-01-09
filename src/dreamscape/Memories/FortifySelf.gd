extends DreamerCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.fortify.name
	memory_definition = MemoryDefinitions.FortifySelf

extends DreamerCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.protection.name
	memory_definition = MemoryDefinitions.ProtectSelf

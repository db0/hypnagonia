extends DreamerCombatEffectMemory

func _ready() -> void:
	effect_name = Terms.ACTIVE_EFFECTS.strengthen.name
	memory_definition = MemoryDefinitions.StrengthenSelf

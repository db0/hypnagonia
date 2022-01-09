class_name CombatEffectMemory
extends Memory

var effect_name: String
var memory_definition: Dictionary



func _get_upgrades_modifier() -> int:
	var upgrades := 0
	if "effect_stacks" in memory_definition.keys_modified_by_upgrade:
		upgrades = artifact_object.upgrades_amount * memory_definition.amounts.upgrade_multiplier
	return(upgrades)
	

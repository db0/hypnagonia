# Provides the metadata for each memory. Their script is contained within
# The script file with the same name under "res://src/dreamscape/Memories/"
# Each memory has an "amounts" key which is used populate both description
# and script. This allows us in the future to quickly tweak values without
# having to change multiple places
class_name MemoryDefinitions
extends Reference

# Defines when an artifact's effects are active.
# This allows us to know when to trigger artifact effects.
enum EffectContext {
	# This artifact's effects are active only outside battle
	OVERWORLD
	# This artifact's effects are active only during a battle
	BATTLE
	# This artifact triggers its effect only in the shop
	SHOP
}

"""
Frustration pathos memories have a big pathos release_adjustment. This means they release a large
amount of pathos everytime they do so. As such, low values of pathos_threshold_average_multiplier
mean that the memory will be filled up really easily. 
A value of 4 on pathos_threshold_average_multiplier will fill up in 3-4 Torment encounters.
As such you need to adjust the pathos_threshold_average_multiplier accordingly to how often you want it
to be refilling.
"""

const DamageAll := {
	"canonical_name": "DamageAll",
	"name": "The Big Fight",
	"description": "{memory_name}: Recall this memory during an Ordeal to {damage} all torments for {damage_amount}",
	"icon": preload("res://assets/icons/memories/portrait.png"),
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_average_multiplier": 5,
	"amounts": {
		"damage_amount": 10
	},
}
const HealSelf := {
	"canonical_name": "HealSelf",
	"name": "Mother's Comfort",
	"description": "{memory_name}: Recall this memory during an Ordeal to reduce your {anxiety} by {heal_amount}",
	"icon": preload("res://assets/icons/memories/portrait.png"),
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.rest,
	"pathos_threshold_average_multiplier": 4,
	"amounts": {
		"heal_amount": 5
	},
}
const BossFaster := {
	"canonical_name": "BossFaster",
	"name": "A Sense of Closure",
	"description": "{memory_name}: Recall this memory during the Dream Journal "\
			+ "to increased your repressed %s by {pathos_amount}" % [Terms.RUN_ACCUMULATION_NAMES.boss],
	"icon": preload("res://assets/icons/memories/portrait.png"),
	"context": EffectContext.OVERWORLD,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_average_multiplier": 1,
	"amounts": {
		"pathos_amount": 5
	},
}
const ProgressRandom := {
	"canonical_name": "ProgressRandom",
	"name": "ProgressRandom",
	"description": "{memory_name}: Recall this memory during the Dream Journal to progress a random card by {progress_amount}",
	"icon": preload("res://assets/icons/memories/portrait.png"),
	"context": EffectContext.OVERWORLD,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.shop,
	"pathos_threshold_average_multiplier": 1,
	"amounts": {
		"progress_amount": 2
	},
}
const SpikeEnemy := {
	"canonical_name": "SpikeEnemy",
	"name": "Childhood Curiosity",
	"description": "{memory_name}: Recall this memory during an Ordeal to {damage} one torment for {damage_amount}",
	"icon": preload("res://assets/icons/memories/portrait.png"),
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.nce,
	"pathos_threshold_average_multiplier": 2,
	"amounts": {
		"damage_amount": 20
	},
}
const FortifySelf := {
	"canonical_name": "FortifySelf",
	"name": "Stand Against a Bully",
	"description": "{memory_name}: Recall this memory during an Ordeal to gain {effect_stacks} {fortify}",
	"icon": preload("res://assets/icons/memories/portrait.png"),
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_average_multiplier": 1,
	"amounts": {
		"effect_stacks": 1
	},
}

# Generic memories which have a chance to appear in any playthrough
const GENERIC := [
	DamageAll,
	HealSelf,
	BossFaster,
	ProgressRandom,
	SpikeEnemy,
	FortifySelf,
]

# Archetype-specific memories which only appear in runs in which
# Their tied archetype is selected.
const ARCHETYPE := [
]

# These memories are only found in non-combat encounters
const ENCOUNTER := [
]


static func get_memories(
	archetype_memories := [],
	excluded_memories := []) -> Array:
	var ret_array := []
	for memory in GENERIC + archetype_memories:
		if not memory.canonical_name in excluded_memories:
			ret_array.append(memory)
	return(ret_array)


static func get_memory_bbcode_format(memory_definition: Dictionary) -> Dictionary:
	var format := {}
	format['memory_name'] = memory_definition.name
	for key in memory_definition.get('amounts', {}):
		format[key] = memory_definition.amounts[key]
	return(format)


static func get_complete_memories_array() -> Array:
	return(GENERIC + ARCHETYPE + ENCOUNTER)


static func find_memory_from_canonical_name(memory_canonical_name: String):
	for definition in get_complete_memories_array():
		if definition.canonical_name == memory_canonical_name:
			return(definition)


static func find_memory_from_name(memory_name: String):
	for definition in get_complete_memories_array():
		if definition.name == memory_name:
			return(definition)

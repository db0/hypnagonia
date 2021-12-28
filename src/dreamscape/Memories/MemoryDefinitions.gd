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
Keys:

* pathos: Which pathos is used to fill up this memory
* pathos_threshold_multiplier (default: 1): Normally the amount of pathos needed to fill up a memory is equal to
   the average progression for that pathos. This multiplier multiplies the amount of pathos needed to
   fill up that memory by this much. So e.g. with a multiplier of 2, frustration will go from needing 15 to fill up
   to needing 30.
* pathos_accumulation_divider (default: 2): If you want to increase the time taken to fill up a memory without increasing
   how much pathos will be used to do so, use this value. If used, the amount "sucked"
   from the memory any time pathos is released (typically the accumulation average), will be divided by this amount.
   Careful: A value of 1, means no released pathos will be accumulated while this memory is empty!

With a pathos_threshold_multiplier and a pathos_accumulation_divider of 2 each, on average
A memory will fill up every 4 encounters of that type. Typically you want these numbers to be higher
for common encounters like Enemies, and lower for rare encounters like elites.
In general, you want to aim for a memory to refill every 4-6 encounters
"""

const DamageAll := {
	"canonical_name": "DamageAll",
	"name": "The Big Fight",
	"description": "{memory_name}: Recall this memory during an Ordeal to {damage} all torments for {damage_amount}",
	"icon": preload("res://assets/icons/memories/portrait.png"),
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 1.8,
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
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 2.5,
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
	"pathos_threshold_multiplier": 2.5,
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

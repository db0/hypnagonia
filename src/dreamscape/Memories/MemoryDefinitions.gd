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
* pathos_threshold_multiplier (default: 2): Normally the amount of pathos needed to fill up a memory is equal to
	the average progression for that pathos. This multiplier multiplies the amount of pathos needed to
	fill up that memory by this much. So e.g. with a multiplier of 2, frustration will go from needing 15 to fill up
	to needing 30.
* pathos_accumulation_divider (default: 2): If you want to increase the time taken to fill up a memory without increasing
	how much pathos will be used to do so, use this value. If used, the amount "sucked"
	from the memory any time pathos is released (typically the accumulation average), will be divided by this amount.
	Careful: A value of 1, means no released pathos will be accumulated while this memory is empty!
* keys_modified_by_upgrade: This is used to let the code which displays the upgrades, to know which amounts
	to modify with the upgrades, before showing them to the player.

With a pathos_threshold_multiplier and a pathos_accumulation_divider of 2 each, on average
A memory will fill up every 4 encounters, assuming the player had enough released pathos.
Typically you want these numbers to be higher for powerful memories lower for weaker ones.
In general, you want to aim for a memory to refill every 3-6 encounters
"""

const DEFAULT_ICON = "res://assets/icons/memories/portrait.png"

const DamageAll := {
	"canonical_name": "DamageAll",
	"name": "The Big Fight",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to {damage} all torments for {damage_amount}",
	"icon": "res://assets/icons/memories/the_big_fight.png",
	"illustration": "SkylarkGSH",
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 1.8,
	"keys_modified_by_upgrade": ["damage_amount"],
	"amounts": {
		"damage_amount": 10,
		"upgrade_multiplier": 1
	},
}
const HealSelf := {
	"canonical_name": "HealSelf",
	"name": "Mother's Comfort",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to reduce your {anxiety} by {heal_amount}",
	"icon": "res://assets/icons/memories/mothers_comfort.png",
	"illustration": "SkylarkGSH",
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.rest,
	"pathos_threshold_multiplier": 3,
	"pathos_accumulation_divider": 2,
	"keys_modified_by_upgrade": ["heal_amount"],
	"amounts": {
		"heal_amount": 5,
		"upgrade_multiplier": 1
	},
}
const BossFaster := {
	"canonical_name": "BossFaster",
	"name": "A Sense of Closure",
	"description": "{memory_name} ({upgrades}): Recall this memory during the Dream Journal "\
			+ "to increased your repressed %s by {pathos_amount}" % [Terms.RUN_ACCUMULATION_NAMES.boss],
	"icon": "res://assets/icons/memories/a_sense_of_closure.png",
	"illustration": "SkylarkGSH",
	"context": EffectContext.OVERWORLD,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_multiplier": 1,
	"pathos_accumulation_divider": 2,
	"keys_modified_by_upgrade": ["pathos_amount"],
	"amounts": {
		"pathos_amount": 5,
		"upgrade_multiplier": 2
	},
}
const ProgressRandom := {
	"canonical_name": "ProgressRandom",
	"name": "University Life",
	"description": "{memory_name} ({upgrades}): Recall this memory during the Dream Journal "\
			+ "to progress a random card by {progress_amount}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.OVERWORLD,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.shop,
	"pathos_threshold_multiplier": 1.5,
	"pathos_accumulation_divider": 1.5,
	"keys_modified_by_upgrade": ["progress_amount"],
	"amounts": {
		"progress_amount": 2,
		"upgrade_multiplier": 1
	},
}
const SpikeEnemy := {
	"canonical_name": "SpikeEnemy",
	"name": "Childhood Curiosity",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to {damage} one torment for {damage_amount}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.nce,
	"pathos_threshold_multiplier": 3,
	"pathos_accumulation_divider": 2,
	"keys_modified_by_upgrade": ["damage_amount"],
	"amounts": {
		"damage_amount": 20,
		"upgrade_multiplier": 1
	},
}
const FortifySelf := {
	"canonical_name": "FortifySelf",
	"name": "Stand Against a Bully",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {effect_stacks} {fortify}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 2,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"effect_stacks": 1,
		"upgrade_multiplier": 0.1,
		"max_upgrades": 5,
	},
}
const DefendSelf := {
	"canonical_name": "DefendSelf",
	"name": "The Staredown",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {defence_amount} {defence}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 1.5,
	"keys_modified_by_upgrade": ["defence_amount"],
	"amounts": {
		"defence_amount": 12,
		"upgrade_multiplier": 2
	},
}
const QuickenSelf := {
	"canonical_name": "QuickenSelf",
	"name": "Philosophy Lessons",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {effect_stacks} {quicken}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.nce,
	"pathos_threshold_multiplier": 1,
	"pathos_accumulation_divider": 4,
	"keys_modified_by_upgrade": ["pathos_accumulation_divider"],
	"amounts": {
		"effect_stacks": 2,
		"upgrade_multiplier": 1,
		"max_upgrades": 20,
	},
}
const StrengthenSelf := {
	"canonical_name": "StrengthenSelf",
	"name": "Meditation Lessons",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {effect_stacks} {strengthen}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.rest,
	"pathos_threshold_multiplier": 1,
	"pathos_accumulation_divider": 4,
	"keys_modified_by_upgrade": ["pathos_accumulation_divider"],
	"amounts": {
		"effect_stacks": 2,
		"upgrade_multiplier": 1,
		"max_upgrades": 20,
	},
}
const RandomChaos := {
	"canonical_name": "RandomChaos",
	"name": "The Playground",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to play the top {draw_amount} cards from your deck.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.shop,
	"pathos_threshold_multiplier": 3.5,
	"pathos_accumulation_divider": 1.5,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"draw_amount": 2,
		"upgrade_multiplier": 1,
		"max_upgrades": 10,
	},
}
const ReshuffleHand := {
	"canonical_name": "ReshuffleHand",
	"name": "The Absolute Cringe",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to reshuffle your hand into your deck and draw the same amount of cards",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_multiplier": 1.7,
	"pathos_accumulation_divider": 1.7,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"upgrade_multiplier": 1,
		"max_upgrades": 5,
	},
}
const PoisonEnemy := {
	"canonical_name": "PoisonEnemy",
	"name": "Debating Competition",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to apply {effect_stacks} {poison} to one Torment",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 3,
	"keys_modified_by_upgrade": ["pathos_accumulation_divider"],
	"amounts": {
		"effect_stacks": 5,
		"upgrade_multiplier": 1
	},
}
const DisempowerEnemy := {
	"canonical_name": "DisempowerEnemy",
	"name": "Pun Jokes",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to apply {effect_stacks} {disempower} to one Torment",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 1.5,
	"keys_modified_by_upgrade": ["effect_stacks"],
	"amounts": {
		"effect_stacks": 2,
		"upgrade_multiplier": 1
	},
}
const ImperviousSelf := {
	"canonical_name": "ImperviousSelf",
	"name": "Skydiving Lessons",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {effect_stacks} {impervious}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 3,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"effect_stacks": 2,
		"upgrade_multiplier": 1
	},
}
const ImmerseSelf := {
	"canonical_name": "ImmerseSelf",
	"name": "LSD Trip",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {immersion_amount} {immersion}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.artifact,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 1.8,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"immersion_amount": 2,
		"upgrade_multiplier": 1,
		"max_upgrades": 5,
	},
}
const CardDraw := {
	"canonical_name": "CardDraw",
	"name": "CardDraw",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to draw {draw_amount} cards",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.artifact,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 1.8,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"draw_amount": 3,
		"upgrade_multiplier": 1,
		"max_upgrades": 5,
	},
}
const ExertRecovery := {
	"canonical_name": "ExertRecovery",
	"name": "The Courting Days",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to recover all {anxiety} you took during your own turn, this turn.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_multiplier": 3,
	"pathos_accumulation_divider": 2,
	"keys_modified_by_upgrade": ["pathos_accumulation_divider"],
	"amounts": {
		"upgrade_multiplier": 1
	},
}
const ExertSelf := {
	"canonical_name": "ExertSelf",
	"name": "The Bad Days",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {exert_amount} {anxiety}, {repeat_amount} times.\n"\
			+ "For every 2 points of anxiety taken, remove one random debuff stack applied to you.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_multiplier": 1,
	"pathos_accumulation_divider": 3,
	"keys_modified_by_upgrade": ["repeat_amount"],
	"amounts": {
		"exert_amount": 1,
		"repeat_amount": 5,
		"upgrade_multiplier": 1,
	},
}
const RegenerateSelf := {
	"canonical_name": "RegenerateSelf",
	"name": "Handgliding Expedition",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal.\n"\
			+ "At the end of the next {turns_amount} turns, "\
			+ "{relax} for {heal_amount}.\n"\
			+ "If you have {untouchable}, {relax} {heal_amount} extra.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_multiplier": 4,
	"pathos_accumulation_divider": 1.7,
	"keys_modified_by_upgrade": ["turns_amount"],
	"amounts": {
		"heal_amount": 1,
		"turns_amount": 8,
		"upgrade_multiplier": 1,
		"max_upgrades": 5,
	},
}
const BufferSelf := {
	"canonical_name": "BufferSelf",
	"name": "Frog Dissection Day",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {effect_stacks} {buffer}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_multiplier": 2,
	"pathos_accumulation_divider": 3,
	"keys_modified_by_upgrade": ["pathos_accumulation_divider"],
	"amounts": {
		"effect_stacks": 3,
		"upgrade_multiplier": 1,
		"max_upgrades": 15,
	},
}
const RerollDraft := {
	"canonical_name": "RerollDraft",
	"name": "Jumbled Fragments",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory when a Card Draft is active "\
			+ "to reroll the card draft.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.OVERWORLD,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.nce,
	"pathos_threshold_multiplier": 3.5,
	"pathos_accumulation_divider": 1.3,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"upgrade_multiplier": 2,
		"max_upgrades": 10,
	},
}
const RemovePerturbation := {
	"canonical_name": "RemovePerturbation",
	"name": "That Lazy Afternoon",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during the Dream Journal "\
			+ "to {release} a random {perturbation} from your deck.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.OVERWORLD,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.rest,
	"pathos_threshold_multiplier": 5.3,
	"pathos_accumulation_divider": 2,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"upgrade_multiplier": 2,
		"max_upgrades": 10,
	},
}
const RerollShop := {
	"canonical_name": "RerollShop",
	"name": "Rapid Flashes",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory inside the Shop "\
			+ "to reroll all the options.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.SHOP,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.artifact,
	"pathos_threshold_multiplier": 4.5,
	"pathos_accumulation_divider": 1.3,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"upgrade_multiplier": 3,
		"max_upgrades": 10,
	},
}
const GainMaxHealth := {
	"canonical_name": "GainMaxHealth",
	"name": "Birthday Party",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during the Dream Journal "\
			+ "to permanently increase your max {anxiety} {anxiety_amount}.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.OVERWORLD,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.shop,
	"pathos_threshold_multiplier": 4,
	"pathos_accumulation_divider": 2.2,
	"keys_modified_by_upgrade": ["pathos_accumulation_divider"],
	"amounts": {
		"anxiety_amount": 5,
		"upgrade_multiplier": 1,
		"max_upgrades": 10,
	},
}
const ProtectSelf := {
	"canonical_name": "ProtectSelf",
	"name": "ProtectSelf",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {effect_stacks} {protection}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.shop,
	"pathos_threshold_multiplier": 3,
	"pathos_accumulation_divider": 3,
	"keys_modified_by_upgrade": ["pathos_accumulation_divider"],
	"amounts": {
		"effect_stacks": 1,
		"upgrade_multiplier": 1,
		"max_upgrades": 10,
	},
}
const RemoveDebuff := {
	"canonical_name": "RemoveDebuff",
	"name": "The Poison Ivy Incident",
	"description": "{memory_name} ({upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {defence_amount} {defence} and remove {stacks_amount} stacks of your highest debuff.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.shop,
	"pathos_threshold_multiplier": 1.8,
	"pathos_accumulation_divider": 1.3,
	"keys_modified_by_upgrade": ["defence_amount"],
	"amounts": {
		"defence_amount": 5,
		"stacks_amount": 3,
		"upgrade_multiplier": 1
	},
}
const ActivateStartups := {
	"canonical_name": "ActivateStartups",
	"name": "First Kiss",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to gain the effects of all {startup} cards in your forgotten pile.",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.artifact,
	"pathos_threshold_multiplier": 2.5,
	"pathos_accumulation_divider": 1.3,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"upgrade_multiplier": 1,
		"max_upgrades": 5,
	},
}
const ThornsSelf := {
	"canonical_name": "ThornsSelf",
	"name": "Bullied",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to gain {effect_stacks} {thorns}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.enemy,
	"pathos_threshold_multiplier": 2.3,
	"pathos_accumulation_divider": 2.3,
	"keys_modified_by_upgrade": ["pathos_threshold_multiplier"],
	"amounts": {
		"effect_stacks": 3,
		"upgrade_multiplier": 1,
		"max_upgrades": 8,
	},
}
const FreezeCard := {
	"canonical_name": "FreezeCard",
	"name": "First Love",
	"description": "{memory_name} ({upgrades}/{max_upgrades}): Recall this memory during an Ordeal "\
			+ "to give a card in your hand {frozen}",
	"icon": DEFAULT_ICON,
	"context": EffectContext.BATTLE,
	"pathos": Terms.RUN_ACCUMULATION_NAMES.elite,
	"pathos_threshold_multiplier": 3,
	"pathos_accumulation_divider": 2,
	"keys_modified_by_upgrade": ["pathos_accumulation_divider"],
	"amounts": {
		"upgrade_multiplier": 1,
		"max_upgrades": 5,
	},
}

# Generic memories which have a chance to appear in any playthrough
const GENERIC := [
	DamageAll,
	HealSelf,
	BossFaster,
	ProgressRandom,
	SpikeEnemy,
	DefendSelf,
	QuickenSelf,
	StrengthenSelf,
	RandomChaos,
	ImmerseSelf,
	CardDraw,
	RerollDraft,
	RemovePerturbation,
	RerollShop,
	GainMaxHealth,
	ProtectSelf,
]

# Archetype-specific memories which only appear in runs in which
# Their tied archetype is selected.
const ARCHETYPE := [
	ReshuffleHand,
	PoisonEnemy,
	DisempowerEnemy,
	ImperviousSelf,
	FortifySelf,
	ExertRecovery,
	ExertSelf,
	RegenerateSelf,
	BufferSelf,
	ActivateStartups,
	ThornsSelf,
	FreezeCard,
]

# These memories are only found in non-combat encounters
const ENCOUNTER := [
	RemoveDebuff,
]


static func get_memories(
	archetype_memories := [],
	excluded_memories := []) -> Array:
	var ret_array := []
	for memory in GENERIC + archetype_memories:
		if not memory.canonical_name in excluded_memories:
			ret_array.append(memory)
	return(ret_array)


static func get_memory_bbcode_format(memory_definition: Dictionary, upgrades := 0) -> Dictionary:
	var format := {}
	format['memory_name'] = memory_definition.name
	format['upgrades'] = upgrades + 1
	for key in memory_definition.get('amounts', {}):
		var upgrade_modifier := 0
		if key in memory_definition.get("keys_modified_by_upgrade",[]) and upgrades > 0:
			upgrade_modifier = upgrades * memory_definition.amounts["upgrade_multiplier"]
		var amount = memory_definition.amounts[key] + upgrade_modifier
		if key in memory_definition.get("keys_modified_by_upgrade",[]):
			format[key] = "[color=yellow]%s[/color]" % [amount]
		else:
			format[key] = amount
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


static func memory_exists(memory_name: String) -> bool:
	if find_memory_from_canonical_name(memory_name):
		return(true)
	return(false)

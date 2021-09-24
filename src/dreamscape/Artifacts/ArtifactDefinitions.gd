# Provides the metadata for each artifact. Their script is contained within
# The script file with the same name under "res://src/dreamscape/Artifacts/"
# Each artifact has an "amounts" key which is used populate both description
# and script. This allows us in the future to quickly tweak values without
# having to change multiple places
class_name ArtifactDefinitions
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

const MaxHealth := {
	"canonical_name": "MaxHealth",
	"name": "MaxHealth",
	"description": "{artifact_name}: max {health} inreased by {health_amount}",
	"icon": preload("res://assets/icons/artifacts/centaur-heart.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"health_amount": 10
	},
}

const StartingHeal := {
	"canonical_name": "StartingHeal",
	"name": "StartingHeal",
	"description": "{artifact_name}: At the start of each Ordeal, {heal} for {heal_amount}.",
	"icon": preload("res://assets/icons/artifacts/glass-heart.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"heal_amount": 2
	},
}

const FirstPowerAttack := {
	"canonical_name": "FirstPowerAttack",
	"name": "FirstPowerAttack",
	"description": "{artifact_name}: Your first {attack} each encounter is increased by {effect_amount}",
	"icon": preload("res://assets/icons/artifacts/binoculars.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"effect_amount": 8
	},
}


const StartingCards := {
	"canonical_name": "StartingCards",
	"name": "Knapsack",
	"description": "{artifact_name}: At the start of each Ordeal, draw {draw_amount} cards.",
	"icon": preload("res://assets/icons/artifacts/knapsack.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"draw_amount": 2
	},

}


const RepressedEnemyBuff := {
	"canonical_name": "RepressedEnemyBuff",
	"name": "Fruscination",
	"description": "{artifact_name}: At the start of each Ordeal,"\
		+ " Gain {effect_stacks} {buffer} for each {pathos_amount} Released Frustration you have.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"effect_stacks": 1,
		"pathos_amount": 40
	},
}

const StartingImmersion := {
	"canonical_name": "StartingImmersion",
	"name": "Tiny Coala Friend",
	"description": "{artifact_name}: At the start of each Ordeal, gain {immersion_amount} {immersion}.",
	"icon": preload("res://assets/icons/artifacts/koala.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"immersion_amount": 1
	},
}


const StartingStrength := {
	"canonical_name": "StartingStrength",
	"name": "Mechanical Eyeball",
	"description": "{artifact_name}: At the start of each Ordeal, gain {effect_stacks} {strengthen}.",
	"icon": preload("res://assets/icons/artifacts/eyeball.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"effect_stacks": 1
	},
}


const StartingThorns := {
	"canonical_name": "StartingThorns",
	"name": "Crown of Thorns",
	"description": "{artifact_name}: At the start of each Ordeal, gain {effect_stacks} {thorns}.",
	"icon": preload("res://assets/icons/artifacts/crown-of-thorns.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"effect_stacks": 4
	},
}


const StartingConfidence := {
	"canonical_name": "StartingConfidence",
	"name": "Epic Mustache",
	"description": "{artifact_name}: At the start of each Ordeal, gain {defence_amount} {confidence}.",
	"icon": preload("res://assets/icons/artifacts/mustache.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"defence_amount": 10
	},
}


const ThickImmersion := {
	"canonical_name": "ThickImmersion",
	"name": "ThickImmersion",
	"description": "{artifact_name}: At that start of each Ordeal turn, gain {immersion_amount} {immersion}. "\
		+ "This effects ends when your deck is reshuffled and you gain {effect_stacks} {vulnerable}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"immersion_amount": 1,
		"effect_stacks": 3
	},
}


const ThickStrength := {
	"canonical_name": "ThickStrength",
	"name": "Extending Eye",
	"description": "{artifact_name}: At that start of each Ordeal turn, gain {effect_stacks} {strengthen}. "\
		+ "This effects and all added {strengthen} ends when your deck is reshuffled.",
	"icon": preload("res://assets/icons/artifacts/eyestalk.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"effect_stacks": 1
	},
}

# TODO
const UpgradedInterpretations := {
	"canonical_name": "UpgradedInterpretations",
	"name": "UpgradedInterpretations",
	"description": "{artifact_name}: Interpretation cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 4
	},
}


const UpgradedControl := {
	"canonical_name": "UpgradedControl",
	"name": "UpgradedControl",
	"description": "{artifact_name}: Interpretation cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 4
	},
}


const UpgradedUnderstanding := {
	"canonical_name": "UpgradedUnderstanding",
	"name": "UpgradedUnderstanding",
	"description": "{artifact_name}: Interpretation cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 6
	},
}


const UpgradedConcentration := {
	"canonical_name": "UpgradedConcentration",
	"name": "UpgradedConcentration",
	"description": "{artifact_name}: Interpretation cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 5
	},
}


const ThinCardDraw := {
	"canonical_name": "ThinCardDraw",
	"name": "Light Backpack",
	"description": "{artifact_name}: Every time you reshuffle the deck, draw {draw_amount} card.",
	"icon": preload("res://assets/icons/artifacts/light-backpack.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"draw_amount": 1
	},
}


const ResistDisempower := {
	"canonical_name": "ResistDisempower",
	"name": "ResistConfusion",
	"description": "{artifact_name}: You cannot receive {disempower} anymore.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
}


const ResistPoison := {
	"canonical_name": "ResistPoison",
	"name": "ResistDoubt",
	"description": "{artifact_name}: Any time you would receive {poison} reduce it by {alteration_amount}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
}


const ResistBurn := {
	"canonical_name": "ResistBurn",
	"name": "ResistEnvy",
	"description": "{artifact_name}: Any time you would receive {poison} reduce it by {alteration_amount}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
}


const ResistVulnerable := {
	"canonical_name": "ResistVulnerable",
	"name": "ResistShaken",
	"description": "{artifact_name}: You cannot receive {vulnerable} anymore.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",

}


const ImproveThorns := {
	"canonical_name": "ImproveThorns",
	"name": "ImproveThorns",
	"description": "{artifact_name}: Any time you would gain {thorns}, gain {alteration_amount} more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
}


const ImprovePoison := {
	"canonical_name": "ImprovePoison",
	"name": "ImprovePoison",
	"description": "{artifact_name}: Any time you would inflict {poison}, inflict {alteration_amount} more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
}


const ImproveBurn := {
	"canonical_name": "ImproveBurn",
	"name": "ImproveBurn",
	"description": "{artifact_name}: Any time you would inflict {burn}, inflict {alteration_amount} more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
}


const ThickExplosion := {
	"canonical_name": "ThickExplosion",
	"name": "ThickExplosion",
	"description": "{artifact_name}: The first time you reshuffle your deck, "\
		+ "deal damage to all enemies equal to your discard pile.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
}


const AccumulateEnemy := {
	"canonical_name": "AccumulateEnemy",
	"name": "RepressedFrustration",
	"description": "{artifact_name}: Increase your repressed Frustration by {pathos_amount}",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_amount": 60
	},
}
const AccumulateRest := {
	"canonical_name": "AccumulateRest",
	"name": "RepressedLethargy",
	"description": "{artifact_name}: Increase your repressed Lethargy by {pathos_amount}",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_amount": 30
	},
}
const AccumulateNCE := {
	"canonical_name": "AccumulateNCE",
	"name": "RepressedCuriosity",
	"description": "{artifact_name}: Increase your repressed Curiosity by {pathos_amount}",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_amount": 35
	},
}
const AccumulateShop := {
	"canonical_name": "AccumulateShop",
	"name": "RepressLoneliness",
	"description": "{artifact_name}: Increase your repressed Loneliness by {pathos_amount}",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_amount": 15
	},
}
const AccumulateElite := {
	"canonical_name": "AccumulateElite",
	"name": "RepressedForeboding",
	"description": "{artifact_name}: Increase your repressed Foreboding by {pathos_amount}",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_amount": 30
	},
}
const AccumulateArtifact := {
	"canonical_name": "AccumulateArtifact",
	"name": "RepressedDesire",
	"description": "{artifact_name}: Increase your repressed Desire by {pathos_amount}",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_amount": 10
	},
}

#TODO
const PowerHeal := {
	"canonical_name": "PowerHeal",
	"name": "Concentrated Rest",
	"description": "{artifact_name}: Whenever you play a concentration, {heal} for {healing_amount}.",
	"icon": preload("res://assets/icons/artifacts/nested-hearts.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"amounts": {
		"healing_amount": 2
	},
}


# Generic artifacts which have a chance to appear in any playthrough
const GENERIC := [
	StartingHeal,
	StartingStrength,
	StartingConfidence,
	StartingCards,
	StartingImmersion,
	FirstPowerAttack,
	AccumulateRest,
	AccumulateEnemy,
	AccumulateRest,
	AccumulateNCE,
	AccumulateShop,
	AccumulateElite,
	AccumulateArtifact,
	MaxHealth,
	RepressedEnemyBuff,
	ThickExplosion,
	ThickImmersion,
	ThickStrength,
	ThinCardDraw,
	UpgradedInterpretations,
	UpgradedControl,
	UpgradedUnderstanding,
	UpgradedConcentration,
	ResistPoison,
	ResistBurn,
	ResistDisempower,
	ResistVulnerable,
	PowerHeal,
]

# Archetype-specific artifacts which only appear in runs in which 
# Their tied archetype is selected.
const ARCHETYPE := [
	ImproveThorns,
	ImprovePoison,
	ImproveBurn,
	StartingThorns,
]

# Takes as arguments the purpose of artifacts to return. Generic, Shop or Boss
# Each purpose returns a slightly different format dictionary
# Also gets a list of archetypes tied to the current archetypes and merges them into
# The generic ones to return a common list
# Finally a list of artifacts to exclude can be passes
# Those would typically be artifacts already owned, or seen
static func get_organized_artifacts(
	purpose := "generic", 
	archetype_artifacts := [],
	excluded_artifacts := []) -> Dictionary:
	var ret_dict := {}
	match purpose:
		"generic":
			for rarity in ["Common", "Uncommon", "Rare"]:
				ret_dict[rarity] = []
				for artifact in GENERIC + archetype_artifacts:
					if artifact.rarity == rarity\
							and not artifact.name in excluded_artifacts:
						ret_dict[rarity].append(artifact)
	return(ret_dict)

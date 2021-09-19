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
	"name": "Unnamed1",
	"description": "{artifact_name}: max {health} inreased by 10",
	"icon": preload("res://assets/icons/artifacts/centaur-heart.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

const StartingHeal := {
	"canonical_name": "StartingHeal",
	"name": "Unnamed2",
	"description": "{artifact_name}: {heal} for 2 when you encounter a Torment",
	"icon": preload("res://assets/icons/artifacts/glass-heart.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

const FirstPowerAttack := {
	"canonical_name": "FirstPowerAttack",
	"name": "Unnamed3",
	"description": "{artifact_name}: Your first {attack} each encounter is increased by 8",
	"icon": preload("res://assets/icons/artifacts/binoculars.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const StartingCards := {
	"canonical_name": "StartingCards",
	"name": "Unnamed4",
	"description": "{artifact_name}: At the start of each Encounter, draw 2 cards.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const RepressedEnemyBuff := {
	"canonical_name": "RepressedEnemyBuff",
	"name": "Fruscination",
	"description": "{artifact_name}: At the start of each Encounter,"\
		+ " Gain 1 {buffer} for each 40 Released Frustration you have.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const StartingImmersion := {
	"canonical_name": "StartingImmersion",
	"name": "Unnamed5",
	"description": "{artifact_name}: At the start of each Encounter, gain 1 {immersion}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}


# TODO
const StartingStrength := {
	"canonical_name": "StartingStrength",
	"name": "Unnamed6",
	"description": "{artifact_name}: At the start of each Encounter, gain 1 {strengthen}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}


# TODO
const StartingThorns := {
	"canonical_name": "StartingThorns",
	"name": "Unnamed6",
	"description": "{artifact_name}: At the start of each Encounter, gain 4 {thorns}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const StartingConfidence := {
	"canonical_name": "StartingConfidence",
	"name": "Unnamed6",
	"description": "{artifact_name}: At the start of each Encounter, gain 10 {confidence}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ThickImmersion := {
	"canonical_name": "ThickImmersion",
	"name": "Unnamed7",
	"description": "{artifact_name}: At that start of each turn, gain 1 Immersion."\
		+ "This effects ends when your deck is reshuffled.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ThickStrength := {
	"canonical_name": "ThickStrength",
	"name": "Unnamed7",
	"description": "{artifact_name}: At that start of each turn, gain 1 {strengthen}."\
		+ "This effects and all added {strengthen} ends when your deck is reshuffled.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const UpgradedInterpretations := {
	"canonical_name": "UpgradedInterpretations",
	"name": "Unnamed8",
	"description": "{artifact_name}: Interpretation cards added to your deck receive 4 progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

# TODO
const UpgradedControl := {
	"canonical_name": "UpgradedControl",
	"name": "Unnamed9",
	"description": "{artifact_name}: Interpretation cards added to your deck receive 4 progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

# TODO
const UpgradedUnderstanding := {
	"canonical_name": "UpgradedUnderstanding",
	"name": "Unnamed10",
	"description": "{artifact_name}: Interpretation cards added to your deck receive 6 progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

# TODO
const UpgradedConcentration := {
	"canonical_name": "UpgradedConcentration",
	"name": "Unnamed11",
	"description": "{artifact_name}: Interpretation cards added to your deck receive 5 progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

# TODO
const ThinImmersion := {
	"canonical_name": "ThinImmersion",
	"name": "Unnamed12",
	"description": "{artifact_name}: Every time you reshuffle the deck, draw a card.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ResistDisempower := {
	"canonical_name": "ResistDisempower",
	"name": "Unnamed13",
	"description": "{artifact_name}: You cannot receive {disempower} anymore.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ResistPoison := {
	"canonical_name": "ResistPoison",
	"name": "Unnamed13",
	"description": "{artifact_name}: Any time you would receive {poison} reduce it by 1.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ResistBurn := {
	"canonical_name": "ResistBurn",
	"name": "Unnamed14",
	"description": "{artifact_name}: Any time you would receive {poison} reduce it by 1.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ResistVulnerable := {
	"canonical_name": "ResistVulnerable",
	"name": "Unnamed15",
	"description": "{artifact_name}: You cannot receive {vulnerable} anymore.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ImproveThorns := {
	"canonical_name": "ImproveThorns",
	"name": "Unnamed16",
	"description": "{artifact_name}: Any time you would gain {thorns}, gain 1 more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ImprovePoison := {
	"canonical_name": "ImprovePoison",
	"name": "Unnamed17",
	"description": "{artifact_name}: Any time you would inflict {poison}, inflict 1 more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ImproveBurn := {
	"canonical_name": "ImproveBurn",
	"name": "Unnamed18",
	"description": "{artifact_name}: Any time you would inflict {burn}, inflict 1 more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ThickExplosion := {
	"canonical_name": "ThickExplosion",
	"name": "Unnamed19",
	"description": "{artifact_name}: The first time you reshuffle your deck, "\
		+ "deal damage to all enemies equal to your discard pile.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const AccumulateEnemy := {
	"canonical_name": "AccumulateEnemy",
	"name": "RepressedFrustration",
	"description": "{artifact_name}: Increase your repressed Frustration by 60",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateRest := {
	"canonical_name": "AccumulateRest",
	"name": "RepressedLethargy",
	"description": "{artifact_name}: Increase your repressed Lethargy by 30",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateNCE := {
	"canonical_name": "AccumulateNCE",
	"name": "RepressedCuriosity",
	"description": "{artifact_name}: Increase your repressed Curiosity by 35",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateShop := {
	"canonical_name": "AccumulateShop",
	"name": "RepressLoneliness",
	"description": "{artifact_name}: Increase your repressed Loneliness by 15",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateElite := {
	"canonical_name": "AccumulateElite",
	"name": "RepressedForeboding",
	"description": "{artifact_name}: Increase your repressed Foreboding by 30",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateArtifact := {
	"canonical_name": "AccumulateArtifact",
	"name": "RepressedDesire",
	"description": "{artifact_name}: Increase your repressed Desire by 10",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

#TODO
const PowerHeal := {
	"canonical_name": "PowerHeal",
	"name": "Concentrated Rest",
	"description": "{artifact_name}: Whenever you play a concentration, {rest} for 2.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

const RARITIES := {
	"Common": [
		StartingHeal,
		FirstPowerAttack,
		StartingCards,
		AccumulateRest,
		StartingStrength,
		StartingConfidence,
		ThinImmersion,
		AccumulateEnemy,
		AccumulateRest,
		AccumulateNCE,
		AccumulateShop,
		AccumulateElite,
		AccumulateArtifact,
		
	],
	"Uncommon": [
		MaxHealth,
		RepressedEnemyBuff,
		ThickImmersion,
		ThickStrength,
		UpgradedInterpretations,
		UpgradedControl,
		UpgradedUnderstanding,
		UpgradedConcentration,
		ResistPoison,
		ResistBurn,
	],
	"Rare": [
		ResistDisempower,
		ResistVulnerable,
		ThickExplosion,
		PowerHeal,
	],
	# The artifacts in this list will only appear as rewards for defeating a boss
	"Boss": [

	],
	# The artifacts in this list will only appear during shop purchases
	"Shop": [

	],
	# The artifacts in this list will only appear if the archetype they're
	# linked to has been selected. Check in CardGroupDefinintions class
	"Archetype Restricted": [
		ImproveThorns,
		ImprovePoison,
		ImproveBurn,
		StartingThorns,
	]
}

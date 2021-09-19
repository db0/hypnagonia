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
	"name": "Unnamed1",
	"description": "{artifact_name}: max {health} inreased by 10",
	"icon": preload("res://assets/icons/artifacts/centaur-heart.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

const StartingHeal := {
	"name": "Unnamed2",
	"description": "{artifact_name}: {heal} for 2 when you encounter a Torment",
	"icon": preload("res://assets/icons/artifacts/glass-heart.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

const FirstPowerAttack := {
	"name": "Unnamed3",
	"description": "{artifact_name}: Your first {attack} each encounter is increased by 8",
	"icon": preload("res://assets/icons/artifacts/binoculars.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const StartingCards := {
	"name": "Unnamed4",
	"description": "{artifact_name}: At the start of each Encounter, draw 2 cards.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const RepressedEnemyBuff := {
	"name": "Fruscination",
	"description": "{artifact_name}: At the start of each Encounter,"\
		+ " Gain 1 {buffer} for each 40 Released Frustration you have.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const StartingImmersion := {
	"name": "Unnamed5",
	"description": "{artifact_name}: At the start of each Encounter, gain 1 {immersion}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}


# TODO
const StartingStrength := {
	"name": "Unnamed6",
	"description": "{artifact_name}: At the start of each Encounter, gain 1 {strengthen}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}


# TODO
const StartingThorns := {
	"name": "Unnamed6",
	"description": "{artifact_name}: At the start of each Encounter, gain 4 {thorns}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const StartingConfidence := {
	"name": "Unnamed6",
	"description": "{artifact_name}: At the start of each Encounter, gain 10 {confidence}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ThickImmersion := {
	"name": "Unnamed7",
	"description": "{artifact_name}: At that start of each turn, gain 1 Immersion."\
		+ "This effects ends when your deck is reshuffled.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ThickStrength := {
	"name": "Unnamed7",
	"description": "{artifact_name}: At that start of each turn, gain 1 {strengthen}."\
		+ "This effects and all added {strengthen} ends when your deck is reshuffled.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const UpgradedInterpretations := {
	"name": "Unnamed8",
	"description": "{artifact_name}: Interpretation cards added to your deck receive 4 progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

# TODO
const UpgradedControl := {
	"name": "Unnamed9",
	"description": "{artifact_name}: Interpretation cards added to your deck receive 4 progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

# TODO
const UpgradedUnderstanding := {
	"name": "Unnamed10",
	"description": "{artifact_name}: Interpretation cards added to your deck receive 6 progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

# TODO
const UpgradedConcentration := {
	"name": "Unnamed11",
	"description": "{artifact_name}: Interpretation cards added to your deck receive 5 progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

# TODO
const ThinImmersion := {
	"name": "Unnamed12",
	"description": "{artifact_name}: Every time you reshuffle the deck, draw a card.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ResistDisempower := {
	"name": "Unnamed13",
	"description": "{artifact_name}: You cannot receive {disempower} anymore.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ResistPoison := {
	"name": "Unnamed13",
	"description": "{artifact_name}: Any time you would receive {poison} reduce it by 1.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ResistBurn := {
	"name": "Unnamed14",
	"description": "{artifact_name}: Any time you would receive {poison} reduce it by 1.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ResistVulnerable := {
	"name": "Unnamed15",
	"description": "{artifact_name}: You cannot receive {vulnerable} anymore.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ImproveThorns := {
	"name": "Unnamed16",
	"description": "{artifact_name}: Any time you would gain {thorns}, gain 1 more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ImprovePoison := {
	"name": "Unnamed17",
	"description": "{artifact_name}: Any time you would inflict {poison}, inflict 1 more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ImproveBurn := {
	"name": "Unnamed18",
	"description": "{artifact_name}: Any time you would inflict {burn}, inflict 1 more.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const ThickExplosion := {
	"name": "Unnamed19",
	"description": "{artifact_name}: The first time you reshuffle your deck, "\
		+ "deal damage to all enemies equal to your discard pile.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
#		"amount": 0,
}

# TODO
const AccumulateEnemy := {
	"name": "RepressedFrustration",
	"description": "{artifact_name}: Increase your repressed Frustration by 60",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateRest := {
	"name": "RepressedLethargy",
	"description": "{artifact_name}: Increase your repressed Lethargy by 30",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateNCE := {
	"name": "RepressedCuriosity",
	"description": "{artifact_name}: Increase your repressed Curiosity by 35",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateShop := {
	"name": "RepressLoneliness",
	"description": "{artifact_name}: Increase your repressed Loneliness by 15",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateElite := {
	"name": "RepressedForeboding",
	"description": "{artifact_name}: Increase your repressed Foreboding by 30",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}
const AccumulateArtifact := {
	"name": "RepressedDesire",
	"description": "{artifact_name}: Increase your repressed Desire by 10",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
#		"amount": 0,
}

#TODO
const PowerHeal := {
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

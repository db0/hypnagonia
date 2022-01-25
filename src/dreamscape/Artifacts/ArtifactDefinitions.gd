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
	"description": "{artifact_name}: max {anxiety} inreased by {health_amount}",
	"icon": preload("res://assets/icons/artifacts/centaur-heart.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"health_amount": 10
	},
}

const StartingHeal := {
	"canonical_name": "StartingHeal",
	"name": "Hot Water Bottle",
	"description": "{artifact_name}: At the start of each Ordeal, {relax} for {heal_amount}.",
	"icon": preload("res://assets/icons/artifacts/water-flask.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"heal_amount": 2
	},
}

const EndingHeal := {
	"canonical_name": "EndingHeal",
	"name": "Coffee Beans",
	"description": "{artifact_name}: At the end of each Ordeal, {relax} for {heal_amount}.",
	"icon": preload("res://assets/icons/artifacts/coffee-beans.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Starting",
	"amounts": {
		"heal_amount": 6
	},
}

const FirstPowerAttack := {
	"canonical_name": "FirstPowerAttack",
	"name": "Rosetta Stone",
	"description": "{artifact_name}: Your first {damage} each encounter is increased by {effect_amount}",
	"icon": preload("res://assets/icons/artifacts/stone-tablet.png"),
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


const UpgradedAction := {
	"canonical_name": "UpgradedAction",
	"name": "UpgradedAction",
	"description": "{artifact_name}: Action cards added to your deck receive {progress_amount} progress.",
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
	"description": "{artifact_name}: Control cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 4
	},
}


const UpgradedUnderstanding := {
	"canonical_name": "UpgradedUnderstanding",
	"name": "Laser Pointer",
	"description": "{artifact_name}: Understanding cards added to your deck receive {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/target-laser.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
	"amounts": {
		"progress_amount": 6
	},
}


const UpgradedConcentration := {
	"canonical_name": "UpgradedConcentration",
	"name": "UpgradedConcentration",
	"description": "{artifact_name}: Concentration cards added to your deck receive {progress_amount} progress.",
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
	"description": "{artifact_name}: Every time you reshuffle the deck, draw {draw_amount} card.\n"\
			+ "This effect stops for the turn after you draw the same card three times.",
	"icon": preload("res://assets/icons/artifacts/light-backpack.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
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
	"name": "Encyclopedia",
	"description": "{artifact_name}: Any time you would receive {poison} reduce it by {alteration_amount}.",
	"icon": preload("res://assets/icons/artifacts/book-pile.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
}


const ResistBurn := {
	"canonical_name": "ResistBurn",
	"name": "ResistEnvy",
	"description": "{artifact_name}: Any time you would receive {burn} reduce it by {alteration_amount}.",
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
	"name": "ImproveDoubt",
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
	"name": "Fancy Lipstick",
	"description": "{artifact_name}: Any time you would inflict {burn}, inflict {alteration_amount} more.",
	"icon": preload("res://assets/icons/artifacts/lipstick.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
	"amounts": {
		"alteration_amount": 1
	},
}


const ThickExplosion := {
	"canonical_name": "ThickExplosion",
	"name": "ThickExplosion",
	"description": "{artifact_name}: The first time you reshuffle your deck because it run out of cards, "\
		+ "deal damage to all enemies equal to your discard pile.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
}


const AccumulateEnemy := {
	"canonical_name": "AccumulateEnemy",
	"name": "Repressed Frustration",
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
	"name": "Repressed Lethargy",
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
	"name": "Repressed Curiosity",
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
	"name": "Repress Loneliness",
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
	"name": "Repressed Foreboding",
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
	"name": "Repressed Desire",
	"description": "{artifact_name}: Increase your repressed Desire by {pathos_amount}",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
	"amounts": {
		"pathos_amount": 10
	},
}

const PowerHeal := {
	"canonical_name": "PowerHeal",
	"name": "Concentrated Rest",
	"description": "{artifact_name}: Whenever you play a concentration, {relax} for {healing_amount}.",
	"icon": preload("res://assets/icons/artifacts/nested-hearts.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Rare",
	"amounts": {
		"healing_amount": 2
	},
}

const PerturbationHeal := {
	"canonical_name": "PerturbationHeal",
	"name": "A taste for liquorice",
	"description": "{artifact_name}: At the start of each Ordeal, {relax} for {heal_amount} per Perturbation in your deck.",
	"icon": preload("res://assets/icons/artifacts/pretzel.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"heal_amount": 1
	},
}

const ImproveImpervious := {
	"canonical_name": "ImproveImpervious",
	"name": "Pet Eel",
	"description": "{artifact_name}: At the start of the dreamer's turn, {impervious} is halved instead of removed.",
	"icon": preload("res://assets/icons/artifacts/eel.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
}

const ImproveFortify := {
	"canonical_name": "ImproveFortify",
	"name": "Ataraxia",
	"description": "{artifact_name}: Whenever you lose {fortify}, gain that many stacks {armor}.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Uncommon",
}

const PorcelainDoll := {
	"canonical_name": "PorcelainDoll",
	"name": "Porcelain Doll",
	"description": "{colour} {artifact_name} ({progress}): The next {threshold} {card_type} cards you gain, are used to finish colouring the doll.",
	"icon": preload("res://assets/icons/artifacts/person.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
}

const RedWave := {
	"canonical_name": "RedWave",
	"name": "Inquisite Vibes",
	"description": "{artifact_name}: At the start of your turn, if your hand has {threshold}+ {attack_card} cards, gain {defence_amount} {defence}",
	"icon": preload("res://assets/icons/artifacts/waves_red.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"threshold": 4,
		"defence_amount": 8
	},
}

const BlueWave := {
	"canonical_name": "BlueWave",
	"name": "Cool Vibes",
	"description": "{artifact_name}: At the start of your turn, if your hand has {threshold}+ {skill_card} cards, deal {damage_amount} {damage} to all Torments.",
	"icon": preload("res://assets/icons/artifacts/waves_blue.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"threshold": 4,
		"damage_amount": 5
	},
}

const PurpleWave := {
	"canonical_name": "PurpleWave",
	"name": "Chill Vibes",
	"description": "{artifact_name}: At the start of your turn, if your hand has {threshold}+ {understanding_card} cards, {relax} for {heal_amount}.",
	"icon": preload("res://assets/icons/artifacts/waves_purple.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Common",
	"amounts": {
		"threshold": 3,
		"heal_amount": 4,
	},
}

const ProgressiveImmersion := {
	"canonical_name": "ProgressiveImmersion",
	"name": "Progressive Immersion",
	"description": "{artifact_name}: You have {immersion_amount} extra {immersion} per turn.\n"\
			+ "You cannot progress cards by playing them during ordeals anymore.",
	"icon": preload("res://assets/icons/artifacts/boss-key.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
	},
}

const BossCardDraw := {
	"canonical_name": "BossCardDraw",
	"name": "Squishy Brain Toy",
	"description": "{artifact_name}: Draw {draw_amount} card at the start of each turn",
	"icon": preload("res://assets/icons/artifacts/boss-key.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"draw_amount": 1,
	},
}

const RandomUpgrades := {
	"canonical_name": "RandomUpgrades",
	"name": "20-sided die",
	"description": "{artifact_name}: You have {immersion_amount} extra {immersion} per turn.\n"\
			+ "Your card upgrades are chosen randomly.",
	"icon": preload("res://assets/icons/artifacts/dice-twenty-faces-twenty.png"),
	"context": EffectContext.BATTLE,
	"rarity": "Boss",
	"amounts": {
		"immersion_amount": 1,
	},
}

const BetterRareChance := {
	"canonical_name": "BetterRareChance",
	"name": "The Gruyere of Insight",
	"description": "{artifact_name}: Your chance of finding Rare cards is doubled.",
	"icon": preload("res://assets/icons/artifacts/cheese-wedge.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"rare_multiplier": 2,
	},
}

const BossDraft := {
	"canonical_name": "BossDraft",
	"name": "Cool Draft Beer",
	"description": "{artifact_name}: Choose one of your archetypes. "\
			+ "Get {draft_amount} card draft choices from it. They all start with {progress_amount} progress.",
	"icon": preload("res://assets/icons/artifacts/beer-stein.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Boss",
	"amounts": {
		"draft_amount": 5,
		"progress_amount": 4,
	},
}

const FreeCard := {
	"canonical_name": "FreeCard",
	"name": "A Nice Warm Meal",
	"description": "{artifact_name}: A random card in your deck, costing 1 or more immersion, becomes free.",
	"icon": preload("res://assets/icons/artifacts/camp-cooking-pot.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
}

const AddAlphaTag := {
	"canonical_name": "AddAlphaTag",
	"name": "Crystal Ball",
	"description": "{artifact_name}: Choose a card in your deck. It gains the {alpha} tag, so always starts at the top of the deck.",
	"icon": preload("res://assets/icons/artifacts/crystal-ball.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
}

const AddOmegaTag := {
	"canonical_name": "AddOmegaTag",
	"name": "Jigsaw Piece",
	"description": "{artifact_name}: Choose a card in your deck. It gains the {omega} tag, so always starts at the bottom of the deck.",
	"icon": preload("res://assets/icons/artifacts/jigsaw-piece.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
}

const AddFrozenTag := {
	"canonical_name": "AddFrozenTag",
	"name": "Earworm",
	"description": "{artifact_name}: Choose a card in your deck. It gains the {frozen} tag, so it isn't discarded from your hand.",
	"icon": preload("res://assets/icons/artifacts/leeching-worm.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Rare",
}

const IncreaseRandomDamage := {
	"canonical_name": "IncreaseRandomDamage",
	"name": "Masterwork Looking Glass",
	"description": "{artifact_name}: A random card dealing {damage} in your deck, will increase its {damage} by 1.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
}

const IncreaseRandomDefence := {
	"canonical_name": "IncreaseRandomDefence",
	"name": "Fancy Nail Coat",
	"description": "{artifact_name}: A random card giving {defence} in your deck, will increase its {defence} by 1.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Common",
}

const IncreaseConfusionStacks := {
	"canonical_name": "IncreaseConfusionStacks",
	"name": "IncreaseConfusionStacks",
	"description": "{artifact_name}: Choose a {disempower} card in your deck. Increase the amount of {disempower} stacks it is inflicting by 1.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Uncommon",
}

const IncreaseImmersionGain := {
	"canonical_name": "IncreaseImmersionGain",
	"name": "IncreaseImmersionGain",
	"description": "{artifact_name}: Choose an {immersion} card in your deck. Increase the amount of {immersion} stacks it is providing by 1.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Rare",
}

const BetterArtifactChance := {
	"canonical_name": "BetterArtifactChance",
	"name": "Supportive Plushie",
	"description": "{artifact_name}: The quality of the curios your find is increased.",
	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
	"context": EffectContext.OVERWORLD,
	"rarity": "Encounter",
	"amounts": {
		"uncommon_multiplier": 1.5,
		"rare_multiplier": 3,
	},
}

## TODO. Scipt base doesn't exist yet
#const DoubleMemory := {
#	"canonical_name": "DoubleMemory",
#	"name": "Memento",
#	"description": "{artifact_name}: Double the effect of a random memory",
#	"icon": preload("res://assets/icons/artifacts/perspective-dice-six-faces-random.png"),
#	"context": EffectContext.OVERWORLD,
#	"rarity": "Rare",
#}

# Generic artifacts which have a chance to appear in any playthrough
const GENERIC := [
	StartingHeal,
	StartingStrength,
	StartingConfidence,
	StartingCards,
	StartingImmersion,
	FirstPowerAttack,
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
	UpgradedAction,
	UpgradedControl,
	UpgradedUnderstanding,
	UpgradedConcentration,
	ResistPoison,
	ResistBurn,
	ResistDisempower,
	ResistVulnerable,
	PowerHeal,
	RedWave,
	BlueWave,
	PurpleWave,
	FreeCard,
	AddAlphaTag,
	AddOmegaTag,
	AddFrozenTag,
	IncreaseRandomDamage,
	IncreaseRandomDefence,
	
]

# Archetype-specific artifacts which only appear in runs in which
# Their tied archetype is selected.
const ARCHETYPE := [
	ImproveThorns,
	ImprovePoison,
	ImproveBurn,
	ImproveImpervious,
	ImproveFortify,
	StartingThorns,
	EndingHeal,
	IncreaseConfusionStacks,
	IncreaseImmersionGain,
]

# These artifacts are only found in non-combat encounters
const ENCOUNTER := [
	PorcelainDoll,
	BetterRareChance,
	BetterArtifactChance,
	PerturbationHeal,
]

const BOSS := [
	ProgressiveImmersion,
	RandomUpgrades,
	BossCardDraw,
	BossDraft,
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
							and not artifact.canonical_name in excluded_artifacts:
						ret_dict[rarity].append(artifact)
		"boss":
			ret_dict["Boss"] = []
			for artifact in BOSS:
				if artifact.rarity == "Boss"\
						and not artifact.canonical_name in excluded_artifacts:
					ret_dict["Boss"].append(artifact)
	return(ret_dict)

static func get_artifact_bbcode_format(artifact_definition: Dictionary) -> Dictionary:
	var format := {}
	format['artifact_name'] = artifact_definition.name
	for key in artifact_definition.get('amounts', {}):
		format[key] = artifact_definition.amounts[key]
	return(format)

static func get_complete_artifacts_array() -> Array:
	return(GENERIC + ARCHETYPE + ENCOUNTER + BOSS)

static func find_artifact_from_canonical_name(artifact_canonical_name: String):
	for artifact_def in get_complete_artifacts_array():
		if artifact_def.canonical_name == artifact_canonical_name:
			return(artifact_def)

static func find_artifact_from_name(artifact_name: String):
	for artifact_def in get_complete_artifacts_array():
		if artifact_def.name == artifact_name:
			return(artifact_def)

static func artifact_exists(artifact_name: String) -> bool:
	if find_artifact_from_canonical_name(artifact_name):
		return(true)
	return(false)

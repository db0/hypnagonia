# The definitions of the various archetypes.
# Each archetype has the fields that define which cards are available
# in the starting deck, as well as in the draft card pool presented
# to the player
# It also list all other definitions needed, such as restricted artifacts
# tags, icons etc.
class_name Archetypes
extends Reference

const FLYER:= {
	"Anxiety": 5,
	"Icon": preload("res://assets/archetypes/flyer.png"),
	"Tags": [
		Terms.ACTIVE_EFFECTS.impervious.name,
		Terms.GENERIC_TAGS.relax.name,
	],
	"Artifacts": [
		
	],
	"Perturbations": [
		
	],
	"Basic": [
		"Out of Reach",
		"Interpretation",
		"Confidence",
	],
	"Common": [
		"Dive-in",
		"Overview",
		"Drag and Drop",
		"Loop de loop",
		"Rapid Encirclement",
		"Dodge",
	],
	"Uncommon": [
		"Whirlwind",
		"Safety of Air",
		"Swoop",
		"Barrel Through",
		"Running Start",
		"Introspection",
	],
	"Rare": [
		"Master of Skies",
		"Zen of Flight",
	]
}

const MAD_SCIENTIST := {
#	"Icon": preload("res://icon.png"),
	"Tags": [
		Terms.GENERIC_TAGS.spark.name,
		Terms.GENERIC_TAGS.slumber.name,
		Terms.ACTIVE_EFFECTS.buffer.name,
	],
	"Artifacts": [
		
	],
	"Perturbations": [
		"Apathy",
	],
	"Basic": [
		"Confidence",
		"Change of Mind",
		"Change of Mind",
	],
	"Common": [
		"Recall",
		"Vexing Concept",
		"unnamed_card_1",
		"unnamed_card_1",
		"Hyperfocus",
		"Misunderstood",
		"Misplaced Research",
	],
	"Uncommon": [
		"Brilliance",
		"Rapid Theorizing",
		"Wild Inspiration",
		"Detect Weaknesses",
		"Death Ray",
		"Unconventional",
		"Endless Posibilities",
		"A Fine Specimen",
		"Mania",
	],
	"Rare": [
		"It's alive!",
		"Eureka!",
		"I'll Show Them All",
		"Excogitate",
	],
}

const WARRIOR:= {
	"Anxiety": 5,
	"Icon": preload("res://icon.png"),
	"Tags": [],
	"Artifacts": [
		
	],
	"Perturbations": [
		
	],
	"Basic": [
		"War Paint",
	],
	"Common": [
		"War Paint",
	],
	"Uncommon": [
	],
	"Rare": [],
	"_is_inactive": true
}

const RUNNER := {
	"Anxiety": 5,
	"Icon": preload("res://icon.png"),
	"Tags": [],
	"Artifacts": [
		
	],
	"Perturbations": [
		
	],
	"Basic": [
	],
	"Common": [
		"Rapid Encirclement",
	],
	"Uncommon": [
		"Barrel Through",
	],
	"Rare": [],
	"_is_inactive": true
}


const FEARLESS:= {
	"Anxiety": 5,
#	"Icon": preload("res://icon.png"),
	"Tags": [
		Terms.ACTIVE_EFFECTS.poison.name,
		Terms.ACTIVE_EFFECTS.fortify.name,
		Terms.GENERIC_TAGS.risky.name,
	],
	"Artifacts": [
		ArtifactDefinitions.ImprovePoison
	],
	"Perturbations": [
		
	],
	"Basic": [
		"Confidence",
		"Confidence",
		"Nothing to Fear",
	],
	"Common": [
		"Intimidate",
		"Towering Presence",
		"Audacity",
		"Solid Understanding",
		"Confident Slap",
		"Cocky Retort",
	],
	"Uncommon": [
		"Nothing to Fear",
		"Barrel Through",
		"Cheeky Approach",
		"No Second Thoughts",
		"High Morale",
	],
	"Rare": [
		"Laugh at Danger",
		"Unassailable",
		"Boast",
	]
}
	# Archetypes: Self-harm
const COWARD := {
	"Anxiety": -5,
	"Icon": preload("res://icon.png"),
	"Tags": [],
	"Artifacts": [
		
	],
	"Perturbations": [
		
	],
	"_is_inactive": true
}


const RUBBER_CHICKEN := {
#	"Icon": preload("res://icon.png"),
	"Tags": [
		Terms.ACTIVE_EFFECTS.disempower.name,
		Terms.ACTIVE_EFFECTS.buffer.name,
	],
	"Artifacts": [
		
	],
	"Perturbations": [
		
	],
	"Basic": [
		"Noisy Whip",
		"Noisy Whip",
		"Noisy Whip",
	],
	"Common": [
		"Confounding Movements",
		"Mania",
		"Ventriloquism",
		"unnamed_card_3",
		"A Thousand Squeaks"
	],
	"Uncommon": [
		"Rubber Eggs",
		"The Joke",
		"unnamed_card_2",
		"Absurdity Unleashed",
		"Gummiraptor",
	],
	"Rare": [
		"Nunclucks",
		"Utterly Ridiculous",
		"The Whippy-Flippy",
	]
}


const ABUSIVE_RELATIONSHIP := {
	"Anxiety": -5,
#		"Icon": preload("res://icon.png"),
	"Tags": [
		Terms.GENERIC_TAGS.purpose.name,
		Terms.GENERIC_TAGS.exert.name,
	],
	"Artifacts": [
		
	],
	"Perturbations": [
		
	],
	"Basic": [
		"Inner Justice",
		"Interpretation",
		"Confidence",
	],
	"Common": [
		"unnamed_card_7",
		"unnamed_card_8",
		"unnamed_card_9",
		"Could Be Worse",
		"Dismissal",
		"unnamed_card_12",
		"unnamed_card_13",
		"Is it my fault?",
	],
	"Uncommon": [
		"unnamed_card_6",
		"unnamed_card_15",
		"unnamed_card_16",
		"Self-Deception",
		"Rancor",
		"Lash-out",
		"unnamed_card_17",
		"unnamed_card_18",
	],
	"Rare": [
		"The Happy Place",
		"Tolerance",
		"Catatonia",
		"unnamed_card_17"
	]
}

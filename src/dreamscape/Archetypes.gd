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
		"Out of Reach",
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
		"Interpretation",
		"Change of Mind",
	],
	"Common": [
		"Recall",
		"unnamed_card_5",
		"unnamed_card_1",
		"Change of Mind"
	],
	"Uncommon": [
		"Brilliance",
		"Rapid Theorizing",
		"Wild Inspiration",
		"Detect Weaknesses"
	],
	"Rare": [
		"It's alive!",
		"Eureka!",
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
		"Interpretation",
		"Interpretation",
		"Noisy Whip",
	],
	"Common": [
		"Confounding Movements",
		"Noisy Whip",
		"Headless",
		"Ventriloquism",
		"unnamed_card_1",
		"unnamed_card_3",
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
		"unnamed_card_11",
		"Dismissal",
		"unnamed_card_12"
	],
	"Uncommon": [
		"unnamed_card_6",
		"Self-Deception",
		"Rancor",
	],
	"Rare": [
		"The Happy Place",
	]
}

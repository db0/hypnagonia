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
	"Starting Cards": [
		"Out of Reach",
		"Interpretation",
		"Confidence",
	],
	"Commons": [
		"Out of Reach",
		"Dive-in",
		"Overview",
		"Drag and Drop",
		"Loop de loop",
		"Rapid Encirclement",
	],
	"Uncommons": [
		"Whirlwind",
		"Safety of Air",
		"Swoop",
		"Barrel Through",
		"Running Start",
	],
	"Rares": [
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
	"Starting Cards": [
		"Confidence",
		"Interpretation",
		"Change of Mind",
	],
	"Commons": [
		"Recall",
		"unnamed_card_5",
		"unnamed_card_1",
		"Change of Mind"
	],
	"Uncommons": [
		"Brilliance",
		"Rapid Theorizing",
		"Wild Inspiration",
		"Detect Weaknesses"
	],
	"Rares": [
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
	"Starting Cards": [
		"War Paint",
	],
	"Commons": [
		"War Paint",
	],
	"Uncommons": [
	],
	"Rares": [],
	"_is_inactive": true
}

const RUNNER := {
	"Anxiety": 5,
	"Icon": preload("res://icon.png"),
	"Tags": [],
	"Artifacts": [
		
	],
	"Starting Cards": [
	],
	"Commons": [
		"Rapid Encirclement",
	],
	"Uncommons": [
		"Barrel Through",
	],
	"Rares": [],
	"_is_inactive": true
}


const FEARLESS:= {
		"Anxiety": 5,
#		"Icon": preload("res://icon.png"),
		"Tags": [
			Terms.ACTIVE_EFFECTS.poison.name,
			Terms.ACTIVE_EFFECTS.fortify.name,
			Terms.GENERIC_TAGS.risky.name,
		],
		"Artifacts": [
			
		],
		"Starting Cards": [
			"Confidence",
			"Confidence",
			"Nothing to Fear",
		],
		"Commons": [
			"Intimidate",
			"Towering Presence",
			"Audacity",
			"Solid Understanding",
			"Confident Slap",
			"Cocky Retort",
		],
		"Uncommons": [
			"Nothing to Fear",
			"Barrel Through",
			"Cheeky Approach",
			"No Second Thoughts",
			"High Morale",
		],
		"Rares": [
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
	"Starting Cards": [
		"Interpretation",
		"Interpretation",
		"Noisy Whip",
	],
	"Commons": [
		"Confounding Movements",
		"Noisy Whip",
		"Headless",
		"Ventriloquism",
		"unnamed_card_1",
		"unnamed_card_3",
	],
	"Uncommons": [
		"Rubber Eggs",
		"The Joke",
		"unnamed_card_2",
		"Absurdity Unleashed",
		"Gummiraptor",
	],
	"Rares": [
		"Nunclucks",
		"Utterly Ridiculous",
	]
}


const ABUSIVE_RELATIONSHIP := {
	"Anxiety": -5,
#		"Icon": preload("res://icon.png"),
	"Tags": [
		Terms.GENERIC_TAGS.purpose.name,
	],
	"Artifacts": [
		
	],
	"Starting Cards": [
		"Inner Justice",
	],
	"Commons": [],
	"Uncommons": [],
	"Rares": []
}

class_name CardGroupDefinitions
extends Reference

const SET = "Core Set"

const EGO := {
	# Archetypes: Untouchable/Calm
	"Flyer": {
		"Anxiety": 5,
		"Icon": "res://icon.png",
		"Starting Cards": [
			"Out of Reach",
			"Assault",
			"Confidence",
		],
		"Commons": [
			"Out of Reach",
			"Dive-in",
			"Overview",
			"Drag and Drop",
			"Loop de loop",
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
	},
	# Archetype: 
	"Warrior": {
		"Anxiety": 5,
		"Icon": "res://icon.png",
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
	},
	# Archetype: 
	"Runner": {
		"Anxiety": 5,
		"Icon": "res://icon.png",
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
	},
}

const DISPOSITION := {
	# Archetypes: Confidence/Doubt
	"Fearless": {
		"Anxiety": 5,
		"Icon": "res://icon.png",
		"Starting Cards": [
			"Confidence",
			"Confidence",
			"Nothing to Fear",
		],
		"Commons": [
			"Intimidate",
			"Towering Presence",
			"Courage",
			"Solid Understanding",
			"Confident Slap",
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
	},
	# Archetypes: Self-harm
	"Coward": {
		"Anxiety": -5,
		"Icon": "res://icon.png",
		"_is_inactive": true
	}
}

const INSTRUMENT := {
	# Archetype: Confusion
	"Rubber Chicken": {
		"Icon": "res://icon.png",
		"Starting Cards": [
			"Assault",
			"Assault",
			"Noisy Whip",
			"Courage",
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
		],
		"Rares": [
			"Nunclucks",
			"Utterly Ridiculous",
		]
	},
}

const INJUSTICE := {
	"Abusive Relationship": {
		"Anxiety": -5,
		"Icon": "res://icon.png",
		"Starting Cards": [
			"Inner Justice",
		],
		"Commons": [],
		"Uncommons": [],
		"Rares": []
	},
}

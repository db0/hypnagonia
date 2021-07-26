class_name CardGroupDefinitions
extends Reference

const SET = "Core Set"

const EGO := {
	# Archetypes: Untouchable/Calm
	"Flyer": {
		"Anxiety": 5,
		"Icon": preload("res://assets/archetypes/flyer.png"),
		"Tags": [
			Terms.ACTIVE_EFFECTS.impervious.name,
			Terms.GENERIC_TAGS.relax.name,
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
	},
	"Mad Scientist": {
#		"Icon": preload("res://icon.png"),
		"Tags": [
			Terms.GENERIC_TAGS.spark.name,
			Terms.ACTIVE_EFFECTS.buffer.name,
		],
		"Starting Cards": [
			"Interpretation",
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
			"Inspiration",
			"Detect Weaknesses"
		],
		"Rares": [
			"It's alive!",
			"Eureka!",
		],
		"_is_inactive": true
	},
	# Archetype: 
	"Warrior": {
		"Anxiety": 5,
		"Icon": preload("res://icon.png"),
		"Tags": [],
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
		"Icon": preload("res://icon.png"),
		"Tags": [],
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
#		"Icon": preload("res://icon.png"),
		"Tags": [
			Terms.ACTIVE_EFFECTS.poison.name,
			Terms.ACTIVE_EFFECTS.fortify.name,
			Terms.GENERIC_TAGS.risky.name,
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
	},
	# Archetypes: Self-harm
	"Coward": {
		"Anxiety": -5,
		"Icon": preload("res://icon.png"),
		"Tags": [],
		"_is_inactive": true
	}
}

const INSTRUMENT := {
	# Archetype: Confusion
	"Rubber Chicken": {
#		"Icon": preload("res://icon.png"),
		"Tags": [
			Terms.ACTIVE_EFFECTS.disempower.name,
			Terms.ACTIVE_EFFECTS.buffer.name,
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
	},
}

const INJUSTICE := {
	"Abusive Relationship": {
		"Anxiety": -5,
#		"Icon": preload("res://icon.png"),
		"Tags": [
			Terms.GENERIC_TAGS.purpose.name,
		],
		"Starting Cards": [
			"Inner Justice",
		],
		"Commons": [],
		"Uncommons": [],
		"Rares": []
	},
}

const ARCHETYPES:= {
	"Ego": {
		"Dictionary": EGO, 
		"Description":"Ego represents the way your dreamer perceives themselves in this recurrent dream.",
	},
	"Disposition": {
		"Dictionary": DISPOSITION, 
		"Description": "The dreamer's disposition is a representation of their inner turmoil.",
	},
	"Instrument": {
		"Dictionary": INSTRUMENT, 
		"Description": "The instrument choice is a dreamer's own manifestation of their strongest trait.",
	},
	"Injustice": {
		"Dictionary": INJUSTICE, 
		"Description": "An injustice is the reason why your dreamer has been captured in this nightmare realm.\n"\
			+ "Each injustice comes with its own completion goal. Once that is achieved, your dreamer\n"\
			+ " will have had a psychological breakthrough which  will be able to break out of their recurrent dreams.",
	},
}

static func get_archetype_value(archetype: String, key: String):
	for type in ARCHETYPES:
		if ARCHETYPES[type]["Dictionary"].has(archetype):
			return(ARCHETYPES[type]["Dictionary"][archetype].get(key))


static func get_all_archetypes_list(type: String) -> Array:
	var valid_archetypes_list := []
	for archetype in ARCHETYPES[type]["Dictionary"]:
		if not ARCHETYPES[type]["Dictionary"][archetype].get("_is_inactive"):
			valid_archetypes_list.append(archetype)
	return(valid_archetypes_list)


static func get_complete_archetype_list() -> Array:
	var valid_archetypes_list := []
	for type in ARCHETYPES:
		for archetype in ARCHETYPES[type]["Dictionary"]:
			if not ARCHETYPES[type]["Dictionary"][archetype].get("_is_inactive"):
				valid_archetypes_list.append(archetype)
	return(valid_archetypes_list)


static func get_all_cards_in_archetype(archetype) -> Array:
	var all_cards := []
	for card_rarity in ["Starting Cards","Commons","Uncommons","Rares"]:
		all_cards += get_archetype_value(archetype,card_rarity)
	return(all_cards)

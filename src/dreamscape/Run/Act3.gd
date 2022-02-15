class_name Act3
extends Act

"""
The enemies list, is a list of dictionaries, which define which enemy to spawn
in each encounter. You can also optionally specified starting effects
for each enemy, as well as a specific intent to start with. The intent
Should be a valid index within the intents available for that enemy

As an example:

		"enemies": {
			"hard": [
				{
					"definition": EnemyDefinitions.THE_LAUGHING_ONE,
					"starting_intent": 1
					"health_modifier": -10
					"starting_defence": 10
					"starting_effects": [
						{
							"name": Terms.ACTIVE_EFFECTS.vulnerable.name,
							"stacks": 5
						}
					]
				},
			]
		}
"""

const Unnamed1 = {
	"journal_description":\
		'flavour [url={torment_tag1}]tbd[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.UNNAMED1,
				"health_modifier": -40,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.UNNAMED1,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.UNNAMED1,
				"health_modifier": +20,
			},
		],
	},
#	"journal_art": preload("res://assets/journal/torments/traffic_jam.jpeg"),
}

const ENEMIES = [
	Unnamed1,
]

const Jumbletron = {
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Elites/Jumbletron.tscn")],
	"journal_description":\
		'I had enterred a room which seemed to be an amalgram of a lot of different encounters I had.\n'\
		+ "I couldn't find the exit anymore.",
	"journal_reward":\
		'Somehow I figured out the correct organization to make it out.',
#	'journal_art': preload("res://assets/journal/advanced/dentist.jpeg"),
}

const ELITES = [
]

const FearAndPhobia = {
	"scenes": [
		preload("res://src/dreamscape/CombatElements/Enemies/Bosses/FearBoss.tscn"),
		preload("res://src/dreamscape/CombatElements/Enemies/Bosses/PhobiaBoss.tscn"),
	],
	"journal_description":\
		"I barely dare to even recall what I dreamt next. Imagine your worst phobia in the scene of your greatest fear...",
	"journal_reward":\
		"That was finally it! When I opened my eyes, I felt the most relieved I've ever been.",
#	'journal_art': preload("res://assets/journal/advanced/surreality.jpeg"),
}

const BOSSES := {
	"Fear_and_Phobia": FearAndPhobia
}


const NCE := {
	"easy": {
		"ArtifactReward": preload("res://src/dreamscape/Run/NCE/Act3/ArtifactReward.gd"),
	},
	"risky": {
		"MultipleDestroys": preload("res://src/dreamscape/Run/NCE/Act3/MultipleDestroys.gd"),
	}
}

const LOCKED_NCE := {
	"Recurrence3": {
		"nce": preload("res://src/dreamscape/Run/NCE/AllActs/Recurrence.gd"),
		"chance_multiplier": 4,
	},
}

static func get_act_name() -> String:
	return(Act.ACT_NAMES.Act3)

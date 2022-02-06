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

const TrafficJam = {
	"journal_description":\
		'I started dreaming about my [url={torment_tag1}]daily commute traffic jam[/url].',
	"journal_reward":\
		'Through overcoming that weird experience, I felt wiser.',
	"enemies": {
		"easy": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
		],
		"medium": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
			},
		],
		"hard": [
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
			{
				"definition": EnemyDefinitions.TRAFFICJAM,
				"health_modifier": -20,
			},
		],
	},
	"journal_art": preload("res://assets/journal/torments/traffic_jam.jpeg"),
}

const ENEMIES = [
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

const SurrealBoss = {
	"scenes": [preload("res://src/dreamscape/CombatElements/Enemies/Bosses/SurrealBoss.tscn")],
	"journal_description":\
		"The next dream was so incomprehensible, just trying to remember it makes my head hurt",
	"journal_reward":\
		"I don't claim to understand what I was seeing, [url=boss_card_draft]but eventually that vision faded.[/url]"\
		+ "but my mind was open to [url=boss_artifact]many new possibilities[/url].",
	'journal_art': preload("res://assets/journal/advanced/surreality.jpeg"),
}

const BOSSES := {
	"Surreality": SurrealBoss
}


const NCE := {
	"easy": {
	},
	"risky": {
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
